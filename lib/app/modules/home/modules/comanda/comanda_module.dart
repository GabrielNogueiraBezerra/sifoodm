import 'package:flutter_modular/flutter_modular.dart';

import 'comanda_controller.dart';
import 'comanda_page.dart';
import 'comanda_routes.dart';
import 'modules/altera_comanda/altera_comanda_module.dart';
import 'modules/confirma_itens/confirma_itens_module.dart';
import 'modules/insere_produto/insere_produto_module.dart';

class ComandaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ComandaController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          ComandaRoutes.inicio,
          child: (_, args) => ComandaPage(comanda: args.data),
        ),
        ModularRouter(
          ComandaRoutes.alteraComandaModule,
          module: AlteraComandaModule(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          ComandaRoutes.confirmaItensModule,
          module: ConfirmaItensModule(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(
          ComandaRoutes.insereProdutoModule,
          module: InsereProdutoModule(),
          transition: TransitionType.fadeIn,
        ),
      ];

  static Inject get to => Inject<ComandaModule>.of();
}
