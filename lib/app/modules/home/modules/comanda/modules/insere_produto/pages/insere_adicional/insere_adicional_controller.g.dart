// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insere_adicional_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $InsereAdicionalController = BindInject(
  (i) => InsereAdicionalController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InsereAdicionalController on _InsereAdicionalControllerBase, Store {
  final _$buscaAtom = Atom(name: '_InsereAdicionalControllerBase.busca');

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

  final _$pageAtom = Atom(name: '_InsereAdicionalControllerBase.page');

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

  final _$loadingAtom = Atom(name: '_InsereAdicionalControllerBase.loading');

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

  final _$adicionaisAtom =
      Atom(name: '_InsereAdicionalControllerBase.adicionais');

  @override
  List<Produto> get adicionais {
    _$adicionaisAtom.reportRead();
    return super.adicionais;
  }

  @override
  set adicionais(List<Produto> value) {
    _$adicionaisAtom.reportWrite(value, super.adicionais, () {
      super.adicionais = value;
    });
  }

  final _$addItemAsyncAction =
      AsyncAction('_InsereAdicionalControllerBase.addItem');

  @override
  Future<void> addItem(
      Produto produto, Adicional adicional, int indexSelecionado) {
    return _$addItemAsyncAction
        .run(() => super.addItem(produto, adicional, indexSelecionado));
  }

  final _$adicionaNovaPaginaAsyncAction =
      AsyncAction('_InsereAdicionalControllerBase.adicionaNovaPagina');

  @override
  Future<void> adicionaNovaPagina() {
    return _$adicionaNovaPaginaAsyncAction
        .run(() => super.adicionaNovaPagina());
  }

  final _$buscarAdicionaisAsyncAction =
      AsyncAction('_InsereAdicionalControllerBase.buscarAdicionais');

  @override
  Future<void> buscarAdicionais() {
    return _$buscarAdicionaisAsyncAction.run(() => super.buscarAdicionais());
  }

  final _$adicionaNovaPaginaAdicionaisAsyncAction = AsyncAction(
      '_InsereAdicionalControllerBase.adicionaNovaPaginaAdicionais');

  @override
  Future<void> adicionaNovaPaginaAdicionais() {
    return _$adicionaNovaPaginaAdicionaisAsyncAction
        .run(() => super.adicionaNovaPaginaAdicionais());
  }

  @override
  String toString() {
    return '''
busca: ${busca},
page: ${page},
loading: ${loading},
adicionais: ${adicionais}
    ''';
  }
}
