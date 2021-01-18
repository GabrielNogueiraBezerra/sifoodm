import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../app_controller.dart';
import '../../../../shared/client/custom_dio/custom_dio.dart';
import '../../../../shared/models/comanda.dart';
import '../../../../shared/models/item_comanda.dart';
import '../../../../shared/repositories/backend/comandas/busca_comanda_repository.dart';
import '../../../../shared/repositories/backend/comandas/conferencia_detalhada.dart';
import '../../../../shared/repositories/backend/comandas/conferencia_resumida.dart';
import '../../../../shared/repositories/backend/comandas/impressao_comanda.dart';
import '../../../../shared/repositories/backend/comandas/itens_comanda_repository.dart';
import '../../../../shared/repositories/backend/comandas/quantidade_comandas_repository.dart';
import '../../../../shared/repositories/backend/interface_repository.dart';
import '../../../../shared/utils/utils.dart';
import 'comanda_routes.dart';
import 'widgets/custom_alert_dialog.dart';

part 'comanda_controller.g.dart';

@Injectable()
class ComandaController = _ComandaControllerBase with _$ComandaController;

abstract class _ComandaControllerBase with Store implements Disposable {
  PageController pageController = PageController(initialPage: 0);
  IRepository _repository;

  final AppController appController = Modular.get<AppController>();

  @observable
  ObservableList<ItemComanda> itensComandaLancamento = ObservableList();

  @observable
  ObservableList<int> itensSelecteds = ObservableList<int>();

  List<ItemComanda> itensComandaTotais;

  @observable
  Comanda comanda;

  @action
  Future<void> removeItemSelected(int index) async {
    itensSelecteds.remove(index);
  }

  @action
  Future<void> addItemSelected(int index) async {
    itensSelecteds.add(index);
  }

  @override
  void dispose() {
    if (timerMesa != null) {
      timerMesa.cancel();
    }
    pageController.dispose();
  }

  @observable
  int page = 0;

  @action
  Future<void> addItemComanda(ItemComanda itemComanda) async {
    itensComandaLancamento.add(itemComanda);
  }

  @action
  Future<void> editaIndex() async {
    var itens = ObservableList<ItemComanda>();
    for (var i = 0; i < itensComandaLancamento.length; i++) {
      itens.add(itensComandaLancamento.elementAt(i).copyWith(index: i));
    }

    itensComandaLancamento = List<ItemComanda>.from(itens).asObservable();
  }

  Future<void> alterItemComanda(
      ItemComanda itemComandaNovo, int indexItem) async {
    itensComandaLancamento.removeAt(indexItem);
    itensComandaLancamento.insert(indexItem, itemComandaNovo);
  }

  double get totalItensComanda {
    var total = 0.0;

    if (itensComandaLancamento != null) {
      for (var item in itensComandaLancamento) {
        total += item.total;
      }
    }

    return total;
  }

  @observable
  bool loadingConfirmaPedido = false;

