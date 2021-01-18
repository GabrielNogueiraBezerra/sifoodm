import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../comanda_controller.dart';

part 'totais_controller.g.dart';

@Injectable()
class TotaisController = _TotaisControllerBase with _$TotaisController;

abstract class _TotaisControllerBase with Store implements Disposable {
  final ComandaController comandaController = Modular.get<ComandaController>();

  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
  }

  _TotaisControllerBase() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        comandaController.adicionaNovaPaginaItensComandas();
      }
    });
  }
}
