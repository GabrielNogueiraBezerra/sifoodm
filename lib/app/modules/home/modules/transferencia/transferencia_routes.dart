import 'package:flutter_modular/flutter_modular.dart';

import '../../home_routes.dart';

class TransferenciaRoutes {
  static const inicio = Modular.initialRoute;
  static const root = HomeRoutes.transferencia;

  static const itensComandaModule = '${inicio}itensComanda';
  static const segundaComandaModule = '${inicio}segundaComanda';
  static const finalizacaoModule = '${inicio}finalizacao';

  static const itensComanda = '$root$itensComandaModule';
  static const segundaComanda = '$root$segundaComandaModule';
  static const finalizacao = '$root$finalizacaoModule';
}
