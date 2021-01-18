import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../app_controller.dart';
import '../../../../shared/client/custom_dio/custom_dio.dart';
import '../../../../shared/models/comanda.dart';
import '../../../../shared/repositories/backend/comandas/comanda_repository.dart';
import '../../../../shared/repositories/backend/interface_repository.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/custom_bottom_sheet_setores.dart';
import '../../home_routes.dart';
import '../../widgets/custom_message.dart';

part 'nova_comanda_controller.g.dart';

@Injectable()
class NovaComandaController = _NovaComandaControllerBase
    with _$NovaComandaController;

abstract class _NovaComandaControllerBase with Store implements Disposable {
  final AppController _appController = Modular.get<AppController>();

  TextEditingController textEditingControllerComanda =
      TextEditingController(text: '');

  TextEditingController textEditingControllerDescricaoComanda =
      TextEditingController(text: '');

  TextEditingController textEditingControllerPessoasComanda =
      TextEditingController(text: '');

  @observable
  bool loading = false;

  IRepository _repository;

  FocusNode focusComanda = FocusNode();
  FocusNode focusDescricaoComanda = FocusNode();
  FocusNode focusPessoasComanda = FocusNode();

  GlobalKey<FormState> form = GlobalKey<FormState>();

  @action
  Future<void> onPressedNovaComanda() async {
    try {
      try {
        if (form.currentState.validate()) {
          form.currentState.save();

          loading = true;

          if (_appController.setores == null) {
            await buscaMesa(0);
          } else {
            if (_appController.setores.length > 1) {
              showModalBottomSheet(
                context: Modular.navigatorKey.currentState.overlay.context,
                backgroundColor: Colors.transparent,
                builder: (_) {
                  return CustomBottomSheetSetores(
                    onTapSetor: (codSetor) {
                      buscaMesa(codSetor);
                      Modular.to.pop();
                    },
                  );
                },
              );
            } else {
              await buscaMesa(_appController.setores.elementAt(0).codSetor);
            }
          }
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
  Future<void> buscaMesa(int codsetor) async {
    loading = true;
    _repository = ComandaRepository(Modular.get<CustomDio>());
    _repository.data = {};
    _repository.data["codsetor"] = codsetor.toString();
    _repository.data["descmesa"] =
        textEditingControllerDescricaoComanda.text.trim();
    _repository.data["codemp"] = _appController.empresa.codEmp.toString();
    _repository.data["codvend"] = _appController.usuario.codVend.toString();
    _repository.data["conta"] = textEditingControllerComanda.text.trim();
    _repository.data["totalpessoas"] =
        textEditingControllerPessoasComanda.text.trim();

    var data = await _repository.show();

    var comanda = Comanda.fromMap(data["comanda"]);

    if (data["mesa_nova"] == 'S') {
      Modular.to.pushReplacementNamed(
        HomeRoutes.comanda,
        arguments: comanda,
      );
    } else {
      comanda = Comanda.fromMap(data["comanda"]);
      showModalBottomSheet(
        context: Modular.navigatorKey.currentState.overlay.context,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return CustomMessage(
            title: 'Atenção',
            message: 'A comanda ${comanda.formatConta} já se encontra aberta. '
                'Gostaria de voltar e adicionar uma '
                'outra comanda ou continuar e '
                'adentrar nos detalhes desta?',
            onPressedConfirmed: () {
              Modular.to.pop();
              Modular.to.pushReplacementNamed(
                HomeRoutes.comanda,
                arguments: comanda,
              );
            },
            onPressedOther: () {
              Modular.to.pop();
              focusComanda.requestFocus();
            },
            titleConfirmed: 'Entrar na comanda ${comanda.formatConta}',
            titleOther: 'Adicionar outra comanda',
          );
        },
      );
    }

    loading = false;
  }

  @override
  void dispose() {
    focusComanda.dispose();
    focusDescricaoComanda.dispose();
    focusPessoasComanda.dispose();

    textEditingControllerComanda.dispose();
    textEditingControllerDescricaoComanda.dispose();
    textEditingControllerPessoasComanda.dispose();
  }

  Future<bool> onPressedBack() async {
    if (loading) {
      return Future.value(false);
    } else {
      Modular.to.pop();

      return Future.value(true);
    }
  }
}
