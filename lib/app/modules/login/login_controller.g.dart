// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $LoginController = BindInject(
  (i) => LoginController(i<IRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$textEditingControllerNomeUsuarioAtom =
      Atom(name: '_LoginControllerBase.textEditingControllerNomeUsuario');

  @override
  TextEditingController get textEditingControllerNomeUsuario {
    _$textEditingControllerNomeUsuarioAtom.reportRead();
    return super.textEditingControllerNomeUsuario;
  }

  @override
  set textEditingControllerNomeUsuario(TextEditingController value) {
    _$textEditingControllerNomeUsuarioAtom
        .reportWrite(value, super.textEditingControllerNomeUsuario, () {
      super.textEditingControllerNomeUsuario = value;
    });
  }

  final _$lembraCredenciaisAtom =
      Atom(name: '_LoginControllerBase.lembraCredenciais');

  @override
  bool get lembraCredenciais {
    _$lembraCredenciaisAtom.reportRead();
    return super.lembraCredenciais;
  }

  @override
  set lembraCredenciais(bool value) {
    _$lembraCredenciaisAtom.reportWrite(value, super.lembraCredenciais, () {
      super.lembraCredenciais = value;
    });
  }

  final _$loadingAtom = Atom(name: '_LoginControllerBase.loading');

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

  final _$changeCredenciaisAsyncAction =
      AsyncAction('_LoginControllerBase.changeCredenciais');

  @override
  Future<void> changeCredenciais() {
    return _$changeCredenciaisAsyncAction.run(() => super.changeCredenciais());
  }

  final _$selecionaEmpresaAsyncAction =
      AsyncAction('_LoginControllerBase.selecionaEmpresa');

  @override
  Future<void> selecionaEmpresa(int index) {
    return _$selecionaEmpresaAsyncAction
        .run(() => super.selecionaEmpresa(index));
  }

  final _$onTapLoginAsyncAction =
      AsyncAction('_LoginControllerBase.onTapLogin');

  @override
  Future<void> onTapLogin() {
    return _$onTapLoginAsyncAction.run(() => super.onTapLogin());
  }

  final _$onTapGearAsyncAction = AsyncAction('_LoginControllerBase.onTapGear');

  @override
  Future<void> onTapGear() {
    return _$onTapGearAsyncAction.run(() => super.onTapGear());
  }

  final _$buscaConexaoAsyncAction =
      AsyncAction('_LoginControllerBase.buscaConexao');

  @override
  Future<void> buscaConexao() {
    return _$buscaConexaoAsyncAction.run(() => super.buscaConexao());
  }

  @override
  String toString() {
    return '''
textEditingControllerNomeUsuario: ${textEditingControllerNomeUsuario},
lembraCredenciais: ${lembraCredenciais},
loading: ${loading}
    ''';
  }
}
