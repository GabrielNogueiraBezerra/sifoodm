// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nova_comanda_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $NovaComandaController = BindInject(
  (i) => NovaComandaController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NovaComandaController on _NovaComandaControllerBase, Store {
  final _$loadingAtom = Atom(name: '_NovaComandaControllerBase.loading');

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

  final _$onPressedNovaComandaAsyncAction =
      AsyncAction('_NovaComandaControllerBase.onPressedNovaComanda');

  @override
  Future<void> onPressedNovaComanda() {
    return _$onPressedNovaComandaAsyncAction
        .run(() => super.onPressedNovaComanda());
  }

  final _$buscaMesaAsyncAction =
      AsyncAction('_NovaComandaControllerBase.buscaMesa');

  @override
  Future<void> buscaMesa(int codsetor) {
    return _$buscaMesaAsyncAction.run(() => super.buscaMesa(codsetor));
  }

  @override
  String toString() {
    return '''
loading: ${loading}
    ''';
  }
}
