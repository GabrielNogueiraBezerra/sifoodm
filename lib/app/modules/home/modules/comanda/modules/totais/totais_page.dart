import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/features/styles/styles_default.dart';
import '../../../../widgets/custom_not_found.dart';
import '../../widgets/custom_app_bar.dart';
import 'totais_controller.dart';

class TotaisPage extends StatefulWidget {
  final String title;
  const TotaisPage({Key key, this.title = "Totais"}) : super(key: key);

  @override
  _TotaisPageState createState() => _TotaisPageState();
}

class _TotaisPageState extends ModularState<TotaisPage, TotaisController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: StylesDefault().backgroundColor,
        statusBarBrightness:
            Theme.of(context).platform == TargetPlatform.android
                ? Brightness.dark
                : Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: StylesDefault().backgroundColor,
        systemNavigationBarDividerColor: StylesDefault().primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              MediaQuery.of(Modular.navigatorKey.currentContext).size.height *
                  0.08),
          child: Observer(builder: (context) {
            return CustomAppBar(
              onPressed: controller.comandaController.onPressedBack,
              onTap: controller.comandaController.onTapEditarComanda,
              title:
                  'Comanda ${controller.comandaController.comanda?.formatConta ?? ''}',
              subtitle: '${controller.comandaController.comanda.descMesa}',
            );
          }),
        ),
        backgroundColor: StylesDefault().backgroundColor,
        body: SafeArea(
          child: Observer(
            builder: (context) {
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.comandaController.buscaItensComanda();
                },
                backgroundColor: StylesDefault().secondaryColor,
                child: listView,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get listView {
    if (!controller.comandaController.loading) {
      var itemCount = 0;

      if (controller.comandaController.busca != null) {
        if (controller.comandaController.itensComandaTotais != null) {
          itemCount +=
              controller.comandaController.itensComandaTotais.length + 1;
        }
      }

      if (itemCount == 1) {
        return ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            CustomNotFound(
              descricao: 'Nenhum item foi confirmado para que\n'
                  'seja gerado totais e conferências.',
            ),
          ],
        );
      } else {
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          controller: controller.scrollController,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (index <=
                controller.comandaController.itensComandaTotais.length - 1) {
              return controller.comandaController.itensComandaTotais
                  .elementAt(index)
                  .item(
                    context: context,
                    last: index ==
                        controller.comandaController.itensComandaTotais.length -
                            1,
                    onTap: () {},
                  );
            } else {
              if (controller.comandaController.pageItensComanda <
                  controller.comandaController.busca["count"]) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .08,
                  ),
                  child: Container(
                    color: StylesDefault().backgroundColor,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: MediaQuery.of(context).size.height * 0.02,
                        child: CircularProgressIndicator(
                          backgroundColor: StylesDefault().secondaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  height: 40.h,
                );
              }
            }
          },
        );
      }
    } else {
      return Center(
          child: CircularProgressIndicator(
              backgroundColor: StylesDefault().secondaryColor));
    }
  }
}
