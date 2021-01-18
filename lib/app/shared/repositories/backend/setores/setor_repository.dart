import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../../../models/setor.dart';
import '../interface_repository.dart';

class SetorRepository extends IRepository {
  final CustomDio _client;

  SetorRepository(this._client) {
    super.router = "/setores";
  }
  @override
  Future<List<Setor>> index() async {
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
          : (response.data['setores'] as List).isEmpty
              ? null
              : List<Setor>.from((response.data['setores'] as List)
                  .map((setor) => Setor.fromMap(setor)));
    } on DioError catch (e) {
      throw DioError(
        error: e.response != null
            ? e.response.data["mensagem"]
            : 'Não foi possível buscar setores, verifique a conexão e tente novamente.',
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
