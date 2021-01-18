import 'package:flutter_modular/flutter_modular.dart';

import 'totais_controller.dart';
import 'totais_page.dart';

class TotaisModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $TotaisController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => TotaisPage()),
      ];

  static Inject get to => Inject<TotaisModule>.of();
}
