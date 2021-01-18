import 'package:flutter_modular/flutter_modular.dart';

import 'nova_comanda_controller.dart';
import 'nova_comanda_page.dart';

class NovaComandaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $NovaComandaController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => NovaComandaPage()),
      ];

  static Inject get to => Inject<NovaComandaModule>.of();
}
