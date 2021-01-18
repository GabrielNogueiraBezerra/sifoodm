import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../app_controller.dart';
import '../../../../../../shared/client/custom_dio/custom_dio.dart';
import '../../../../../../shared/repositories/backend/comandas/comanda_repository.dart';
import '../../../../../../shared/repositories/backend/interface_repository.dart';
import '../../../../../../shared/utils/utils.dart';
import '../../comanda_controller.dart';

part 'altera_comanda_controller.g.dart';

@Injectable()
class AlteraComandaController = _AlteraComandaControllerBase
    with _$AlteraComandaController;

abstract class _AlteraComandaControllerBase with Store implements Disposable {
  final ComandaController comandaController = Modular.get<ComandaController>();
  final AppController appController = Modular.get<AppController>();

  @observable
  bool loading = false;

  IRepository _repository;

  GlobalKey<FormState> form = GlobalKey<FormState>();

  TextEditingController textEditingControllerDescricao;
  TextEditingController textEditingControllerNumeroPessoas;

  FocusNode focusDescricao = FocusNode();
  FocusNode focusNumeroPessoas = FocusNode();

  @override
  void dispose() {
    textEditingControllerDescricao.dispose();
    textEditingControllerNumeroPessoas.dispose();

    focusDescricao.dispose();
    focusNumeroPessoas.dispose();
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

  @action
  Future<void> onPressedSalvar() async {
    try {
      try {
        loading = true;
        form.currentState.save();
        _repository = ComandaRepository(Modular.get<CustomDio>());
        _repository.data = {};
        _repository.data["codigo"] =
            comandaController.comanda.codigo.toString();
        _repository.data["descricao"] =
            textEditingControllerDescricao.text == null
                ? ''
                : textEditingControllerDescricao.text;
        _repository.data["numero_pessoas"] =
            textEditingControllerNumeroPessoas.text == null
                ? ''
                : textEditingControllerNumeroPessoas.text == ''
                    ? '0'
                    : textEditingControllerNumeroPessoas.text;

        await _repository.update();
        loading = false;

        comandaController.comanda = comandaController.comanda.copyWith(
          descMesa: _repository.data["descricao"] == ''
              ? 'Comanda sem descrição'
              : _repository.data["descricao"].toUpperCase(),
          totalPessoas: int.parse(
              textEditingControllerNumeroPessoas.text == null
                  ? ''
                  : textEditingControllerNumeroPessoas.text == ''
                      ? '0'
                      : textEditingControllerNumeroPessoas.text),
        );

        Modular.to.pop();
      } on DioError catch (e) {
        Utils().showAlert(mensagem: e.error);
        loading = false;
      }
    } on Exception catch (e) {
      Utils().showAlert(mensagem: e.toString());
      loading = false;
    }
  }

  Future<void> preencheDados() async {
    textEditingControllerDescricao = TextEditingController(
        text: comandaController.comanda.descMesa == 'Comanda sem descrição'
            ? ''
            : comandaController.comanda.descMesa);
    textEditingControllerNumeroPessoas = TextEditingController(
        text: comandaController.comanda.totalPessoas == 0
            ? ''
            : comandaController.comanda.totalPessoas.toString());
  }
}
