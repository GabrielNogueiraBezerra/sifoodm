import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../app_controller.dart';
import '../../../../app_routes.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/custom_bottom_sheet_empresas.dart';
import '../../home_routes.dart';

part 'inicio_controller.g.dart';

@Injectable()
class InicioController = _InicioControllerBase with _$InicioController;

abstract class _InicioControllerBase with Store {
  AppController appController = Modular.get<AppController>();

  @action
  Future<void> onPressedSelEmpresa() async {
    showModalBottomSheet(
      context: Modular.navigatorKey.currentState.overlay.context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return CustomBottomSheetEmpresas(
          onPressedEmpresa: selecionaEmpresa,
          empresas: appController.usuario.empresas,
        );
      },
    );
  }

  @action
  Future<void> selecionaEmpresa(int index) async {
    try {
      try {
        if (appController.usuario.empresas.elementAt(index).statusLicenca !=
            0) {
          Utils().showDialogError(
              mensagem: appController.usuario.empresas
                  .elementAt(index)
                  .retornoLicenca);
          return;
        }

        appController.empresa = appController.usuario.empresas.elementAt(index);
      } on DioError catch (e) {
        Utils().showAlert(mensagem: e.error);
      }
    } on Exception catch (e) {
      Utils().showAlert(mensagem: e.toString());
    }
  }

  @action
  Future<void> onTapMapaComandas() async {
    if (appController.usuario.haveAcess('M175')) {
      await Modular.to.pushNamed(HomeRoutes.mapaComandas);
    } else {
      Utils().showDialogError(
          mensagem:
              '${appController.usuario.nomeUsu}, Informamos que essa funcionalidade '
              'não está disponível ao seu grupo de usuário. '
              'Caso tenha duvídas veja diretamente com o seu gerente. ');
    }
  }

  @action
  Future<void> onTapLogout() async {
    appController.logout();
    await Modular.to.pushNamedAndRemoveUntil(
        AppRoutes.login, ModalRoute.withName(AppRoutes.login));
  }

  @action
  Future<void> onTapTransferencia() async {
    if (appController.usuario.haveAcess('M055')) {
      await Modular.to.pushNamed(HomeRoutes.transferencia);
    } else {
      Utils().showDialogError(
          mensagem:
              '${appController.usuario.nomeUsu}, Informamos que essa funcionalidade '
              'não está disponível ao seu grupo de usuário. '
              'Caso tenha duvídas veja diretamente com o seu gerente. ');
    }
  }

  @action
  Future<void> onTapNovaComanda() async {
    if (appController.usuario.haveAcess('M053')) {
      await Modular.to.pushNamed(HomeRoutes.novaComanda);
    } else {
      Utils().showDialogError(
          mensagem:
              '${appController.usuario.nomeUsu}, Informamos que essa funcionalidade '
              'não está disponível ao seu grupo de usuário. '
              'Caso tenha duvídas veja diretamente com o seu gerente. ');
    }
  }
}
