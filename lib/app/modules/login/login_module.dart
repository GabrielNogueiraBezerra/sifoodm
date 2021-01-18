import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/client/custom_dio/custom_dio.dart';
import '../../shared/repositories/backend/usuarios/usuario_repository.dart';
import 'login_controller.dart';
import 'login_page.dart';
import 'login_routes.dart';
import 'pages/configuracao/configuracao_controller.dart';
import 'pages/configuracao/configuracao_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => UsuarioRepository(i.get<CustomDio>())),
        $ConfiguracaoController,
        $LoginController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          LoginRoutes.inicio,
          child: (_, args) => LoginPage(),
        ),
        ModularRouter(
          LoginRoutes.configuracaoModule,
          child: (_, args) => ConfiguracaoPage(),
          transition: TransitionType.fadeIn,
        ),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
