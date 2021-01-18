// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insere_produto_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $InsereProdutoController = BindInject(
  (i) => InsereProdutoController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InsereProdutoController on _InsereProdutoControllerBase, Store {
  final _$observacoesEscritasAtom =
      Atom(name: '_InsereProdutoControllerBase.observacoesEscritas');

  @override
  ObservableList<String> get observacoesEscritas {
    _$observacoesEscritasAtom.reportRead();
    return super.observacoesEscritas;
  }

  @override
  set observacoesEscritas(ObservableList<String> value) {
    _$observacoesEscritasAtom.reportWrite(value, super.observacoesEscritas, () {
      super.observacoesEscritas = value;
    });
  }

  final _$textEditingControllerQuantidadeAtom = Atom(
      name: '_InsereProdutoControllerBase.textEditingControllerQuantidade');

  @override
  TextEditingController get textEditingControllerQuantidade {
    _$textEditingControllerQuantidadeAtom.reportRead();
    return super.textEditingControllerQuantidade;
  }

  @override
  set textEditingControllerQuantidade(TextEditingController value) {
    _$textEditingControllerQuantidadeAtom
        .reportWrite(value, super.textEditingControllerQuantidade, () {
      super.textEditingControllerQuantidade = value;
    });
  }

  final _$adicionaisSelecionadosAtom =
      Atom(name: '_InsereProdutoControllerBase.adicionaisSelecionados');

  @override
  List<Adicional> get adicionaisSelecionados {
    _$adicionaisSelecionadosAtom.reportRead();
    return super.adicionaisSelecionados;
  }

  @override
  set adicionaisSelecionados(List<Adicional> value) {
    _$adicionaisSelecionadosAtom
        .reportWrite(value, super.adicionaisSelecionados, () {
      super.adicionaisSelecionados = value;
    });
  }

  final _$adicionaObservacaoAsyncAction =
      AsyncAction('_InsereProdutoControllerBase.adicionaObservacao');

  @override
  Future<void> adicionaObservacao() {
    return _$adicionaObservacaoAsyncAction
        .run(() => super.adicionaObservacao());
  }

  final _$deleteObservacaoAsyncAction =
      AsyncAction('_InsereProdutoControllerBase.deleteObservacao');

  @override
  Future<void> deleteObservacao(int index) {
    return _$deleteObservacaoAsyncAction
        .run(() => super.deleteObservacao(index));
  }

  final _$addQuantidadeAsyncAction =
      AsyncAction('_InsereProdutoControllerBase.addQuantidade');

  @override
  Future<void> addQuantidade() {
    return _$addQuantidadeAsyncAction.run(() => super.addQuantidade());
  }

  final _$removeQuantidadeAsyncAction =
      AsyncAction('_InsereProdutoControllerBase.removeQuantidade');

  @override
  Future<void> removeQuantidade() {
    return _$removeQuantidadeAsyncAction.run(() => super.removeQuantidade());
  }

  final _$preencheProdutoAsyncAction =
      AsyncAction('_InsereProdutoControllerBase.preencheProduto');

  @override
  Future<void> preencheProduto(int index, ItemComanda item) {
    return _$preencheProdutoAsyncAction
        .run(() => super.preencheProduto(index, item));
  }

  final _$selecioneAdicionaisAsyncAction =
      AsyncAction('_InsereProdutoControllerBase.selecioneAdicionais');

  @override
  Future<void> selecioneAdicionais() {
    return _$selecioneAdicionaisAsyncAction
        .run(() => super.selecioneAdicionais());
  }

  final _$onPressedBackAsyncAction =
      AsyncAction('_InsereProdutoControllerBase.onPressedBack');

  @override
  Future<bool> onPressedBack() {
    return _$onPressedBackAsyncAction.run(() => super.onPressedBack());
  }

  final _$removeAdicionalAsyncAction =
      AsyncAction('_InsereProdutoControllerBase.removeAdicional');

  @override
  Future<void> removeAdicional(int index) {
    return _$removeAdicionalAsyncAction.run(() => super.removeAdicional(index));
  }

  final _$addAdicionalAsyncAction =
      AsyncAction('_InsereProdutoControllerBase.addAdicional');

  @override
  Future<void> addAdicional(Adicional adicional) {
    return _$addAdicionalAsyncAction.run(() => super.addAdicional(adicional));
  }

  final _$alterAdicionalAsyncAction =
      AsyncAction('_InsereProdutoControllerBase.alterAdicional');

  @override
  Future<void> alterAdicional(int index, double quantidade) {
    return _$alterAdicionalAsyncAction
        .run(() => super.alterAdicional(index, quantidade));
  }

  @override
  String toString() {
    return '''
observacoesEscritas: ${observacoesEscritas},
textEditingControllerQuantidade: ${textEditingControllerQuantidade},
adicionaisSelecionados: ${adicionaisSelecionados}
    ''';
  }
}
