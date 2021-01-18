// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AppController = BindInject(
  (i) => AppController(i<LocalStorageConfigurations>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  final _$setoresAtom = Atom(name: '_AppControllerBase.setores');

  @override
  List<Setor> get setores {
    _$setoresAtom.reportRead();
    return super.setores;
  }

  @override
  set setores(List<Setor> value) {
    _$setoresAtom.reportWrite(value, super.setores, () {
      super.setores = value;
    });
  }

  final _$secoesAtom = Atom(name: '_AppControllerBase.secoes');

  @override
  List<Secao> get secoes {
    _$secoesAtom.reportRead();
    return super.secoes;
  }

  @override
  set secoes(List<Secao> value) {
    _$secoesAtom.reportWrite(value, super.secoes, () {
      super.secoes = value;
    });
  }

  final _$loadingAtom = Atom(name: '_AppControllerBase.loading');

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

  final _$usuarioAtom = Atom(name: '_AppControllerBase.usuario');

  @override
  Usuario get usuario {
    _$usuarioAtom.reportRead();
    return super.usuario;
  }

  @override
  set usuario(Usuario value) {
    _$usuarioAtom.reportWrite(value, super.usuario, () {
      super.usuario = value;
    });
  }

  final _$empresaAtom = Atom(name: '_AppControllerBase.empresa');

  @override
  Empresa get empresa {
    _$empresaAtom.reportRead();
    return super.empresa;
  }

  @override
  set empresa(Empresa value) {
    _$empresaAtom.reportWrite(value, super.empresa, () {
      super.empresa = value;
    });
  }

  final _$buscaSetoresAsyncAction =
      AsyncAction('_AppControllerBase.buscaSetores');

  @override
  Future<void> buscaSetores() {
    return _$buscaSetoresAsyncAction.run(() => super.buscaSetores());
  }

  final _$buscaSecoesAsyncAction =
      AsyncAction('_AppControllerBase.buscaSecoes');

  @override
  Future<void> buscaSecoes() {
    return _$buscaSecoesAsyncAction.run(() => super.buscaSecoes());
  }

  final _$logoutAsyncAction = AsyncAction('_AppControllerBase.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
setores: ${setores},
secoes: ${secoes},
loading: ${loading},
usuario: ${usuario},
empresa: ${empresa}
    ''';
  }
}
