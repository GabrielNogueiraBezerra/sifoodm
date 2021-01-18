import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/features/styles/styles_default.dart';
import '../../../../../../shared/models/comanda.dart';
import '../../../../../../shared/models/hex_color.dart';
import '../../../../../../shared/models/item_comanda.dart';
import '../../../../../../shared/utils/utils.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../../../shared/widgets/custom_checkbox.dart';
import '../../../../widgets/custom_not_found.dart';
import 'itens_comanda_controller.dart';

class ItensComandaPage extends StatefulWidget {
  final Comanda comanda;
  const ItensComandaPage({
    Key key,
    this.comanda,
  }) : super(key: key);

  @override
  _ItensComandaPageState createState() => _ItensComandaPageState();
}

class _ItensComandaPageState
    extends ModularState<ItensComandaPage, ItensComandaController> {
  bool selecionado = false;

  @override
  void initState() {
    super.initState();

    controller.comanda = widget.comanda;
    controller.buscaItens();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPopScope,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: StylesDefault().backgroundColor,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: StylesDefault().backgroundColor,
          systemNavigationBarDividerColor: StylesDefault().backgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Observer(builder: (context) {
          return Scaffold(
            backgroundColor: StylesDefault().backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: StylesDefault().backgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: StylesDefault().secondaryColor,
                ),
                onPressed: controller.onWillPopScope,
              ),
              title: Column(
                children: <Widget>[
                  Text(
                    'Comanda ${controller.comanda.formatConta}',
                    style: StylesDefault().fontNunito(
                      fontSize: 20.sp,
                      color: StylesDefault().secondaryColor,
                    ),
                  ),
                  Text(
                    controller.comanda.descMesa,
                    style: StylesDefault().fontNunito(
                      fontSize: 11.sp,
                      color: StylesDefault().secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            body: Observer(builder: (context) {
              var existe = false;
              if (controller.itensComanda != null) {
                if (controller.itensComanda.isNotEmpty) {
                  existe = true;
                }
              }
              return Column(
                children: <Widget>[
                  Visibility(
                    visible: existe,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selecionado = !selecionado;
                          });

                          controller.todos(selecionado: selecionado);
                        },
                        child: Ink(
                          height: 44.h,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                color: HexColor('#707070').withOpacity(0.5),
                                width: 0.5,
                              ),
                              top: BorderSide(
                                color: HexColor('#707070').withOpacity(0.5),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28.w),
                            child: CustomCheckbox(
                              checked: selecionado,
                              texto: 'Selecionar todos',
                              color: Colors.black,
                              onTap: () {
                                setState(() {
                                  selecionado = !selecionado;
                                });

                                controller.todos(selecionado: selecionado);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  listaItens,
                ],
              );
            }),
            bottomNavigationBar: Observer(builder: (context) {
              var selecionados = -1;
              if (controller.itensComanda != null) {
                selecionados = controller.itensComanda
                    .indexWhere((element) => element.selecionado);
              }
              return Container(
                height: 115.h,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.w),
                  child: Center(
                    child: CustomButton(
                      onPressed: () {
                        var selecionados = -1;
                        if (controller.itensComanda != null) {
                          selecionados = controller.itensComanda
                              .indexWhere((element) => element.selecionado);
                        }

                        if (selecionados != -1) {
                          controller.transfereItens();
                        }
                      },
                      caption: 'Transferir itens selecionados',
                      height: 37.h,
                      backgroundColor: selecionados != -1
                          ? StylesDefault().primarySwatch
                          : HexColor('#E7E7E7'),
                      color: selecionados != -1
                          ? StylesDefault().primarySwatch
                          : HexColor('#E7E7E7'),
                      textColor: selecionados != -1
                          ? StylesDefault().secondaryColor
                          : HexColor('#707070'),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  Widget get listaItens {
    if (controller.itensComanda != null) {
      if (controller.itensComanda.isNotEmpty) {
        return Expanded(
          child: ListView.builder(
            itemCount: controller.itensComanda.length,
            itemBuilder: (context, index) {
              return listaItem(controller.itensComanda.elementAt(index), index);
            },
          ),
        );
      } else {
        return Expanded(
          child: Center(
            child: CustomNotFound(
              descricao: 'Essa comanda não contém nenhum item.',
            ),
          ),
        );
      }
    } else {
      if (controller.loading) {
        return Expanded(
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: StylesDefault().secondaryColor,
            ),
          ),
        );
      } else {
        return Expanded(
          child: CustomNotFound(
            descricao: 'Essa comanda não contém nenhum item.',
          ),
        );
      }
    }
  }

  Widget listaItem(ItemComanda itemComanda, int index) {
    return Material(
      color: itemComanda.selecionado
          ? StylesDefault().primarySwatch
          : Colors.transparent,
      child: InkWell(
        onTap: () {
          if (itemComanda.selecionado) {
            var item =
                itemComanda.copyWith(selecionado: !itemComanda.selecionado);
            controller.removeItem(item, index);
          } else {
            controller.addItem(itemComanda, index);
          }
        },
        child: Ink(
          height: 59.h,
          decoration: BoxDecoration(
            color: itemComanda.selecionado
                ? StylesDefault().primarySwatch
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: HexColor('#707070').withOpacity(0.5),
                width: 0.5,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                itemComanda.selecionado
                    ? Icon(
                        Icons.check_box,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.black,
                      ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${Utils().formatNumber(itemComanda.quant)}x ${itemComanda.descCupom}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StylesDefault().fontNunitoSemiBold(
                          fontSize: 11.sp,
                        ),
                      ),
                      itemComanda.selecionado
                          ? Text(
                              'Transferindo ${Utils().formatNumber(itemComanda.quantSelecionada)} de ${Utils().formatNumber(itemComanda.quant)}',
                              style: StylesDefault().fontNunitoBold(
                                fontSize: 11.sp,
                              ),
                            )
                          : Text(
                              'Selecione a quantidade',
                              style: StylesDefault().fontNunito(
                                fontSize: 11.sp,
                                color: Colors.black.withOpacity(0.35),
                              ),
                            ),
                    ],
                  ),
                ),
                Text(
                  'R\$ ${Utils().formatNumber(itemComanda.total)}',
                  style: StylesDefault().fontNunitoSemiBold(
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
