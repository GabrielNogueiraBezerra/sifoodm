import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../app_controller.dart';
import '../../../../../../shared/client/custom_dio/custom_dio.dart';
import '../../../../../../shared/models/comanda.dart';
import '../../../../../../shared/models/item_comanda.dart';
import '../../../../../../shared/repositories/backend/comandas/comanda_repository.dart';
import '../../../../../../shared/repositories/backend/comandas/comanda_transferencia_repository.dart';
import '../../../../../../shared/repositories/backend/transferencia/transfere_item_repository.dart';
import '../../../../../../shared/utils/utils.dart';
import '../../../../../../shared/widgets/custom_bottom_sheet_setores.dart';
import '../../transferencia_routes.dart';

part 'segunda_comanda_controller.g.dart';

@Injectable()
class SegundaComandaController = _SegundaComandaControllerBase
    with _$SegundaComandaController;

abstract class _SegundaComandaControllerBase with Store implements Disposable {
  final AppController _appController = Modular.get<AppController>();

  dynamic busca;

  Comanda comanda;

  @observable
  bool loading = false;

  @observable
  Comanda comandaTransferencia;

  List<ItemComanda> itensComanda;

  TextEditingController textEditingControllerComanda = TextEditingController();
  TextEditingController textEditingControllerDescricaoComanda =
      TextEditingController();
  TextEditingController textEditingControllerPessoasComanda =
      TextEditingController();
  FocusNode focusNodeComanda = FocusNode();
  FocusNode focusNodeDescricao = FocusNode();
  FocusNode focusNodeTotalPessoas = FocusNode();

  @override
  void dispose() {
    textEditingControllerComanda.dispose();
    textEditingControllerDescricaoComanda.dispose();
    textEditingControllerPessoasComanda.dispose();
    focusNodeComanda.dispose();
  }

  @action
  Future<void> buscaComandaTransferencia() async {
    try {
      try {
        if (textEditingControllerComanda.text == '') {
          Utils().showAlert(mensagem: 'Informe a comanda de destino.');
          return;
        }

        if (textEditingControllerComanda.text == comanda.conta.toString()) {
          Utils().showAlert(
              mensagem: 'Informe uma comanda diferente da de origem.');
          return;
        }

        focusNodeComanda.unfocus();

        loading = true;
        comandaTransferencia = null;
        var _repository =
            await ComandaTransferenciaRepository(Modular.get<CustomDio>());
        _repository.data = {};
        _repository.data['conta'] = textEditingControllerComanda.text;
        _repository.data['codemp'] = _appController.empresa.codEmp.toString();

        busca = await _repository.show();

        if (busca != null) {
          if (busca['status'] != 2) {
            comandaTransferencia = Comanda.fromMap(
              busca['comanda'],
            );

            await transfereItens();
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
  Future<void> criaComandaTransferencia() async {
    if (_appController.setores == null) {
      await criaComandaTransferenciaSetor(0);
    } else {
      if (_appController.setores.isEmpty) {
        await criaComandaTransferenciaSetor(
            _appController.setores.elementAt(0).codSetor);
      } else {
        await showModalBottomSheet(
          context: Modular.navigatorKey.currentState.overlay.context,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return CustomBottomSheetSetores(
              onTapSetor: (codSetor) async {
                await criaComandaTransferenciaSetor(codSetor);
                Modular.to.pop();
              },
            );
          },
        );
      }
    }
  }

  @action
  Future<void> criaComandaTransferenciaSetor(int codSetor) async {
    var _repository = ComandaRepository(Modular.get<CustomDio>());
    _repository.data = {};
    _repository.data["codsetor"] = codSetor.toString();
    _repository.data["descmesa"] =
        textEditingControllerDescricaoComanda.text.trim();
    _repository.data["codemp"] = _appController.empresa.codEmp.toString();
    _repository.data["codvend"] = _appController.usuario.codVend.toString();
    _repository.data["conta"] = textEditingControllerComanda.text.trim();
    _repository.data["totalpessoas"] =
        textEditingControllerPessoasComanda.text.trim();

    var data = await _repository.show();

    comandaTransferencia = Comanda.fromMap(data["comanda"]);
  }

  @action
  Future<void> confirmaTransfereItens() async {
    Utils().showCustomProgressDialog(
        title:
            "Por favor, aguarde enquanto realizamos a transferência dos itens...");
    var itens = '[';
    for (var item in itensComanda) {
      if (item.selecionado) {
        itens += '{';
        itens += '"ordem":${item.ordem},';
        itens += '"quantidade":${item.quantSelecionada}';
        itens += '},';
      }
    }

    itens = itens.substring(0, itens.length - 1);
    itens += ']';

    var _repository = TransfereItemRepository(Modular.get<CustomDio>());
    _repository.data = {};
    _repository.data['codigonovo'] = comandaTransferencia.codigo.toString();
    _repository.data['codigoantigo'] = comanda.codigo.toString();
    _repository.data['data'] = itens;

    await _repository.show();

    Utils().hideCustomProgressDialog();
  }

  @action
  Future<void> transfereItens() async {
    try {
      try {
        loading = true;
        if (comandaTransferencia == null) {
          await criaComandaTransferencia();
        }

        if (comandaTransferencia == null) {
          loading = false;
          return;
        }

        await confirmaTransfereItens();

        Modular.to.pushNamed(TransferenciaRoutes.finalizacao);

        loading = false;
      } on DioError catch (e) {
        print(e.error);
        loading = false;
        comandaTransferencia = null;
        Utils().hideCustomProgressDialog();
        busca = null;
      }
    } on Exception catch (e) {
      loading = false;
      print(e.toString());
      Utils().hideCustomProgressDialog();
      comandaTransferencia = null;
      busca = null;
    }
  }
}
