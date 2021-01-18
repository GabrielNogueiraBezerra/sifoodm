import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../client/custom_dio/custom_dio.dart';
import '../interface_repository.dart';

class ComandaRepository extends IRepository {
  final CustomDio _client;

  ComandaRepository(this._client) {
    super.router = "/comanda";
  }

  @override
  Future<dynamic> index() async {
    try {
      var route = "${super.router}s?codvend="
          "${super.data["codvend"].trim()}&codemp="
          "${super.data["codemp"].trim()}&mostratodas="
          "${super.data["mostratodas"].trim()}&page="
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
            : 'Não foi possível buscar comandas, verifique a conexão e tente novamente.',
        request: e.request,
        response: e.response,
        type: e.type,
      );
    }
  }

  @override
  Future<dynamic> show() async {
    try {
      var route = "${super.router}/?codsetor="
          "${super.data["codsetor"].trim()}&descmesa="
          "${super.data["descmesa"].trim()}&codemp="
          "${super.data["codemp"].trim()}&codvend="
          "${super.data["codvend"].trim()}&conta="
          "${super.data["conta"].trim()}&totalpessoas="
          "${super.data["totalpessoas"].trim()}";

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
            : 'Não foi possível buscar comandas, verifique a conexão e tente novamente.',
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
