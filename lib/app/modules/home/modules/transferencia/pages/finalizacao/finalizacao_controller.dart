import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../home_routes.dart';
import '../../transferencia_controller.dart';

part 'finalizacao_controller.g.dart';

@Injectable()
class FinalizacaoController = _FinalizacaoControllerBase
    with _$FinalizacaoController;

abstract class _FinalizacaoControllerBase with Store {
  Future<void> onTapMenuPrincipal() async {
    Modular.to.popUntil(ModalRoute.withName(HomeRoutes.root));
  }

  Future<void> onPressedFazerNovaTransferencia() async {
    await Modular.get<TransferenciaController>().buscaComandas();
    await Modular.to.popUntil(ModalRoute.withName(HomeRoutes.transferencia));
  }
}
