// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'busca_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $BuscaController = BindInject(
  (i) => BuscaController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BuscaController on _BuscaControllerBase, Store {
  final _$buscaAtom = Atom(name: '_BuscaControllerBase.busca');

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

  final _$produtosAtom = Atom(name: '_BuscaControllerBase.produtos');

  @override
  List<Produto> get produtos {
    _$produtosAtom.reportRead();
    return super.produtos;
  }

  @override
  set produtos(List<Produto> value) {
    _$produtosAtom.reportWrite(value, super.produtos, () {
      super.produtos = value;
    });
  }

  final _$loadingAtom = Atom(name: '_BuscaControllerBase.loading');

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

  final _$pageAtom = Atom(name: '_BuscaControllerBase.page');

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

  final _$buscaProdutosAsyncAction =
      AsyncAction('_BuscaControllerBase.buscaProdutos');

  @override
  Future<void> buscaProdutos() {
    return _$buscaProdutosAsyncAction.run(() => super.buscaProdutos());
  }

  final _$onFieldSubmittedPesquisaAsyncAction =
      AsyncAction('_BuscaControllerBase.onFieldSubmittedPesquisa');

  @override
  Future<void> onFieldSubmittedPesquisa(String value) {
    return _$onFieldSubmittedPesquisaAsyncAction
        .run(() => super.onFieldSubmittedPesquisa(value));
  }

  final _$adicionaNovaPaginaProdutosAsyncAction =
      AsyncAction('_BuscaControllerBase.adicionaNovaPaginaProdutos');

  @override
  Future<void> adicionaNovaPaginaProdutos() {
    return _$adicionaNovaPaginaProdutosAsyncAction
        .run(() => super.adicionaNovaPaginaProdutos());
  }

  final _$onChangeTabCategoriasAsyncAction =
      AsyncAction('_BuscaControllerBase.onChangeTabCategorias');

  @override
  Future<void> onChangeTabCategorias() {
    return _$onChangeTabCategoriasAsyncAction
        .run(() => super.onChangeTabCategorias());
  }

  final _$changeTabCategoriaProdutoAsyncAction =
      AsyncAction('_BuscaControllerBase.changeTabCategoriaProduto');

  @override
  Future<void> changeTabCategoriaProduto(Secao _secao) {
    return _$changeTabCategoriaProdutoAsyncAction
        .run(() => super.changeTabCategoriaProduto(_secao));
  }

  @override
  String toString() {
    return '''
busca: ${busca},
produtos: ${produtos},
loading: ${loading},
page: ${page}
    ''';
  }
}
