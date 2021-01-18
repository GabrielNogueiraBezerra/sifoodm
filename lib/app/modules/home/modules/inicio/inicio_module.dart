import 'package:flutter_modular/flutter_modular.dart';

import 'inicio_controller.dart';
import 'inicio_page.dart';

class InicioModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $InicioController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => InicioPage()),
      ];

  static Inject get to => Inject<InicioModule>.of();
}
