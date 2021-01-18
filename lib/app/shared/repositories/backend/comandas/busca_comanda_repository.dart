import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../interface_repository.dart';

class BuscaComandaRepository extends IRepository {
  final CustomDio _client;

  BuscaComandaRepository(this._client) {
    super.router = "/buscaComanda";
  }

  @override
  Future<dynamic> show() async {
    try {
      var route = "${super.router}/?codigo="
          "${super.data["codigo"].trim()}";

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
            : 'Não foi possível buscar comanda, verifique a conexão e tente novamente.',
        request: e.request,
        response: e.response,
        type: e.type,
      );
    }
  }

  @override
  Future<void> update() async {
    try {
      var data = {
        'codigo': int.parse(super.data["codigo"]),
        'descricao': super.data["descricao"],
        'numero_pessoas': super.data["numero_pessoas"],
      };

      var route = "${super.router}?data=${jsonEncode(data)}";

      var response = await _client.getApi().put(
            route,
          );

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
