import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../app_controller.dart';
import '../../../../../../shared/client/custom_dio/custom_dio.dart';
import '../../../../../../shared/models/produto.dart';
import '../../../../../../shared/models/secao.dart';
import '../../../../../../shared/repositories/backend/interface_repository.dart';
import '../../../../../../shared/repositories/backend/produtos/produto_repository.dart';
import '../../../../../../shared/utils/utils.dart';
import '../../comanda_controller.dart';
import '../../comanda_routes.dart';

part 'busca_controller.g.dart';

@Injectable()
class BuscaController = _BuscaControllerBase with _$BuscaController;

abstract class _BuscaControllerBase with Store implements Disposable {
  TextEditingController textEditingControllerPesquisa = TextEditingController(
    text: '',
  );

  final ComandaController comandaController = Modular.get<ComandaController>();

  final AppController appController = Modular.get<AppController>();

  ScrollController scrollControllerProdutos = ScrollController();

  IRepository _repository;

  @observable
  dynamic busca;

  @observable
  List<Produto> produtos;

  Secao secao;

  @observable
  bool loading = false;

  @observable
  int page = 1;

  Future<void> clearDataTextPesquisa() async {
    textEditingControllerPesquisa.text = '';
    if ((comandaController.pageController?.page?.round() ?? 0) != 0) {
      comandaController.pageController.jumpToPage(0);
    }
  }

  @action
  Future<void> buscaProdutos() async {
    try {
      try {
        loading = true;
        produtos = null;
        busca = null;
        page = 1;
        _repository = ProdutoRepository(Modular.get<CustomDio>());
        _repository.data = {};
        _repository.data["codsec"] =
            secao != null ? secao.codSecao.toString() : '0';
        _repository.data["page"] = page.toString();
        _repository.data["codemp"] = appController.empresa.codEmp.toString();
        _repository.data["pesquisa"] = textEditingControllerPesquisa.text;

        busca = await _repository.index();

        if (busca != null) {
          produtos = List<Produto>.from((busca['rows'] as List)
              .map((produto) => Produto.fromMap(produto)));
        }
        loading = false;
      } on DioError catch (e) {
        Utils().showAlert(mensagem: e.error);
        loading = false;
      }
    } on Exception catch (e) {
      Utils().showAlert(mensagem: e.toString());
      loading = false;
    }
  }

  @action
  Future<void> onFieldSubmittedPesquisa(String value) async {
    secao = null;
    if (value != '') {
      if ((comandaController.pageController?.page?.round() ?? 0) != 1) {
        comandaController.pageController.jumpToPage(1);
      }

      await buscaProdutos();
    } else {
      if ((comandaController.pageController?.page?.round() ?? 0) != 0) {
        comandaController.pageController.jumpToPage(0);
      }
    }
  }

  @action
  Future<void> adicionaNovaPaginaProdutos() async {
    try {
      try {
        if (page < busca["count"]) {
          page++;
          _repository.data = {};
          _repository.data["codsec"] =
              secao != null ? secao.codSecao.toString() : '0';
          _repository.data["page"] = page.toString();
          _repository.data["codemp"] = appController.empresa.codEmp.toString();
          _repository.data["pesquisa"] = textEditingControllerPesquisa.text;

          busca = await _repository.index();

          produtos = List.from(produtos)
            ..addAll(((busca["rows"] as List).isEmpty)
                ? []
                : List<Produto>.from(
                    busca["rows"].map((produto) => Produto.fromMap(produto))));
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

  @action
  Future<void> onChangeTabCategorias() async {
    textEditingControllerPesquisa.text = '';
    comandaController.pageController.jumpToPage(0);
  }

  Future<void> onTapInsereProduto({Produto produto}) async {
    if ((!appController.empresa.configuracoes.saidasEstoqueNegativo) &&
        produto.controlaEstoquePro &&
        produto.estoque <= 0 &&
        produto.codigoTipo != 1) {
      await Utils().showAlert(
        mensagem:
            "${appController.usuario.nomeUsu} esse produto não tem estoque suficiente.",
      );

      return;
    }

    if (comandaController.comanda.status == 2) {
      await Utils().showAlert(
        mensagem:
            "${appController.usuario.nomeUsu} essa comanda está bloqueada.",
      );

      return;
    }

    var args = {};

    args["produto"] = produto;

    Modular.to.pushNamed(
      ComandaRoutes.insereProduto,
      arguments: args,
    );
  }

  @action
  Future<void> changeTabCategoriaProduto(Secao _secao) async {
    comandaController.pageController.jumpToPage(1);
    secao = _secao;

    buscaProdutos();
  }

  FocusNode focusBusca = FocusNode();

  @override
  void dispose() {
    textEditingControllerPesquisa.dispose();
    scrollControllerProdutos.dispose();
    focusBusca.dispose();
  }

  _BuscaControllerBase() {
    scrollControllerProdutos.addListener(() {
      if (scrollControllerProdutos.position.pixels ==
          scrollControllerProdutos.position.maxScrollExtent) {
        adicionaNovaPaginaProdutos();
      }
    });
  }
}
