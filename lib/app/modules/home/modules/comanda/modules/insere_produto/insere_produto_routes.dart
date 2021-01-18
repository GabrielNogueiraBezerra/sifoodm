import 'package:flutter_modular/flutter_modular.dart';

import '../../comanda_routes.dart';

class InsereProdutoRoutes {
  static const inicio = Modular.initialRoute;
  static const root = ComandaRoutes.insereProduto;

  static const insereAdicionalModule = '${inicio}insereAdicional';

  static const insereAdicional = '$root$insereAdicionalModule';
}
