import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../interface_repository.dart';

class ItemComandaRepository extends IRepository {
  final CustomDio _client;

  ItemComandaRepository(this._client) {
    super.router = "/itensComanda";
  }

  @override
  Future<dynamic> index() async {
    try {
      var route = "${super.router}?codigo="
          "${super.data["codigo"].trim()}&codemp="
          "${super.data["codemp"].trim()}&page="
          "${super.data["page"].trim()}";

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
            : 'Não foi possível buscar itens da comanda, verifique a conexão e tente novamente.',
        request: e.request,
        response: e.response,
        type: e.type,
      );
    }
  }

  Future<void> store() async {
    try {
      var route = "${super.router}?codigo="
          "${super.data["codigo"].trim()}&codvend="
          "${super.data["codvend"].trim()}&codemp="
          "${super.data["codemp"].trim()}&data="
          "${super.data["data"].trim()}&conta="
          "${super.data["conta"].trim()}&descmesa="
          "${super.data["descmesa"].trim()}&codsetor="
          "${super.data["codsetor"].trim()}&totalpessoas="
          "${super.data["totalpessoas"].trim()}";

      var response = await _client.getApi().post(route);

      if (response.data['status'] != 0) {
        throw Exception(
          response.data['mensagem'],
        );
      }
    } on DioError catch (e) {
      throw DioError(
        error: e.response != null
            ? e.response.data["mensagem"]
            : 'Não foi possível buscar itens da comanda, verifique a conexão e tente novamente.',
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
