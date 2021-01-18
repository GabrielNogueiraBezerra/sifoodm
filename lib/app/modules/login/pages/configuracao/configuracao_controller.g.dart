// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracao_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ConfiguracaoController = BindInject(
  (i) => ConfiguracaoController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfiguracaoController on _ConfiguracaoControllerBase, Store {
  final _$loadingAtom = Atom(name: '_ConfiguracaoControllerBase.loading');

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

  final _$loadingServerAtom =
      Atom(name: '_ConfiguracaoControllerBase.loadingServer');

  @override
  bool get loadingServer {
    _$loadingServerAtom.reportRead();
    return super.loadingServer;
  }

  @override
  set loadingServer(bool value) {
    _$loadingServerAtom.reportWrite(value, super.loadingServer, () {
      super.loadingServer = value;
    });
  }

  final _$loadingBuscaConfigurationsAtom =
      Atom(name: '_ConfiguracaoControllerBase.loadingBuscaConfigurations');

  @override
  bool get loadingBuscaConfigurations {
    _$loadingBuscaConfigurationsAtom.reportRead();
    return super.loadingBuscaConfigurations;
  }

  @override
  set loadingBuscaConfigurations(bool value) {
    _$loadingBuscaConfigurationsAtom
        .reportWrite(value, super.loadingBuscaConfigurations, () {
      super.loadingBuscaConfigurations = value;
    });
  }

  final _$onTapSalvaConfiguracoesAsyncAction =
      AsyncAction('_ConfiguracaoControllerBase.onTapSalvaConfiguracoes');

  @override
  Future<void> onTapSalvaConfiguracoes() {
    return _$onTapSalvaConfiguracoesAsyncAction
        .run(() => super.onTapSalvaConfiguracoes());
  }

  final _$onTapIpsAsyncAction =
      AsyncAction('_ConfiguracaoControllerBase.onTapIps');

  @override
  Future<void> onTapIps(String porta, String ip) {
    return _$onTapIpsAsyncAction.run(() => super.onTapIps(porta, ip));
  }

  final _$onTapBuscaConfigurationsAsyncAction =
      AsyncAction('_ConfiguracaoControllerBase.onTapBuscaConfigurations');

  @override
  Future<void> onTapBuscaConfigurations() {
    return _$onTapBuscaConfigurationsAsyncAction
        .run(() => super.onTapBuscaConfigurations());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
loadingServer: ${loadingServer},
loadingBuscaConfigurations: ${loadingBuscaConfigurations}
    ''';
  }
}
