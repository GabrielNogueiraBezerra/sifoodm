import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../../app_controller.dart';
import '../../../../../../../../shared/client/custom_dio/custom_dio.dart';
import '../../../../../../../../shared/models/adicional.dart';
import '../../../../../../../../shared/models/produto.dart';
import '../../../../../../../../shared/repositories/backend/produtos/adicionais_repository.dart';
import '../../../../../../../../shared/utils/utils.dart';
import '../../insere_produto_controller.dart';
import 'widgets/insere_item.dart';

part 'insere_adicional_controller.g.dart';

@Injectable()
class InsereAdicionalController = _InsereAdicionalControllerBase
    with _$InsereAdicionalController;

abstract class _InsereAdicionalControllerBase with Store implements Disposable {
  final AppController _appController = Modular.get<AppController>();

  InsereProdutoController insereProdutoController =
      Modular.get<InsereProdutoController>();

  TextEditingController textEditingControllerPesquisaAdicionais =
      TextEditingController();

  @observable
  dynamic busca;

  @observable
  int page = 1;

  @observable
  bool loading = false;

  @observable
  List<Produto> adicionais;

  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    textEditingControllerPesquisaAdicionais.dispose();
    scrollController.dispose();
  }

  @action
  Future<void> addItem(
      Produto produto, Adicional adicional, int indexSelecionado) async {
    await showDialog(
      context: Modular.navigatorKey.currentState.overlay.context,
      builder: (_) {
        return InsereItem(
          produto: produto,
          adicional: adicional,
          indexSelecionado: indexSelecionado,
        );
      },
    );

    buscarAdicionais();
  }

  @action
  Future<void> adicionaNovaPagina() async {
    try {
      try {
        if (page < busca["count"]) {
          loading = true;
          page++;

          var _repository = AdicionaisRepository(Modular.get<CustomDio>());

          _repository.data = {};
          _repository.data["codpro"] =
              insereProdutoController.produto.codPro.toString();
          _repository.data["codemp"] = _appController.empresa.codEmp.toString();
          _repository.data["page"] = page.toString();
          _repository.data["pesquisa"] =
              textEditingControllerPesquisaAdicionais.text;

          busca = await _repository.index();

          if (busca != null) {
            adicionais = List.from(adicionais)
              ..addAll(((busca["rows"] as List).isEmpty)
                  ? []
                  : List<Produto>.from(busca["rows"]
                      .map((produto) => Produto.fromMap(produto))));
          }
          loading = false;
        }
      } on DioError catch (e) {
        loading = false;
        page--;
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      loading = false;
      page--;
      Utils().showAlert(mensagem: e.toString());
    }
  }

  _InsereAdicionalControllerBase() {
    buscarAdicionais();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        adicionaNovaPagina();
      }
    });
  }

  double get totalAdicionais {
    var total = 0.0;
    if (insereProdutoController.adicionaisSelecionados != null) {
      for (var adicional in insereProdutoController.adicionaisSelecionados) {
        total += adicional.total;
      }
    }

    return total;
  }

  @action
  Future<void> buscarAdicionais() async {
    try {
      try {
        loading = true;
        page = 1;

        var _repository = AdicionaisRepository(Modular.get<CustomDio>());

        _repository.data = {};
        _repository.data["codpro"] =
            insereProdutoController.produto.codPro.toString();
        _repository.data["codemp"] = _appController.empresa.codEmp.toString();
        _repository.data["page"] = page.toString();
        _repository.data["pesquisa"] =
            textEditingControllerPesquisaAdicionais.text;

        busca = await _repository.index();

        if (busca != null) {
          adicionais = List<Produto>.from((busca['rows'] as List)
              .map((produto) => Produto.fromMap(produto)));
        }
        loading = false;
      } on DioError catch (e) {
        loading = false;
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      loading = false;
      Utils().showAlert(mensagem: e.toString());
    }
  }

  @action
  Future<void> adicionaNovaPaginaAdicionais() async {
    try {
      try {
        loading = true;
        if (page < busca["count"]) {
          page++;
          var _repository = AdicionaisRepository(Modular.get<CustomDio>());
          _repository.data = {};

          _repository.data["codpro"] =
              insereProdutoController.produto.codPro.toString();
          _repository.data["codemp"] = _appController.empresa.codEmp.toString();
          _repository.data["page"] = page.toString();
          _repository.data["pesquisa"] =
              textEditingControllerPesquisaAdicionais.text;

          busca = await _repository.index();

          if (busca != null) {
            adicionais = List.from(adicionais)
              ..addAll(((busca["rows"] as List).isEmpty)
                  ? []
                  : List<Produto>.from(busca["rows"]
                      .map((produto) => Produto.fromMap(produto))));
          }
        }
        loading = false;
      } on DioError catch (e) {
        loading = false;
        page--;
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      loading = false;
      page--;
      Utils().showAlert(mensagem: e.toString());
    }
  }
}
