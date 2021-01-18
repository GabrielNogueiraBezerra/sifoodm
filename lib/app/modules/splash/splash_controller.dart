import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app_routes.dart';

part 'splash_controller.g.dart';

@Injectable()
class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  Future<void> loadingSplash() async {
    Future.delayed(Duration(seconds: 2)).then((v) async {
      Modular.to.pushReplacementNamed(AppRoutes.login);
    });
  }

  _SplashControllerBase() {
    loadingSplash();
  }
}
