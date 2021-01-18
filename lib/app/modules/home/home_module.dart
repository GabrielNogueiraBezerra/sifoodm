import 'package:flutter_modular/flutter_modular.dart';

import 'home_routes.dart';
import 'modules/comanda/comanda_module.dart';
import 'modules/inicio/inicio_module.dart';
import 'modules/mapa_comandas/mapa_comandas_module.dart';
import 'modules/nova_comanda/nova_comanda_module.dart';
import 'modules/transferencia/transferencia_module.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(HomeRoutes.inicio,
            module: InicioModule(), transition: TransitionType.fadeIn),
        ModularRouter(HomeRoutes.mapaComandasModule,
            module: MapaComandasModule(), transition: TransitionType.fadeIn),
        ModularRouter(HomeRoutes.novaComandaModule,
            module: NovaComandaModule(), transition: TransitionType.fadeIn),
        ModularRouter(HomeRoutes.comandaModule,
            module: ComandaModule(), transition: TransitionType.fadeIn),
        ModularRouter(HomeRoutes.transferenciaModule,
            module: TransferenciaModule(), transition: TransitionType.fadeIn),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
