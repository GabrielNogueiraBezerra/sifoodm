import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../interface_repository.dart';

class ImpressaoComandaRepository extends IRepository {
  final CustomDio _client;

  ImpressaoComandaRepository(this._client) {
    super.router = "/imprimeComanda";
  }

  @override
  Future<dynamic> show() async {
    try {
      var route = "${super.router}?codigo="
          "${super.data["codigo"].trim()}&codemp="
          "${super.data["codemp"].trim()}&codvend="
          "${super.data["codvend"].trim()}";

      var response = await _client.getApi().get(route);

      if (response.data['status'] != 0) {
        throw Exception(
          response.data['mensagem'],
        );
      }
      return response.data;
    } on DioError catch (e) {
      throw DioError(
        error: e.response != null
            ? e.response.data["mensagem"]
            : 'Não foi possível imprimir comanda, verifique a conexão e tente novamente.',
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
