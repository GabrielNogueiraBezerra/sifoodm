import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../app_controller.dart';
import '../../../../shared/client/custom_dio/custom_dio.dart';
import '../../../../shared/models/comanda.dart';
import '../../../../shared/repositories/backend/comandas/comanda_repository.dart';
import '../../../../shared/utils/utils.dart';
import 'transferencia_routes.dart';

part 'transferencia_controller.g.dart';

@Injectable()
class TransferenciaController = _TransferenciaControllerBase
    with _$TransferenciaController;

abstract class _TransferenciaControllerBase with Store implements Disposable {
  final AppController appController = Modular.get<AppController>();
  TextEditingController textEditingPesquisaController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  @observable
  List<Comanda> comandas;

  @observable
  bool loading = false;

  @observable
  dynamic busca;

  @observable
  int page;

  Future<void> onTapSelecionaComanda(Comanda comanda) async {
    if (comanda.status == 1) {
      Utils().showAlert(
          mensagem: 'Essa comanda já está em processo de pagamento.');
      return;
    }

    await Modular.to.pushNamed(
      TransferenciaRoutes.itensComanda,
      arguments: comanda,
    );
  }

  @action
  Future<void> buscaComandas() async {
    try {
      try {
        comandas = null;
        loading = true;
        page = 1;
        var _repository = ComandaRepository(Modular.get<CustomDio>());
        _repository.data = {};
        _repository.data["codvend"] = appController.usuario.codVend.toString();
        _repository.data["codemp"] = appController.empresa.codEmp.toString();
        _repository.data["mostratodas"] =
            appController.empresa.configuracoes.mostraTodasMesaSifood
                ? 'S'
                : 'N';
        _repository.data["page"] = page.toString();
        _repository.data["pesquisa"] =
            textEditingPesquisaController.text.toUpperCase();

        busca = await _repository.index();

        if (busca != null) {
          comandas = List<Comanda>.from((busca['rows'] as List)
              .map((comanda) => Comanda.fromMap(comanda)));
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
  Future<void> adicionaNovaPaginaComandas() async {
    try {
      try {
        if (page < busca["count"]) {
          page++;
          var _repository = ComandaRepository(Modular.get<CustomDio>());
          _repository.data = {};
          _repository.data["codvend"] =
              appController.usuario.codVend.toString();
          _repository.data["codemp"] = appController.empresa.codEmp.toString();
          _repository.data["mostratodas"] =
              appController.empresa.configuracoes.mostraTodasMesaSifood
                  ? 'S'
                  : 'N';
          _repository.data["page"] = page.toString();
          _repository.data["pesquisa"] = textEditingPesquisaController.text;

          busca = await _repository.index();

          comandas = List.from(comandas)
            ..addAll(((busca["rows"] as List).isEmpty)
                ? []
                : List<Comanda>.from(
                    busca["rows"].map((comanda) => Comanda.fromMap(comanda))));
        }
      } on DioError catch (e) {
        page--;
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      page--;
      Utils().showAlert(mensagem: e.toString());
    }
  }

  @override
  void dispose() {
    textEditingPesquisaController.dispose();
    focusNode.dispose();
  }

  Future<void> onPressedBack() async {
    Modular.to.pop();
  }

  _TransferenciaControllerBase() {
    buscaComandas();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        adicionaNovaPaginaComandas();
      }
    });
  }
}
