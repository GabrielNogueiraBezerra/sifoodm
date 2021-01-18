import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../../../models/item_comanda.dart';
import '../interface_repository.dart';

class BuscaItensRepository extends IRepository {
  final CustomDio _client;

  BuscaItensRepository(this._client) {
    super.router = "/itensTransferencia";
  }
  @override
  Future<List<ItemComanda>> index() async {
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

      return List<ItemComanda>.from((response.data['itens_comanda'] as List)
          .map((item) => ItemComanda.fromMap(item)));
    } on DioError catch (e) {
      throw DioError(
        error: e.response != null
            ? e.response.data["mensagem"]
            : 'Não foi possível buscar itens comanda, verifique a conexão e tente novamente.',
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
