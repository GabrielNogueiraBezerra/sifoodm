import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../../../models/usuario.dart';
import '../interface_repository.dart';

class UsuarioRepository extends IRepository {
  final CustomDio _client;

  UsuarioRepository(this._client) {
    super.router = "/usuarios";
  }
  @override
  Future<Usuario> show() async {
    try {
      var route = "${super.router}?usuario="
          "${super.data["usuario"].trim()}&senha="
          "${super.data["senha"].trim()}&numeroserie="
          "${super.data["numeroserie"].trim()}";

      var response = await _client.getApi().get(route);

      if (response.data['status'] != 0) {
        throw Exception(
          response.data['mensagem'],
        );
      }
      return (response.data == null)
          ? null
          : Usuario.fromMap(response.data['usuario']);
    } on DioError catch (e) {
      throw DioError(
        error: e.response != null
            ? e.response.data["mensagem"]
            : 'Não foi possível buscar usuários, verifique a conexão e tente novamente.',
        request: e.request,
        response: e.response,
        type: e.type,
      );
    }
  }

  Future noSuchMethod(Invocation invocation) async {
    return super.noSuchMethod(invocation);
  }
}
