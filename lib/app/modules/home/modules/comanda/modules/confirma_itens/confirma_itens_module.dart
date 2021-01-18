import 'package:flutter_modular/flutter_modular.dart';

import 'confirma_itens_controller.dart';
import 'confirma_itens_page.dart';

class ConfirmaItensModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ConfirmaItensController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => ConfirmaItensPage()),
      ];

  static Inject get to => Inject<ConfirmaItensModule>.of();
}
