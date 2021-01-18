// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segunda_comanda_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SegundaComandaController = BindInject(
  (i) => SegundaComandaController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SegundaComandaController on _SegundaComandaControllerBase, Store {
  final _$loadingAtom = Atom(name: '_SegundaComandaControllerBase.loading');

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

  final _$comandaTransferenciaAtom =
      Atom(name: '_SegundaComandaControllerBase.comandaTransferencia');

  @override
  Comanda get comandaTransferencia {
    _$comandaTransferenciaAtom.reportRead();
    return super.comandaTransferencia;
  }

  @override
  set comandaTransferencia(Comanda value) {
    _$comandaTransferenciaAtom.reportWrite(value, super.comandaTransferencia,
        () {
      super.comandaTransferencia = value;
    });
  }

  final _$buscaComandaTransferenciaAsyncAction =
      AsyncAction('_SegundaComandaControllerBase.buscaComandaTransferencia');

  @override
  Future<void> buscaComandaTransferencia() {
    return _$buscaComandaTransferenciaAsyncAction
        .run(() => super.buscaComandaTransferencia());
  }

  final _$criaComandaTransferenciaAsyncAction =
      AsyncAction('_SegundaComandaControllerBase.criaComandaTransferencia');

  @override
  Future<void> criaComandaTransferencia() {
    return _$criaComandaTransferenciaAsyncAction
        .run(() => super.criaComandaTransferencia());
  }

  final _$criaComandaTransferenciaSetorAsyncAction = AsyncAction(
      '_SegundaComandaControllerBase.criaComandaTransferenciaSetor');

  @override
  Future<void> criaComandaTransferenciaSetor(int codSetor) {
    return _$criaComandaTransferenciaSetorAsyncAction
        .run(() => super.criaComandaTransferenciaSetor(codSetor));
  }

  final _$confirmaTransfereItensAsyncAction =
      AsyncAction('_SegundaComandaControllerBase.confirmaTransfereItens');

  @override
  Future<void> confirmaTransfereItens() {
    return _$confirmaTransfereItensAsyncAction
        .run(() => super.confirmaTransfereItens());
  }

  final _$transfereItensAsyncAction =
      AsyncAction('_SegundaComandaControllerBase.transfereItens');

  @override
  Future<void> transfereItens() {
    return _$transfereItensAsyncAction.run(() => super.transfereItens());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
comandaTransferencia: ${comandaTransferencia}
    ''';
  }
}
