// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comanda_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ComandaController = BindInject(
  (i) => ComandaController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ComandaController on _ComandaControllerBase, Store {
  final _$itensComandaLancamentoAtom =
      Atom(name: '_ComandaControllerBase.itensComandaLancamento');

  @override
  ObservableList<ItemComanda> get itensComandaLancamento {
    _$itensComandaLancamentoAtom.reportRead();
    return super.itensComandaLancamento;
  }

  @override
  set itensComandaLancamento(ObservableList<ItemComanda> value) {
    _$itensComandaLancamentoAtom
        .reportWrite(value, super.itensComandaLancamento, () {
      super.itensComandaLancamento = value;
    });
  }

  final _$itensSelectedsAtom =
      Atom(name: '_ComandaControllerBase.itensSelecteds');

  @override
  ObservableList<int> get itensSelecteds {
    _$itensSelectedsAtom.reportRead();
    return super.itensSelecteds;
  }

  @override
  set itensSelecteds(ObservableList<int> value) {
    _$itensSelectedsAtom.reportWrite(value, super.itensSelecteds, () {
      super.itensSelecteds = value;
    });
  }

  final _$comandaAtom = Atom(name: '_ComandaControllerBase.comanda');

  @override
  Comanda get comanda {
    _$comandaAtom.reportRead();
    return super.comanda;
  }

  @override
  set comanda(Comanda value) {
    _$comandaAtom.reportWrite(value, super.comanda, () {
      super.comanda = value;
    });
  }

  final _$pageAtom = Atom(name: '_ComandaControllerBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$loadingConfirmaPedidoAtom =
      Atom(name: '_ComandaControllerBase.loadingConfirmaPedido');

  @override
  bool get loadingConfirmaPedido {
    _$loadingConfirmaPedidoAtom.reportRead();
    return super.loadingConfirmaPedido;
  }

  @override
  set loadingConfirmaPedido(bool value) {
    _$loadingConfirmaPedidoAtom.reportWrite(value, super.loadingConfirmaPedido,
        () {
      super.loadingConfirmaPedido = value;
    });
  }

  final _$buscaAtom = Atom(name: '_ComandaControllerBase.busca');

  @override
  dynamic get busca {
    _$buscaAtom.reportRead();
    return super.busca;
  }

  @override
  set busca(dynamic value) {
    _$buscaAtom.reportWrite(value, super.busca, () {
      super.busca = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ComandaControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$removeItemSelectedAsyncAction =
      AsyncAction('_ComandaControllerBase.removeItemSelected');

  @override
  Future<void> removeItemSelected(int index) {
    return _$removeItemSelectedAsyncAction
        .run(() => super.removeItemSelected(index));
  }

  final _$addItemSelectedAsyncAction =
      AsyncAction('_ComandaControllerBase.addItemSelected');

  @override
  Future<void> addItemSelected(int index) {
    return _$addItemSelectedAsyncAction.run(() => super.addItemSelected(index));
  }

  final _$addItemComandaAsyncAction =
      AsyncAction('_ComandaControllerBase.addItemComanda');

  @override
  Future<void> addItemComanda(ItemComanda itemComanda) {
    return _$addItemComandaAsyncAction
        .run(() => super.addItemComanda(itemComanda));
  }

  final _$editaIndexAsyncAction =
      AsyncAction('_ComandaControllerBase.editaIndex');

  @override
  Future<void> editaIndex() {
    return _$editaIndexAsyncAction.run(() => super.editaIndex());
  }

  final _$confirmaItensAsyncAction =
      AsyncAction('_ComandaControllerBase.confirmaItens');

  @override
  Future<void> confirmaItens() {
    return _$confirmaItensAsyncAction.run(() => super.confirmaItens());
  }

  final _$adicionaNovaPaginaItensComandasAsyncAction =
      AsyncAction('_ComandaControllerBase.adicionaNovaPaginaItensComandas');

  @override
  Future<void> adicionaNovaPaginaItensComandas() {
    return _$adicionaNovaPaginaItensComandasAsyncAction
        .run(() => super.adicionaNovaPaginaItensComandas());
  }

  final _$changeTabAsyncAction =
      AsyncAction('_ComandaControllerBase.changeTab');

  @override
  Future<void> changeTab(int index) {
    return _$changeTabAsyncAction.run(() => super.changeTab(index));
  }

  final _$onWillPopScopeAsyncAction =
      AsyncAction('_ComandaControllerBase.onWillPopScope');

  @override
  Future<bool> onWillPopScope() {
    return _$onWillPopScopeAsyncAction.run(() => super.onWillPopScope());
  }

  final _$onPressedBackAsyncAction =
      AsyncAction('_ComandaControllerBase.onPressedBack');

  @override
  Future<bool> onPressedBack() {
    return _$onPressedBackAsyncAction.run(() => super.onPressedBack());
  }

  final _$expandedItemAsyncAction =
      AsyncAction('_ComandaControllerBase.expandedItem');

  @override
  Future<void> expandedItem(ItemComanda item, int index) {
    return _$expandedItemAsyncAction.run(() => super.expandedItem(item, index));
  }

  final _$retrairAdicionaisAsyncAction =
      AsyncAction('_ComandaControllerBase.retrairAdicionais');

  @override
  Future<void> retrairAdicionais() {
    return _$retrairAdicionaisAsyncAction.run(() => super.retrairAdicionais());
  }

  final _$buscaMesaAsyncAction =
      AsyncAction('_ComandaControllerBase.buscaMesa');

  @override
  Future<void> buscaMesa() {
    return _$buscaMesaAsyncAction.run(() => super.buscaMesa());
  }

  @override
  String toString() {
    return '''
itensComandaLancamento: ${itensComandaLancamento},
itensSelecteds: ${itensSelecteds},
comanda: ${comanda},
page: ${page},
loadingConfirmaPedido: ${loadingConfirmaPedido},
busca: ${busca},
loading: ${loading}
    ''';
  }
}
