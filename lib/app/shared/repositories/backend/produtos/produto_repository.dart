import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../../../models/produto.dart';
import '../interface_repository.dart';

class ProdutoRepository extends IRepository {
  final CustomDio _client;

  ProdutoRepository(this._client) {
    super.router = "/produto";
  }

  @override
  Future<dynamic> index() async {
    try {
      var route = "${super.router}s?codsec="
          "${super.data["codsec"].trim()}&codemp="
          "${super.data["codemp"].trim()}&page="
          "${super.data["page"].trim()}&pesquisa="
          "${super.data["pesquisa"].trim()}";

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
            : 'Não foi possível buscar produtos, verifique a conexão e tente novamente.',
        request: e.request,
        response: e.response,
        type: e.type,
      );
    }
  }

  @override
  Future<Produto> show() async {
    try {
      var route = "${super.router}?codpro="
          "${super.data["codpro"].trim()}&codemp="
          "${super.data["codemp"].trim()}";

      var response = await _client.getApi().get(route);

      if (response.data['status'] != 0) {
        throw Exception(
          response.data['mensagem'],
        );
      }

      return (response.data == null)
          ? null
          : Produto.fromMap(response.data['produto']);
    } on DioError catch (e) {
      throw DioError(
        error: e.response != null
            ? e.response.data["mensagem"]
            : 'Não foi possível buscar produto, verifique a conexão e tente novamente.',
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
