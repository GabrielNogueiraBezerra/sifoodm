import 'package:flutter_modular/flutter_modular.dart';

import 'insere_produto_controller.dart';
import 'insere_produto_page.dart';
import 'insere_produto_routes.dart';
import 'pages/insere_adicional/insere_adicional_controller.dart';
import 'pages/insere_adicional/insere_adicional_page.dart';

class InsereProdutoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $InsereAdicionalController,
        $InsereProdutoController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          InsereProdutoRoutes.inicio,
          child: (_, args) => InsereProdutoPage(
            produto: args.data["produto"],
            index: args.data["index"],
            itemComanda: args.data["itemComanda"],
          ),
        ),
        ModularRouter(
          InsereProdutoRoutes.insereAdicionalModule,
          child: (_, args) => InsereAdicionalPage(),
        ),
      ];

  static Inject get to => Inject<InsereProdutoModule>.of();
}
