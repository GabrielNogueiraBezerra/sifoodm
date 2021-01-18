import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../app_controller.dart';
import '../../../../shared/models/comanda.dart';
import '../../../../shared/repositories/backend/interface_repository.dart';
import '../../../../shared/utils/utils.dart';
import '../../home_routes.dart';
import 'widgets/ordenacao.dart';

part 'mapa_comandas_controller.g.dart';

@Injectable()
class MapaComandasController = _MapaComandasControllerBase
    with _$MapaComandasController;

abstract class _MapaComandasControllerBase with Store implements Disposable {
  final AppController appController = Modular.get<AppController>();

  final IRepository _repository;

  @observable
  dynamic busca;

  @observable
  List<Comanda> comandas;

  @observable
  int page = 1;

  @observable
  bool loading = false;

  @observable
  int ordenacao = 0;

  @action
  Future<void> changeOrdenacao(int value) async {
    ordenacao = value;

    buscaComandas();
  }

  TextEditingController textEditingControllerPesquisa =
      TextEditingController(text: '');

  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    textEditingControllerPesquisa.dispose();
    scrollController.dispose();
  }

  @action
  Future<void> onPressedOrdenacao() async {
    await showDialog(
      context: Modular.navigatorKey.currentState.overlay.context,
      builder: (_) {
        return Ordenacao();
      },
    );
  }

  @action
  Future<void> onPressedDeleteSearch() async {
    textEditingControllerPesquisa = TextEditingController(text: '');
    await buscaComandas();
  }

  @action
  Future<void> adicionaNovaPaginaComandas() async {
    try {
      try {
        if (page < busca["count"]) {
          page++;
          _repository.data = {};
          _repository.data["codvend"] =
              appController.usuario.codVend.toString();
          _repository.data["codemp"] = appController.empresa.codEmp.toString();
          _repository.data["mostratodas"] =
              appController.empresa.configuracoes.mostraTodasMesaSifood
                  ? 'S'
                  : 'N';
          _repository.data["page"] = page.toString();
          _repository.data["pesquisa"] = textEditingControllerPesquisa.text;

          busca = await _repository.index();

          comandas = List.from(comandas)
            ..addAll(((busca["rows"] as List).isEmpty)
                ? []
                : List<Comanda>.from(
                    busca["rows"].map((comanda) => Comanda.fromMap(comanda))));
          sortComandas();
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
  Future<void> buscaComandas() async {
    try {
      try {
        loading = true;
        comandas = null;
        page = 1;
        _repository.data = {};
        _repository.data["codvend"] = appController.usuario.codVend.toString();
        _repository.data["codemp"] = appController.empresa.codEmp.toString();
        _repository.data["mostratodas"] =
            appController.empresa.configuracoes.mostraTodasMesaSifood
                ? 'S'
                : 'N';
        _repository.data["page"] = page.toString();
        _repository.data["pesquisa"] =
            textEditingControllerPesquisa.text.toUpperCase();

        busca = await _repository.index();

        if (busca != null) {
          comandas = List<Comanda>.from((busca['rows'] as List)
              .map((comanda) => Comanda.fromMap(comanda)));

          sortComandas();
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

  Future<void> onPressedNovaComanda() async {
    if (appController.usuario.haveAcess('M053')) {
      Modular.to.pushReplacementNamed(HomeRoutes.novaComanda);
    } else {
      Utils().showDialogError(
          mensagem:
              '${appController.usuario.nomeUsu}, Informamos que essa funcionalidade '
              'não está disponível ao seu grupo de usuário. '
              'Caso tenha duvídas veja diretamente com o seu gerente. ');
    }
  }

  Future<void> selecionaComanda(Comanda comanda) async {
    if (appController.usuario.haveAcess('M053')) {
      Modular.to.pushReplacementNamed(
        HomeRoutes.comanda,
        arguments: comanda,
      );
    } else {
      Utils().showDialogError(
          mensagem:
              '${appController.usuario.nomeUsu}, Informamos que essa funcionalidade '
              'não está disponível ao seu grupo de usuário. '
              'Caso tenha duvídas veja diretamente com o seu gerente. ');
    }
  }

  @action
  Future<void> sortComandas() async {
    if (comandas != null) {
      if (comandas.isNotEmpty) {
        switch (ordenacao) {
          case 0:
            comandas.sort((a, b) => a.conta.compareTo(b.conta));
            break;
          case 1:
            comandas.sort((a, b) => a.descMesa.compareTo(b.descMesa));
            break;
          case 2:
            comandas.sort((a, b) => a.status.compareTo(b.status));
            break;
          default:
        }
      }
    }
  }

  @action
  Future<bool> onPressedBack() async {
    if (loading) {
      return Future.value(false);
    } else {
      Modular.to.pop();

      return Future.value(true);
    }
  }

  _MapaComandasControllerBase(this._repository) {
    buscaComandas();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        adicionaNovaPaginaComandas();
      }
    });
  }
}
