// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage_configurations.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocalStorageConfigurations on _LocalStorageConfigurationsBase, Store {
  final _$conexaoAtom = Atom(name: '_LocalStorageConfigurationsBase.conexao');

  @override
  Conexao get conexao {
    _$conexaoAtom.reportRead();
    return super.conexao;
  }

  @override
  set conexao(Conexao value) {
    _$conexaoAtom.reportWrite(value, super.conexao, () {
      super.conexao = value;
    });
  }

  final _$buscarConexaoAsyncAction =
      AsyncAction('_LocalStorageConfigurationsBase.buscarConexao');

  @override
  Future<void> buscarConexao() {
    return _$buscarConexaoAsyncAction.run(() => super.buscarConexao());
  }

  final _$salvarConfiguracaoAsyncAction =
      AsyncAction('_LocalStorageConfigurationsBase.salvarConfiguracao');

  @override
  Future<void> salvarConfiguracao(
      {String host,
      String porta,
      bool lembraCredenciais,
      String nomeUsuario,
      bool dismiss,
      int ordenacao}) {
    return _$salvarConfiguracaoAsyncAction.run(() => super.salvarConfiguracao(
        host: host,
        porta: porta,
        lembraCredenciais: lembraCredenciais,
        nomeUsuario: nomeUsuario,
        dismiss: dismiss,
        ordenacao: ordenacao));
  }

  @override
  String toString() {
    return '''
conexao: ${conexao}
    ''';
  }
}
