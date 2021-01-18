import 'package:flutter_modular/flutter_modular.dart';

import '../../home_routes.dart';

class ComandaRoutes {
  static const inicio = Modular.initialRoute;
  static const root = HomeRoutes.comanda;

  static const alteraComandaModule = '${inicio}alteraComanda';
  static const insereProdutoModule = '${inicio}insereProduto';
  static const confirmaItensModule = '${inicio}confirmaItens';

  static const alteraComanda = '$root$alteraComandaModule';
  static const insereProduto = '$root$insereProdutoModule';
  static const confirmaItens = '$root$confirmaItensModule';
}
