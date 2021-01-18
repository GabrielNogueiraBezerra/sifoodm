// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itens_comanda_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ItensComandaController = BindInject(
  (i) => ItensComandaController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItensComandaController on _ItensComandaControllerBase, Store {
  final _$comandaAtom = Atom(name: '_ItensComandaControllerBase.comanda');

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

  final _$itensComandaAtom =
      Atom(name: '_ItensComandaControllerBase.itensComanda');

  @override
  List<ItemComanda> get itensComanda {
    _$itensComandaAtom.reportRead();
    return super.itensComanda;
  }

  @override
  set itensComanda(List<ItemComanda> value) {
    _$itensComandaAtom.reportWrite(value, super.itensComanda, () {
      super.itensComanda = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ItensComandaControllerBase.loading');

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

  final _$buscaItensAsyncAction =
      AsyncAction('_ItensComandaControllerBase.buscaItens');

  @override
  Future<void> buscaItens() {
    return _$buscaItensAsyncAction.run(() => super.buscaItens());
  }

  final _$removeItemAsyncAction =
      AsyncAction('_ItensComandaControllerBase.removeItem');

  @override
  Future<void> removeItem(ItemComanda item, int index) {
    return _$removeItemAsyncAction.run(() => super.removeItem(item, index));
  }

  final _$todosAsyncAction = AsyncAction('_ItensComandaControllerBase.todos');

  @override
  Future<void> todos({bool selecionado}) {
    return _$todosAsyncAction.run(() => super.todos(selecionado: selecionado));
  }

  final _$transfereItensAsyncAction =
      AsyncAction('_ItensComandaControllerBase.transfereItens');

  @override
  Future<void> transfereItens() {
    return _$transfereItensAsyncAction.run(() => super.transfereItens());
  }

  final _$addItemAsyncAction =
      AsyncAction('_ItensComandaControllerBase.addItem');

  @override
  Future<void> addItem(ItemComanda item, int index) {
    return _$addItemAsyncAction.run(() => super.addItem(item, index));
  }

  final _$onWillPopScopeAsyncAction =
      AsyncAction('_ItensComandaControllerBase.onWillPopScope');

  @override
  Future<bool> onWillPopScope() {
    return _$onWillPopScopeAsyncAction.run(() => super.onWillPopScope());
  }

  final _$confirmaAddItemAsyncAction =
      AsyncAction('_ItensComandaControllerBase.confirmaAddItem');

  @override
  Future<void> confirmaAddItem(ItemComanda item, int index, double quant) {
    return _$confirmaAddItemAsyncAction
        .run(() => super.confirmaAddItem(item, index, quant));
  }

  @override
  String toString() {
    return '''
comanda: ${comanda},
itensComanda: ${itensComanda},
loading: ${loading}
    ''';
  }
}
