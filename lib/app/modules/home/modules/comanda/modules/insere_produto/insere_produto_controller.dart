import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../app_controller.dart';
import '../../../../../../shared/models/adicional.dart';
import '../../../../../../shared/models/item_comanda.dart';
import '../../../../../../shared/models/produto.dart';
import '../../../../../../shared/utils/utils.dart';
import '../../comanda_controller.dart';
import '../../widgets/custom_alert_dialog.dart';
import 'insere_produto_routes.dart';

part 'insere_produto_controller.g.dart';

@Injectable()
class InsereProdutoController = _InsereProdutoControllerBase
    with _$InsereProdutoController;

abstract class _InsereProdutoControllerBase with Store implements Disposable {
  FocusNode focusQuantidade = FocusNode();
  final AppController _appController = Modular.get<AppController>();

  TextEditingController textEditingControllerObservacao =
      TextEditingController();

  @observable
  ObservableList<String> observacoesEscritas = ObservableList<String>();

  bool modificado = false;

  @action
  Future<void> adicionaObservacao() async {
    if (textEditingControllerObservacao.text != '') {
      if (observacoesEscritas.indexWhere(
              (element) => element == textEditingControllerObservacao.text) !=
          -1) {
        Utils().showAlert(mensagem: 'Observação já lançada.');
        return;
      }
      modificado = true;
      observacoesEscritas.add(textEditingControllerObservacao.text);
      textEditingControllerObservacao.text = '';
    }
  }

  @action
  Future<void> deleteObservacao(int index) async {
    observacoesEscritas.removeAt(index);
  }

  @observable
  TextEditingController textEditingControllerQuantidade =
      TextEditingController(text: '1');

  Produto produto;

  double get quantidadeProduto => (textEditingControllerQuantidade.text == '')
      ? 1
      : double.parse(textEditingControllerQuantidade.text.replaceAll(',', '.'));

  double get totalPedido =>
      (produto.valorProduto * quantidadeProduto) + totalAdicionais;

  double get totalAdicionais {
    var total = 0.0;

    if (adicionaisSelecionados != null) {
      for (var adicional in adicionaisSelecionados) {
        total += adicional.total;
      }
    }

    return total;
  }

  @action
  Future<void> addQuantidade() async {
    if (textEditingControllerQuantidade.text == '') {
      textEditingControllerQuantidade.text = '1';
      return;
    }

    if (produto.usaQuantidadeFracionaria) {
      textEditingControllerQuantidade.text = (quantidadeProduto + 1).toString();
    } else {
      textEditingControllerQuantidade.text =
          (quantidadeProduto.toInt() + 1).toString();
    }
    modificado = true;
  }

  @action
  Future<void> removeQuantidade() async {
    if (textEditingControllerQuantidade.text == '') {
      textEditingControllerQuantidade.text = '1';
      return;
    }

    if (quantidadeProduto > 1) {
      if (produto.usaQuantidadeFracionaria) {
        textEditingControllerQuantidade.text =
            (quantidadeProduto - 1).toString();
      } else {
        textEditingControllerQuantidade.text =
            (quantidadeProduto.toInt() - 1).toString();
      }
    }

    if (quantidadeProduto == 1) {
      if (produto.usaQuantidadeFracionaria) {
        textEditingControllerQuantidade.text =
            (quantidadeProduto - 0.5).toString();
      }
    }
    modificado = true;
  }

  int indexItem;
  ItemComanda itemComandaSelecionado;

  @action
  Future<void> preencheProduto(int index, ItemComanda item) async {
    if (index != null && item != null) {
      textEditingControllerQuantidade.text = item.quant.toString();
      observacoesEscritas = item.observacao == null
          ? ObservableList<String>()
          : item.observacao == ''
              ? ObservableList<String>()
              : item.observacao.split(',').asObservable();

      adicionaisSelecionados = List<Adicional>.from(item.adicionais);

      indexItem = index;
      itemComandaSelecionado = item;
    }
  }

  @action
  Future<void> selecioneAdicionais() async {
    Modular.to.pushNamed(InsereProdutoRoutes.insereAdicional);
  }

  @observable
  List<Adicional> adicionaisSelecionados = [];

  @override
  void dispose() {
    textEditingControllerObservacao.dispose();
    textEditingControllerQuantidade.dispose();
    focusQuantidade.dispose();
  }

  @action
  Future<bool> onPressedBack() async {
    if (modificado) {
      var exit = false;
      await showDialog(
        context: Modular.navigatorKey.currentState.overlay.context,
        builder: (_) {
          return CustomAlertDialog(
            mensagem: 'O que você lançou\nnão será salvo\n'
                'deseja realmente sair?',
            onTapConfirma: () {},
            onTapSair: () {
              exit = true;
            },
            textButton: 'Não, voltar para o item',
          );
        },
      );
      if (exit) {
        Modular.to.pop();
      }

      return Future.value(exit);
    } else {
      Modular.to.pop();
      return Future.value(true);
    }
  }

  @action
  Future<void> removeAdicional(int index) async {
    var adicionais = List<Adicional>.from(adicionaisSelecionados);
    adicionais.removeAt(index);
    adicionaisSelecionados = adicionais;
    modificado = true;
  }

  @action
  Future<void> addAdicional(Adicional adicional) async {
    adicional = adicional.copyWith(
      hashItem:
          '${_appController.empresa.codEmp}_${_appController.usuario.codVend}_${DateTime.now().toIso8601String()}_adicional',
    );

    adicionaisSelecionados.add(adicional);

    var adicionais = List<Adicional>.from(adicionaisSelecionados);

    adicionaisSelecionados = adicionais;
    modificado = true;
  }

  @action
  Future<void> alterAdicional(int index, double quantidade) async {
    var adicional = adicionaisSelecionados.elementAt(index);
    adicional = adicional.copyWith(quant: quantidade);

    adicionaisSelecionados.removeAt(index);
    adicionaisSelecionados.insert(index, adicional);

    var adicionais = List<Adicional>.from(adicionaisSelecionados);

    adicionaisSelecionados = adicionais;
    modificado = true;
  }

  Future<void> adicionaItem() async {
    var observacao = '';

    for (var element in observacoesEscritas) {
      observacao += '${element}, ';
    }

    var itemComanda = ItemComanda(
      index: Modular.get<ComandaController>().itensComandaLancamento.length,
      codPro: produto.codPro,
      cancelado: 0,
      descCupom: produto.descCupom,
      quant: quantidadeProduto,
      valor: produto.valorProduto,
      totalParcial: 0,
      total: (produto.valorProduto * quantidadeProduto) + totalAdicionais,
      impresso: 'N',
      observacao: observacao == ''
          ? ''
          : observacao.substring(0, observacao.length - 2),
      hashItem:
          '${_appController.empresa.codEmp}_${_appController.usuario.codVend}_${DateTime.now().toIso8601String()}',
      adicionais: adicionaisSelecionados,
      produto: produto,
    );

    if (itemComandaSelecionado == null) {
      Modular.get<ComandaController>().addItemComanda(itemComanda);
    } else {
      Modular.get<ComandaController>().alterItemComanda(itemComanda, indexItem);
    }
    Modular.to.pop();
  }
}
