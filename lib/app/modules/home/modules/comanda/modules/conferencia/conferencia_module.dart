import 'package:flutter_modular/flutter_modular.dart';

import 'conferencia_controller.dart';
import 'conferencia_page.dart';

class ConferenciaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ConferenciaController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => ConferenciaPage()),
      ];

  static Inject get to => Inject<ConferenciaModule>.of();
}
