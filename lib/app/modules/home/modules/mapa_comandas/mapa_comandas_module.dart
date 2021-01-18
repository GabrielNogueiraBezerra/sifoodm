import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/client/custom_dio/custom_dio.dart';
import '../../../../shared/repositories/backend/comandas/comanda_repository.dart';
import 'mapa_comandas_controller.dart';
import 'mapa_comandas_page.dart';

class MapaComandasModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ComandaRepository(i.get<CustomDio>())),
        $MapaComandasController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => MapaComandasPage()),
      ];

  static Inject get to => Inject<MapaComandasModule>.of();
}
