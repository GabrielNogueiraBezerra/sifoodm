import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_routes.dart';
import 'app_widget.dart';
import 'controllers/local_storage_configurations.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'modules/splash/splash_module.dart';
import 'shared/client/custom_dio/custom_dio.dart';
import 'shared/repositories/storages/local_storages/local_storage_service.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
        Bind((i) => LocalStorageConfigurations(i.get<LocalStorageService>())),
        Bind((i) => LocalStorageService()),
        Bind((i) => CustomDio()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          AppRoutes.inicio,
          module: SplashModule(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          AppRoutes.login,
          module: LoginModule(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          AppRoutes.home,
          module: HomeModule(),
          transition: TransitionType.fadeIn,
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
