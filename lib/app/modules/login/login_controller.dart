import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:mobx/mobx.dart';

import '../../app_controller.dart';
import '../../app_routes.dart';
import '../../shared/repositories/backend/interface_repository.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/custom_bottom_sheet_empresas.dart';
import 'login_routes.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store implements Disposable {
  final IRepository _repository;

  final AppController _appController = Modular.get<AppController>();

  @observable
  TextEditingController textEditingControllerNomeUsuario =
      TextEditingController();

  FocusNode focusUsuario = FocusNode();
  FocusNode focusSenha = FocusNode();

  TextEditingController textEditingControllerSenha = TextEditingController();

  GlobalKey<FormState> form = GlobalKey<FormState>();

  @observable
  bool lembraCredenciais = false;

  @observable
  bool loading = false;

  @action
  Future<void> changeCredenciais() async {
    lembraCredenciais = !lembraCredenciais;
  }

  @action
  Future<void> selecionaEmpresa(int index) async {
    try {
      try {
        _appController.empresa =
            _appController.usuario.empresas.elementAt(index);

        if (_appController.empresa.statusLicenca != 0) {
          Utils()
              .showDialogError(mensagem: _appController.empresa.retornoLicenca);
          return;
        }

        await _appController.buscaSetores();
        await _appController.buscaSecoes();

        Modular.to.pushNamedAndRemoveUntil(
            AppRoutes.home, ModalRoute.withName(AppRoutes.home));
      } on DioError catch (e) {
        Utils().showAlert(
          mensagem: e.error,
        );
      }
    } on Exception catch (e) {
      Utils().showAlert(
        mensagem: e.toString(),
      );
    }
  }

  @action
  Future<void> onTapLogin() async {
    try {
      try {
        loading = true;
        if (form.currentState.validate()) {
          form.currentState.save();

          var serialNumber = await ImeiPlugin.getImei();

          _repository.data = {};
          _repository.data["usuario"] = textEditingControllerNomeUsuario.text;
          _repository.data["senha"] = textEditingControllerSenha.text;
          _repository.data["numeroserie"] = serialNumber;

          _appController.usuario = await _repository.show();

          if (_appController.usuario.empresas.length == 1) {
            selecionaEmpresa(0);
          } else {
            showModalBottomSheet(
              context: Modular.navigatorKey.currentState.overlay.context,
              backgroundColor: Colors.transparent,
              builder: (_) {
                return CustomBottomSheetEmpresas(
                  onPressedEmpresa: selecionaEmpresa,
                  empresas: _appController.usuario.empresas,
                );
              },
            );
          }

          if (_appController.storageConfigurations != null) {
            _appController.storageConfigurations.salvarConfiguracao(
                lembraCredenciais: lembraCredenciais,
                nomeUsuario: lembraCredenciais
                    ? textEditingControllerNomeUsuario.text
                    : "");
          }
        }

        loading = false;
      } on DioError catch (e) {
        loading = false;
        Utils().showAlert(mensagem: e.error);
        Modular.to.pushNamed(LoginRoutes.configuracao);
      }
    } on Exception catch (e) {
      loading = false;
      Utils().showAlert(mensagem: e.toString());
    }
  }

  @action
  Future<void> onTapGear() async {
    await Modular.to.pushNamed(LoginRoutes.configuracao);
  }

  @override
  void dispose() {
    textEditingControllerNomeUsuario.dispose();
    textEditingControllerSenha.dispose();

    focusUsuario.dispose();
    focusSenha.dispose();
  }

  @action
  Future<void> buscaConexao() async {
    await _appController.buscaConexao();
    if (_appController.storageConfigurations != null) {
      if (_appController.storageConfigurations.conexao != null) {
        if (_appController.storageConfigurations.conexao.lembraCredenciais !=
            null) {
          if (_appController.storageConfigurations.conexao.lembraCredenciais) {
            textEditingControllerNomeUsuario.text =
                _appController.storageConfigurations.conexao.nomeUsuario;
            lembraCredenciais =
                _appController.storageConfigurations.conexao.lembraCredenciais;
          }
        }
      }
    }
  }

  _LoginControllerBase(this._repository) {
    buscaConexao();
  }
}
