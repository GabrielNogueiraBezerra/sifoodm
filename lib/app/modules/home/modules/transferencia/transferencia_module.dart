import 'package:flutter_modular/flutter_modular.dart';

import 'pages/finalizacao/finalizacao_controller.dart';
import 'pages/finalizacao/finalizacao_page.dart';
import 'pages/itens_comanda/itens_comanda_controller.dart';
import 'pages/itens_comanda/itens_comanda_page.dart';
import 'pages/segunda_comanda/segunda_comanda_controller.dart';
import 'pages/segunda_comanda/segunda_comanda_page.dart';
import 'transferencia_controller.dart';
import 'transferencia_page.dart';
import 'transferencia_routes.dart';

class TransferenciaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $FinalizacaoController,
        $SegundaComandaController,
        $ItensComandaController,
        $TransferenciaController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          TransferenciaRoutes.inicio,
          child: (_, args) => TransferenciaPage(),
        ),
        ModularRouter(
          TransferenciaRoutes.itensComandaModule,
          child: (_, args) => ItensComandaPage(
            comanda: args.data,
          ),
          transition: TransitionType.rightToLeft,
        ),
        ModularRouter(
          TransferenciaRoutes.segundaComandaModule,
          child: (_, args) => SegundaComandaPage(
            comanda: args.data['comanda'],
            itensComanda: args.data['itensComanda'],
          ),
          transition: TransitionType.rightToLeft,
        ),
        ModularRouter(
          TransferenciaRoutes.finalizacaoModule,
          child: (_, args) => FinalizacaoPage(),
          transition: TransitionType.downToUp,
        ),
      ];

  static Inject get to => Inject<TransferenciaModule>.of();
}
