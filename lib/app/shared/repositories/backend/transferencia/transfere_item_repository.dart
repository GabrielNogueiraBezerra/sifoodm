import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../interface_repository.dart';

class TransfereItemRepository extends IRepository {
  final CustomDio _client;

  TransfereItemRepository(this._client) {
    super.router = "/transfereItem";
  }
  @override
  Future<void> show() async {
    try {
      var route = "${super.router}?codigonovo="
          "${super.data["codigonovo"].trim()}&codigoantigo="
          "${super.data["codigoantigo"].trim()}&data="
          "${super.data["data"].trim()}";

      var response = await _client.getApi().get(route);

      if (response.data['status'] != 0) {
        throw Exception(
          response.data['mensagem'],
        );
      }
    } on DioError catch (e) {
      throw DioError(
        error: e.response != null
            ? e.response.data["mensagem"]
            : 'Não foi possível transferir item, verifique a conexão e tente novamente.',
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