  @action
  Future<void> confirmaItens() async {
    try {
      try {
        Utils().showCustomProgressDialog(
            title:
                "Por favor, aguarde enquanto enviamos o pedido ao servidor...");

        loadingConfirmaPedido = true;

        var itens = '[';

        for (var element in itensComandaLancamento) {
          itens += '{';
          itens += '"cod_pro":${element.codPro},';
          itens += '"hash_produto":"${element.hashItem}",';
          itens += '"valor":${element.valor},';
          itens += '"quant":${element.quant},';
          itens += '"observacao":"${element.observacao}",';
          itens += '"adicionais":[';
          for (var adicional in element.adicionais) {
            itens += '{';
            itens += '"cod_pro":${adicional.codPro},';
            itens += '"hash_produto":"${adicional.hashItem}",';
            itens += '"valor":${adicional.valor},';
            itens += '"quant":${adicional.quant},';
            itens += '"observacao":"${adicional.observacao}"';
            if (element.adicionais.last == adicional) {
              itens += '}';
            } else {
              itens += '},';
            }
          }
          itens += ']';
          if (itensComandaLancamento.last == element) {
            itens += '}';
          } else {
            itens += '},';
          }
        }
        itens += ']';

        _repository = ItemComandaRepository(Modular.get<CustomDio>());
        _repository.data = {};
        _repository.data["codigo"] = comanda.codigo.toString();
        _repository.data["codvend"] = appController.usuario.codVend.toString();
        _repository.data["codemp"] = appController.empresa.codEmp.toString();
        _repository.data["conta"] = comanda.conta.toString();
        _repository.data["descmesa"] =
            comanda.descMesa == null ? '' : comanda.descMesa;
        _repository.data["codsetor"] =
            comanda.codSetor == null ? 0 : comanda.codSetor.toString();
        _repository.data["totalpessoas"] =
            comanda.totalPessoas == null ? 0 : comanda.totalPessoas.toString();

        _repository.data["data"] = itens;

        await _repository.store();

        itensComandaLancamento = ObservableList();

        loadingConfirmaPedido = false;

        Utils().hideCustomProgressDialog();

        Modular.to.pushNamed(
          ComandaRoutes.confirmaItens,
        );

        _repository = QuantidadeComandasRepository(Modular.get<CustomDio>());
        _repository.data = {};
        _repository.data["codvend"] = appController.usuario.codVend.toString();
        _repository.data["codemp"] = appController.empresa.codEmp.toString();

        var quantidadeComandas = await _repository.show();

        var indexEmpresa = appController.usuario.empresas.indexWhere(
            (element) => element.codEmp == appController.empresa.codEmp);

        appController.empresa = appController.empresa
            .copyWith(totalMesasAbertas: quantidadeComandas);

        appController.usuario.empresas.removeAt(indexEmpresa);

        appController.usuario.empresas
            .insert(indexEmpresa, appController.empresa);
      } on DioError catch (e) {
        loadingConfirmaPedido = false;

        Utils().hideCustomProgressDialog();
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      loadingConfirmaPedido = false;

      Utils().hideCustomProgressDialog();
      Utils().showAlert(mensagem: e.toString());
    }
  }

  Future<void> imprimirComanda() async {
    try {
      try {
        Utils().showCustomProgressDialog(
            title: "Por favor, aguarde enquanto imprimimos a comanda...");

        _repository = ImpressaoComandaRepository(Modular.get<CustomDio>());

        _repository.data["codigo"] = comanda.codigo.toString();
        _repository.data["codemp"] = appController.empresa.codEmp.toString();
        _repository.data["codvend"] = appController.usuario.codVend.toString();

        await _repository.show();

        Utils().hideCustomProgressDialog();
      } on DioError catch (e) {
        Utils().hideCustomProgressDialog();
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      Utils().hideCustomProgressDialog();
      Utils().showAlert(mensagem: e.toString());
    }
  }

  Future<void> conferenciaDetalhada() async {
    try {
      try {
        if (appController.usuario.haveAcess('M121')) {
          Utils().showCustomProgressDialog(
              title:
                  "Por favor, aguarde enquanto imprimimos a conferência detalhada...");

          _repository =
              ConferenciaDetalhadaRepository(Modular.get<CustomDio>());

          _repository.data["codigo"] = comanda.codigo.toString();
          _repository.data["codemp"] = appController.empresa.codEmp.toString();

          await _repository.show();

          Utils().hideCustomProgressDialog();
        } else {
          Utils().showDialogError(
              mensagem:
                  '${appController.usuario.nomeUsu}, Informamos que essa funcionalidade '
                  'não está disponível ao seu grupo de usuário. '
                  'Caso tenha duvídas veja diretamente com o seu gerente. ');
        }
      } on DioError catch (e) {
        Utils().hideCustomProgressDialog();
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      Utils().hideCustomProgressDialog();
      Utils().showAlert(mensagem: e.toString());
    }
  }

  Future<void> conferenciaResumida() async {
    try {
      try {
        if (appController.usuario.haveAcess('M121')) {
          Utils().showCustomProgressDialog(
              title:
                  "Por favor, aguarde enquanto imprimimos a conferência resumida...");
          _repository = ConferenciaResumidaRepository(Modular.get<CustomDio>());

          _repository.data["codigo"] = comanda.codigo.toString();
          _repository.data["codemp"] = appController.empresa.codEmp.toString();

          await _repository.show();

          Utils().hideCustomProgressDialog();
        } else {
          Utils().showDialogError(
              mensagem:
                  '${appController.usuario.nomeUsu}, Informamos que essa funcionalidade '
                  'não está disponível ao seu grupo de usuário. '
                  'Caso tenha duvídas veja diretamente com o seu gerente. ');
        }
      } on DioError catch (e) {
        Utils().hideCustomProgressDialog();
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      Utils().hideCustomProgressDialog();
      Utils().showAlert(mensagem: e.toString());
    }
  }

  @observable
  dynamic busca;

  int pageItensComanda = 1;

  @observable
  bool loading = false;

  Future<void> buscaItensComanda() async {
    try {
      try {
        await buscaMesa();

        busca = null;
        loading = true;
        pageItensComanda = 1;
        itensComandaTotais = null;
        _repository = ItemComandaRepository(Modular.get<CustomDio>());

        _repository.data["codigo"] = comanda.codigo.toString();
        _repository.data["codemp"] = appController.empresa.codEmp.toString();
        _repository.data["page"] = pageItensComanda.toString();

        busca = await _repository.index();

        if (busca != null) {
          itensComandaTotais = List<ItemComanda>.from((busca['rows'] as List)
              .map((itemComanda) => ItemComanda.fromMap(itemComanda)));

          itensComandaTotais.sort((a, b) => a.ordem.compareTo(b.ordem));
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
  Future<void> adicionaNovaPaginaItensComandas() async {
    try {
      try {
        if (pageItensComanda < busca["count"]) {
          pageItensComanda++;
          _repository = ItemComandaRepository(Modular.get<CustomDio>());
          _repository.data = {};

          _repository.data["codigo"] = comanda.codigo.toString();
          _repository.data["codemp"] = appController.empresa.codEmp.toString();
          _repository.data["page"] = pageItensComanda.toString();

          busca = await _repository.index();

          itensComandaTotais = List.from(itensComandaTotais)
            ..addAll(((busca["rows"] as List).isEmpty)
                ? []
                : List<ItemComanda>.from(busca["rows"]
                    .map((itemComanda) => ItemComanda.fromMap(itemComanda))));

          itensComandaTotais.sort((a, b) => a.ordem.compareTo(b.ordem));
        }
      } on DioError catch (e) {
        pageItensComanda--;
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      pageItensComanda--;
      Utils().showAlert(mensagem: e.toString());
    }
  }

  @action
  Future<void> changeTab(int index) async {
    if (page != index) {
      page = index;

      if (page == 2) {
        await buscaItensComanda();
      }
    }
  }

  @action
  Future<bool> onWillPopScope() async {
    if (page != 0) {
      page = 0;
      return false;
    }

    if (pageController.page == 0) {
      var exit = false;
      if (itensComandaLancamento != null) {
        if (itensComandaLancamento.isNotEmpty) {
          await showDialog(
            context: Modular.navigatorKey.currentState.overlay.context,
            builder: (_) {
              return CustomAlertDialog(
                mensagem: 'Existem produtos que não\n'
                    'foram lançados na comanda',
                textButton: 'Permanecer na comanda',
                onTapConfirma: () {
                  changeTab(1);
                },
                onTapSair: () {
                  exit = true;
                },
              );
            },
          );
        } else {
          exit = true;
        }
      } else {
        exit = true;
      }
      if (exit) {
        Modular.to.pop();
      }

      return false;
    } else {
      pageController.jumpTo(0);

      return false;
    }
  }

  @action
  Future<bool> onPressedBack() async {
    var exit = false;
    if (itensComandaLancamento != null) {
      if (itensComandaLancamento.isNotEmpty) {
        await showDialog(
          context: Modular.navigatorKey.currentState.overlay.context,
          builder: (_) {
            return CustomAlertDialog(
              mensagem: 'Existem produtos que não\n'
                  'foram lançados na comanda',
              textButton: 'Permanecer na comanda',
              onTapConfirma: () {
                changeTab(1);
              },
              onTapSair: () {
                exit = true;
              },
            );
          },
        );
      } else {
        exit = true;
      }
    } else {
      exit = true;
    }
    if (exit) {
      Modular.to.pop();
    }

    return false;
  }

  Future<void> onTapEditarComanda() async {
    await Modular.to.pushNamed(ComandaRoutes.alteraComanda);
  }

  Timer timerMesa;

  @action
  Future<void> expandedItem(ItemComanda item, int index) async {
    var itensNovos = List<ItemComanda>.from(itensComandaLancamento);
    itensNovos.removeAt(index);

    itensNovos.insert(index, item);

    itensComandaLancamento = itensNovos.asObservable();
  }

  @action
  Future<void> retrairAdicionais() async {
    var itensNovos = <ItemComanda>[];

    for (var item in itensComandaLancamento) {
      itensNovos.add(item.copyWith(expanded: false));
    }

    itensComandaLancamento = itensNovos.asObservable();
  }

  @action
  Future<void> buscaMesa() async {
    _repository = BuscaComandaRepository(Modular.get<CustomDio>());
    _repository.data = {};
    _repository.data["codigo"] = comanda.codigo.toString();

    var data = await _repository.show();

    comanda = Comanda.fromMap(data["comanda"]);
  }
}
