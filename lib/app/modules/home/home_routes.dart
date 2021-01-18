import 'package:flutter_modular/flutter_modular.dart';
import '../../app_routes.dart';

class HomeRoutes {
  static const inicio = Modular.initialRoute;
  static const root = AppRoutes.home;

  static const mapaComandasModule = '${inicio}mapaComandas';
  static const novaComandaModule = '${inicio}novaComanda';
  static const comandaModule = '${inicio}comanda';
  static const transferenciaModule = '${inicio}transferencia';

  static const mapaComandas = '$root$mapaComandasModule';
  static const novaComanda = '$root$novaComandaModule';
  static const comanda = '$root$comandaModule';
  static const transferencia = '$root$transferenciaModule';
}
