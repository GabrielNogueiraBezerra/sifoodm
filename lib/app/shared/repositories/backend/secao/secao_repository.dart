import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../../../models/secao.dart';
import '../interface_repository.dart';

class SecaoRepository extends IRepository {
  final CustomDio _client;

  SecaoRepository(this._client) {
    super.router = "/secoes";
  }
  @override
  Future<List<Secao>> index() async {
    try {
      var route = "${super.router}";

      var response = await _client.getApi().get(route);

      if (response.data['status'] != 0) {
        throw Exception(
          response.data['mensagem'],
        );
      }

      return (response.data == null)
          ? null
          : (response.data['secoes'] as List).isEmpty
              ? null
              : List<Secao>.from((response.data['secoes'] as List)
                  .map((secao) => Secao.fromMap(secao)));
    } on DioError catch (e) {
      throw DioError(
        error: e.response != null
            ? e.response.data["mensagem"]
            : 'Não foi possível buscar seções, verifique a conexão e tente novamente.',
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
