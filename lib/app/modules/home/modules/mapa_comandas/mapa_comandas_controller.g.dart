// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapa_comandas_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $MapaComandasController = BindInject(
  (i) => MapaComandasController(i<IRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapaComandasController on _MapaComandasControllerBase, Store {
  final _$buscaAtom = Atom(name: '_MapaComandasControllerBase.busca');

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

  final _$comandasAtom = Atom(name: '_MapaComandasControllerBase.comandas');

  @override
  List<Comanda> get comandas {
    _$comandasAtom.reportRead();
    return super.comandas;
  }

  @override
  set comandas(List<Comanda> value) {
    _$comandasAtom.reportWrite(value, super.comandas, () {
      super.comandas = value;
    });
  }

  final _$pageAtom = Atom(name: '_MapaComandasControllerBase.page');

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

  final _$loadingAtom = Atom(name: '_MapaComandasControllerBase.loading');

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

  final _$ordenacaoAtom = Atom(name: '_MapaComandasControllerBase.ordenacao');

  @override
  int get ordenacao {
    _$ordenacaoAtom.reportRead();
    return super.ordenacao;
  }

  @override
  set ordenacao(int value) {
    _$ordenacaoAtom.reportWrite(value, super.ordenacao, () {
      super.ordenacao = value;
    });
  }

  final _$changeOrdenacaoAsyncAction =
      AsyncAction('_MapaComandasControllerBase.changeOrdenacao');

  @override
  Future<void> changeOrdenacao(int value) {
    return _$changeOrdenacaoAsyncAction.run(() => super.changeOrdenacao(value));
  }

  final _$onPressedOrdenacaoAsyncAction =
      AsyncAction('_MapaComandasControllerBase.onPressedOrdenacao');

  @override
  Future<void> onPressedOrdenacao() {
    return _$onPressedOrdenacaoAsyncAction
        .run(() => super.onPressedOrdenacao());
  }

  final _$onPressedDeleteSearchAsyncAction =
      AsyncAction('_MapaComandasControllerBase.onPressedDeleteSearch');

  @override
  Future<void> onPressedDeleteSearch() {
    return _$onPressedDeleteSearchAsyncAction
        .run(() => super.onPressedDeleteSearch());
  }

  final _$adicionaNovaPaginaComandasAsyncAction =
      AsyncAction('_MapaComandasControllerBase.adicionaNovaPaginaComandas');

  @override
  Future<void> adicionaNovaPaginaComandas() {
    return _$adicionaNovaPaginaComandasAsyncAction
        .run(() => super.adicionaNovaPaginaComandas());
  }

  final _$buscaComandasAsyncAction =
      AsyncAction('_MapaComandasControllerBase.buscaComandas');

  @override
  Future<void> buscaComandas() {
    return _$buscaComandasAsyncAction.run(() => super.buscaComandas());
  }

  final _$sortComandasAsyncAction =
      AsyncAction('_MapaComandasControllerBase.sortComandas');

  @override
  Future<void> sortComandas() {
    return _$sortComandasAsyncAction.run(() => super.sortComandas());
  }

  final _$onPressedBackAsyncAction =
      AsyncAction('_MapaComandasControllerBase.onPressedBack');

  @override
  Future<bool> onPressedBack() {
    return _$onPressedBackAsyncAction.run(() => super.onPressedBack());
  }

  @override
  String toString() {
    return '''
busca: ${busca},
comandas: ${comandas},
page: ${page},
loading: ${loading},
ordenacao: ${ordenacao}
    ''';
  }
}
