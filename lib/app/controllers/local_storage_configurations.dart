import 'dart:convert';

import 'package:mobx/mobx.dart';

import '../shared/models/conexao.dart';
import '../shared/repositories/storages/interfaces/ilocal_storage_service.dart';

part 'local_storage_configurations.g.dart';

class LocalStorageConfigurations = _LocalStorageConfigurationsBase
    with _$LocalStorageConfigurations;

abstract class _LocalStorageConfigurationsBase with Store {
  final ILocalStorageService _localStorage;

  @observable
  Conexao conexao;

  String get _nameStorage => "configurations.sifoodm";

  @action
  Future<void> buscarConexao() async {
    conexao = null;

    var json = await _localStorage.getValue<String>(_nameStorage);

    if (json != null) {
      conexao = Conexao.fromJson(jsonDecode(json));
    }
  }

  @action
  Future<void> salvarConfiguracao({
    String host,
    String porta,
    bool lembraCredenciais,
    String nomeUsuario,
    bool dismiss,
    int ordenacao,
  }) async {
    if (conexao == null) {
      conexao = Conexao(host: host, porta: porta, protocolo: 'http');
    } else {
      conexao = conexao.copyWith(
        host: host,
        porta: porta,
        lembraCredenciais:
            lembraCredenciais == null ? false : lembraCredenciais,
        nomeUsuario: nomeUsuario,
        dismiss: dismiss == null ? false : dismiss,
        ordenacao: ordenacao == null ? 0 : ordenacao,
      );
    }

    var json = jsonEncode(conexao);
    await _localStorage.setValue(_nameStorage, json);
  }

  _LocalStorageConfigurationsBase(this._localStorage);
}
