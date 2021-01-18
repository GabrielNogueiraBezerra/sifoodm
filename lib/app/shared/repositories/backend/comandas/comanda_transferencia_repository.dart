import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../interface_repository.dart';

class ComandaTransferenciaRepository extends IRepository {
  final CustomDio _client;

  ComandaTransferenciaRepository(this._client) {
    super.router = "/consultaComanda";
  }

  @override
  Future<dynamic> show() async {
    try {
      var route = "${super.router}/?conta="
          "${super.data["conta"].trim()}&codemp="
          "${super.data["codemp"].trim()}";

      var response = await _client.getApi().get(route);

      if (response.data['status'] == 1) {
        throw Exception(
          response.data['mensagem'],
        );
      }
      return response.data;
    } on DioError catch (e) {
      throw DioError(
        error: e.response != null
            ? e.response.data["mensagem"]
            : 'Não foi possível buscar comanda, verifique a conexão e tente novamente.',
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
