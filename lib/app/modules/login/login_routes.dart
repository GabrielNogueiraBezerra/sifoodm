import 'package:flutter_modular/flutter_modular.dart';
import '../../app_routes.dart';

class LoginRoutes {
  static const inicio = Modular.initialRoute;
  static const root = AppRoutes.login;

  static const configuracaoModule = '${inicio}configuracao';

  static const configuracao = '$root$configuracaoModule';
}
