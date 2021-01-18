import 'package:flutter_modular/flutter_modular.dart';

import 'altera_comanda_controller.dart';
import 'altera_comanda_page.dart';

class AlteraComandaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $AlteraComandaController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => AlteraComandaPage()),
      ];

  static Inject get to => Inject<AlteraComandaModule>.of();
}
