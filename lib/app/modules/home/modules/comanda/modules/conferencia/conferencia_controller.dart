import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../shared/utils/utils.dart';
import '../../comanda_controller.dart';
import '../../comanda_routes.dart';
import '../../widgets/custom_alert_dialog.dart';

part 'conferencia_controller.g.dart';

@Injectable()
class ConferenciaController = _ConferenciaControllerBase
    with _$ConferenciaController;

abstract class _ConferenciaControllerBase with Store {
  final ComandaController comandaController = Modular.get<ComandaController>();

  @action
  Future<void> onTapEdit(int index) async {
    try {
      try {
        var indexItemComanda = comandaController.itensComandaLancamento
            .indexWhere((element) => element.index == index);
        if (indexItemComanda != -1) {
          var item = comandaController.itensComandaLancamento
              .elementAt(indexItemComanda);

          var args = {};

          args['produto'] = item.produto;
          args["index"] = index;
          args["itemComanda"] = item;

          await Modular.to.pushNamed(
            ComandaRoutes.insereProduto,
            arguments: args,
          );
        }
      } on DioError catch (e) {
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      Utils().showAlert(mensagem: e.toString());
    }
  }

  @action
  Future<void> deleteItens() async {
    var prosseguir = false;

    await showDialog(
      context: Modular.navigatorKey.currentState.overlay.context,
      builder: (_) {
        return CustomAlertDialog(
          mensagem: 'Deseja realmente excluir esses produtos?',
          textButton: 'Sim, excluir itens',
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

    if (prosseguir) {
      for (var item in comandaController.itensSelecteds) {
        var indexItemComanda = comandaController.itensComandaLancamento
            .indexWhere((element) => element.index == item);
        if (indexItemComanda != -1) {
          var itemComanda = comandaController.itensComandaLancamento
              .elementAt(indexItemComanda);
          comandaController.itensComandaLancamento.remove(itemComanda);
        }
      }
      comandaController.itensSelecteds = ObservableList<int>();
      comandaController.editaIndex();
    }
  }

  @action
  Future<void> editItem() async {
    if (comandaController.itensSelecteds.length == 1) {
      await onTapEdit(comandaController.itensSelecteds.elementAt(0));
      comandaController.itensSelecteds = ObservableList<int>();
      comandaController.editaIndex();
    }
  }
}
