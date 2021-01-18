import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_controller.dart';
import '../interceptors.dart';

class CustomDio {
  final AppController _appController = Modular.get<AppController>();

  Dio getApi() {
    if (_appController.storageConfigurations == null) {
      throw Exception("Esse aplicativo não foi devidamente configurado.");
    }

    if (_appController.storageConfigurations.conexao == null) {
      throw Exception("Esse aplicativo não foi devidamente configurado.");
    }

    if (_appController.storageConfigurations.conexao.porta == null ||
        _appController.storageConfigurations.conexao.host == null) {
      throw Exception("Esse aplicativo não foi devidamente configurado.");
    }

    if (_appController.storageConfigurations.conexao.porta.trim() == '' ||
        _appController.storageConfigurations.conexao.host.trim() == '') {
      throw Exception("Esse aplicativo não foi devidamente configurado.");
    }

    var dio = Dio(
      BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 5000,
        baseUrl: _appController.storageConfigurations.conexao.baseUrl,
      ),
    );

    dio.interceptors.add(CustomInterceptors());

    return dio;
  }
}
