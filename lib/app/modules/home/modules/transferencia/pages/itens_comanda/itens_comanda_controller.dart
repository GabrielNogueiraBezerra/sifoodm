import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../app_controller.dart';
import '../../../../../../shared/client/custom_dio/custom_dio.dart';
import '../../../../../../shared/models/comanda.dart';
import '../../../../../../shared/models/item_comanda.dart';
import '../../../../../../shared/repositories/backend/transferencia/busca_itens_repository.dart';
import '../../../../../../shared/utils/utils.dart';
import '../../../comanda/widgets/custom_alert_dialog.dart';
import '../../transferencia_routes.dart';
import 'widgets/quantidade_item.dart';

part 'itens_comanda_controller.g.dart';

@Injectable()
class ItensComandaController = _ItensComandaControllerBase
    with _$ItensComandaController;

abstract class _ItensComandaControllerBase with Store {
  final AppController appController = Modular.get<AppController>();

  @observable
  Comanda comanda;

  @observable
  List<ItemComanda> itensComanda;

  @observable
  bool loading = false;

  @action
  Future<void> buscaItens() async {
    try {
      try {
        itensComanda = null;
        loading = true;

        var _repository = BuscaItensRepository(Modular.get<CustomDio>());
        _repository.data = {};
        _repository.data["codigo"] = comanda.codigo.toString();
        _repository.data["codemp"] = appController.empresa.codEmp.toString();
        _repository.data["codvend"] = appController.usuario.codVend.toString();

        itensComanda = await _repository.index();

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
  Future<void> removeItem(ItemComanda item, int index) async {
    var itensNovos = List<ItemComanda>.from(itensComanda);
    itensNovos.removeAt(index);
    itensNovos.insert(index, item);
    itensComanda = itensNovos;
  }

  @action
  Future<void> todos({bool selecionado}) async {
    var itensNovos = <ItemComanda>[];

    for (var item in itensComanda) {
      itensNovos.add(
        item.copyWith(
          selecionado: selecionado,
          quantSelecionada: selecionado ? item.quant : 0,
        ),
      );
    }

    itensComanda = itensNovos;
  }

  @action
  Future<void> transfereItens() async {
    var args = {};
    args['comanda'] = comanda;
    args['itensComanda'] = itensComanda;
    Modular.to.pushNamed(
      TransferenciaRoutes.segundaComanda,
      arguments: args,
    );
  }

  @action
  Future<void> addItem(ItemComanda item, int index) async {
    await showDialog(
      context: Modular.navigatorKey.currentState.overlay.context,
      builder: (_) {
        return QuantidadeItem(
          onConfirmed: confirmaAddItem,
          index: index,
          itemComanda: item,
        );
      },
    );
  }

  @action
  Future<bool> onWillPopScope() async {
    var prosseguir = false;
    var selecionados = -1;
    if (itensComanda != null) {
      selecionados = itensComanda.indexWhere((element) => element.selecionado);
    }
    if (selecionados != -1) {
      await showDialog(
        context: Modular.navigatorKey.currentState.overlay.context,
        builder: (_) {
          return CustomAlertDialog(
            mensagem: 'Se você voltar perderá seu progresso, '
                'Deseja continuar?',
            textButton: 'Sim, desejo sair',
            buttonTitle: 'Cancelar',
            onTapConfirma: () {
              prosseguir = true;
            },
            onTapSair: () {
              prosseguir = false;
            },
          );
        },
      );
    } else {
      prosseguir = true;
    }

    if (prosseguir) {
      Modular.to.pop();
    }
    return Future.value(prosseguir);
  }

  @action
  Future<void> confirmaAddItem(
      ItemComanda item, int index, double quant) async {
    var itemNovo = item.copyWith(selecionado: true, quantSelecionada: quant);
    var itensNovos = List<ItemComanda>.from(itensComanda);
    itensNovos.removeAt(index);
    itensNovos.insert(index, itemNovo);
    itensComanda = itensNovos;
  }
}
