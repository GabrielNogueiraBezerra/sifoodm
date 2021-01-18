import 'package:flutter_modular/flutter_modular.dart';

import 'busca_controller.dart';
import 'busca_page.dart';

class BuscaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $BuscaController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => BuscaPage()),
      ];

  static Inject get to => Inject<BuscaModule>.of();
}
