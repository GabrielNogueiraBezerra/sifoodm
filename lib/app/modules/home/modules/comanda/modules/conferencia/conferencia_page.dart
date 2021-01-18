import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/features/styles/styles_default.dart';
import '../../../../../../shared/models/adicional.dart';
import '../../../../../../shared/models/item_comanda.dart';
import '../../../../../../shared/utils/utils.dart';
import '../../../../widgets/custom_not_found.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_app_bar_selected.dart';
import 'conferencia_controller.dart';

class ConferenciaPage extends StatefulWidget {
  const ConferenciaPage({Key key}) : super(key: key);

  @override
  _ConferenciaPageState createState() => _ConferenciaPageState();
}

class _ConferenciaPageState
    extends ModularState<ConferenciaPage, ConferenciaController> {
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
      child: Observer(
        builder: (context) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.h),
              child: Observer(builder: (context) {
                return controller.comandaController.itensSelecteds.isEmpty
                    ? CustomAppBar(
                        onPressed: controller.comandaController.onPressedBack,
                        onTap: controller.comandaController.onTapEditarComanda,
                        title:
                            'Comanda ${controller.comandaController.comanda?.formatConta ?? ''}',
                        subtitle:
                            '${controller.comandaController.comanda.descMesa}',
                      )
                    : CustomAppBarSelected(
                        onPressedBack: () {
                          setState(() {
                            controller.comandaController.itensSelecteds.clear();
                          });
                        },
                        title: controller
                            .comandaController.itensSelecteds.length
                            .toString(),
                        onPressedDelete: () {
                          setState(controller.deleteItens);
                        },
                        onPressedEdit: () {
                          setState(controller.editItem);
                        },
                      );
              }),
            ),
            backgroundColor: StylesDefault().backgroundColor,
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: controller.comandaController.itensComandaLancamento !=
                        null
                    ? controller
                            .comandaController.itensComandaLancamento.isNotEmpty
                        ? content
                        : CustomNotFound(
                            descricao: 'Nenhum item foi adicionado para que\n'
                                'o pedido seja confirmado.',
                          )
                    : CustomNotFound(
                        descricao: 'Nenhum item foi adicionado para que\n'
                            'o pedido seja confirmado.',
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get content {
    return Observer(
      builder: (context) {
        return ListView.builder(
          itemCount: controller.comandaController.itensComandaLancamento.length,
          itemBuilder: (context, index) {
            var item = controller.comandaController.itensComandaLancamento
                .elementAt(index);
            var indexSelected = controller.comandaController.itensSelecteds
                .indexWhere((element) => element == item.index);

            return itemList(
              item: item,
              indexSelected: indexSelected,
              index: index,
            );
          },
        );
      },
    );
  }

  List<Widget> itemChildren(List<Adicional> adicionais) {
    var listAdicionais = <Widget>[];

    if (adicionais != null) {
      if (adicionais.isEmpty) {
        return [];
      } else {
        for (var item in adicionais) {
          listAdicionais.add(
            itemAdicional(item),
          );
        }

        return listAdicionais;
      }
    }

    return listAdicionais;
  }

  Widget itemAdicional(Adicional adicional) {
    return Container(
      color: Colors.white,
      height: 50.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 37.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    adicional.descCupom,
                    style: StylesDefault().fontNunitoSemiBold(
                      fontSize: 11.sp,
                    ),
                  ),
                  Text(
                    "${Utils().formatNumber(adicional.quant)} x R\$ ${Utils().formatNumber(adicional.valor)}",
                    style: StylesDefault().fontNunitoSemiBold(
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 37.w),
            child: Text(
              "R\$ ${Utils().formatNumber(adicional.total)}",
              style: StylesDefault().fontNunitoSemiBold(
                fontSize: 13.sp,
              ),
            ),
          ),
          Icon(null)
        ],
      ),
    );
  }

  Widget itemList({ItemComanda item, int indexSelected, int index}) {
    return Container(
      child: Material(
        color: indexSelected == -1
            ? StylesDefault().backgroundColor
            : StylesDefault().primarySwatch,
        child: InkWell(
          onTap: () {
            if (controller.comandaController.itensSelecteds.isNotEmpty) {
              setState(() {
                if (indexSelected != -1) {
                  controller.comandaController.removeItemSelected(item.index);
                } else {
                  controller.comandaController.addItemSelected(item.index);
                }
              });
            } else {
              if (item.adicionais.isNotEmpty) {
                var itemNovo = item.copyWith(expanded: !item.expanded);
                setState(() {
                  controller.comandaController.expandedItem(itemNovo, index);
                });
              }
            }
          },
          onLongPress: () {
            if (controller.comandaController.itensSelecteds.isEmpty) {
              setState(() {
                if (indexSelected != -1) {
                  controller.comandaController.removeItemSelected(item.index);
                } else {
                  controller.comandaController.addItemSelected(item.index);
                }

                controller.comandaController.retrairAdicionais();
              });
            }
          },
          child: Ink(
            color: indexSelected == -1
                ? StylesDefault().backgroundColor
                : StylesDefault().primarySwatch,
            height: (item.adicionais.isNotEmpty && item.expanded)
                ? 63.h + (50.h * item.adicionais.length)
                : 63.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 63.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 37.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                item.descCupom,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: StylesDefault().fontNunitoSemiBold(
                                  fontSize: 11.sp,
                                ),
                              ),
                              Text(
                                "${Utils().formatNumber(item.quant)} x R\$ ${Utils().formatNumber(item.valor)}",
                                style: StylesDefault().fontNunitoSemiBold(
                                  fontSize: 11.sp,
                                ),
                              ),
                              Visibility(
                                visible: item.observacao.trim() != '',
                                child: Text(
                                  item.observacao,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: StylesDefault().fontNunitoSemiBold(
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "R\$ ${Utils().formatNumber(item.total)}",
                        style: StylesDefault().fontNunitoSemiBold(
                          fontSize: 13.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 37.w),
                        child: item.adicionais.isNotEmpty
                            ? item.expanded
                                ? Icon(Icons.keyboard_arrow_up)
                                : Icon(Icons.keyboard_arrow_down)
                            : Icon(null),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  onLongPress: () {},
                  child: Visibility(
                    visible: (item.adicionais.isNotEmpty && item.expanded),
                    child: Container(
                      height: 50.h * item.adicionais.length,
                      child: Column(children: itemChildren(item.adicionais)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
