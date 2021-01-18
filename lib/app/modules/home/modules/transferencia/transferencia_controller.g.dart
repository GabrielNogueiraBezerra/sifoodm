// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transferencia_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $TransferenciaController = BindInject(
  (i) => TransferenciaController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransferenciaController on _TransferenciaControllerBase, Store {
  final _$comandasAtom = Atom(name: '_TransferenciaControllerBase.comandas');

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

  final _$loadingAtom = Atom(name: '_TransferenciaControllerBase.loading');

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

  final _$buscaAtom = Atom(name: '_TransferenciaControllerBase.busca');

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

  final _$pageAtom = Atom(name: '_TransferenciaControllerBase.page');

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

  final _$buscaComandasAsyncAction =
      AsyncAction('_TransferenciaControllerBase.buscaComandas');

  @override
  Future<void> buscaComandas() {
    return _$buscaComandasAsyncAction.run(() => super.buscaComandas());
  }

  final _$adicionaNovaPaginaComandasAsyncAction =
      AsyncAction('_TransferenciaControllerBase.adicionaNovaPaginaComandas');

  @override
  Future<void> adicionaNovaPaginaComandas() {
    return _$adicionaNovaPaginaComandasAsyncAction
        .run(() => super.adicionaNovaPaginaComandas());
  }

  @override
  String toString() {
    return '''
comandas: ${comandas},
loading: ${loading},
busca: ${busca},
page: ${page}
    ''';
  }
}
