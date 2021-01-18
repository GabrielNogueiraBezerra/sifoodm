import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../interface_repository.dart';

class QuantidadeComandasRepository extends IRepository {
  final CustomDio _client;

  QuantidadeComandasRepository(this._client) {
    super.router = "/quantidade_comandas";
  }

  @override
  Future<int> show() async {
    try {
      var route = "${super.router}?codvend="
          "${super.data["codvend"].trim()}&codemp="
          "${super.data["codemp"].trim()}";

      var response = await _client.getApi().get(route);

      if (response.data['status'] != 0) {
        throw Exception(
          response.data['mensagem'],
        );
      }
      return int.parse(response.data['quantidade'].toString());
    } on DioError catch (e) {
      throw DioError(
        error: e.response != null
            ? e.response.data["mensagem"]
            : 'Não foi possível buscar comandas, verifique a conexão e tente novamente.',
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
