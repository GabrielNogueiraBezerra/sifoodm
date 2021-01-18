import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../home_routes.dart';
import '../../comanda_controller.dart';

part 'confirma_itens_controller.g.dart';

@Injectable()
class ConfirmaItensController = _ConfirmaItensControllerBase
    with _$ConfirmaItensController;

abstract class _ConfirmaItensControllerBase with Store {
  Future<void> onTapMenuPrincipal() async {
    Modular.to.popUntil(ModalRoute.withName(HomeRoutes.root));
  }

  @action
  Future<void> onPressedContinuaComanda() async {
    Modular.to.pop();
    Modular.get<ComandaController>().page = 2;
    await Modular.get<ComandaController>().buscaItensComanda();
  }

  Future<void> onPressedAbrirNovaComanda() async {
    await Modular.to.popUntil(ModalRoute.withName(HomeRoutes.root));
    Modular.to.pushNamed(HomeRoutes.novaComanda);
  }
}
