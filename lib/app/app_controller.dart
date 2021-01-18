import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'controllers/local_storage_configurations.dart';
import 'shared/client/custom_dio/custom_dio.dart';
import 'shared/models/empresa.dart';
import 'shared/models/secao.dart';
import 'shared/models/setor.dart';
import 'shared/models/usuario.dart';
import 'shared/repositories/backend/interface_repository.dart';
import 'shared/repositories/backend/secao/secao_repository.dart';
import 'shared/repositories/backend/setores/setor_repository.dart';
import 'shared/utils/utils.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final LocalStorageConfigurations storageConfigurations;

  IRepository _repository;

  @observable
  List<Setor> setores;

  @action
  Future<void> buscaSetores() async {
    if (empresa.configuracoes.usarSetorComandasRest) {
      _repository = SetorRepository(Modular.get<CustomDio>());
      _repository.data = {};

      setores = await _repository.index();
    }
  }

  @observable
  List<Secao> secoes;

  @observable
  bool loading = false;

  @action
  Future<void> buscaSecoes() async {
    try {
      try {
        secoes = null;
        _repository = SecaoRepository(Modular.get<CustomDio>());
        _repository.data = {};

        secoes = await _repository.index();
      } on DioError catch (e) {
        Utils().showAlert(mensagem: e.error);
        loading = false;
      }
    } on Exception catch (e) {
      Utils().showAlert(mensagem: e.toString());
      loading = false;
    }
  }

  @observable
  Usuario usuario;

  @observable
  Empresa empresa;

  Future<void> buscaConexao() async {
    await storageConfigurations.buscarConexao();
  }

  @action
  Future<void> logout() async {
    usuario = null;
    empresa = null;
    await buscaConexao();
  }

  _AppControllerBase(this.storageConfigurations) {
    buscaConexao();
  }
}
