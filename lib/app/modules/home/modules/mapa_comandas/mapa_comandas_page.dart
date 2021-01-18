import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/features/styles/styles_default.dart';
import '../../../../shared/models/comanda.dart';
import '../../../../shared/models/hex_color.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../widgets/custom_input_search.dart';
import '../../widgets/custom_not_found.dart';
import 'mapa_comandas_controller.dart';
import 'widgets/custom_float_button.dart';

class MapaComandasPage extends StatefulWidget {
  final String title;
  const MapaComandasPage({Key key, this.title = "Mapa de Comandas"})
      : super(key: key);

  @override
  _MapaComandasPageState createState() => _MapaComandasPageState();
}

class _MapaComandasPageState
    extends ModularState<MapaComandasPage, MapaComandasController> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onPressedBack,
      child: AnnotatedRegion(
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
        child: Observer(builder: (context) {
          return Scaffold(
            backgroundColor: StylesDefault().backgroundColor,
            appBar: CustomAppBar(
              onPressed: controller.onPressedBack,
              title: widget.title,
            ),
            floatingActionButton: CustomFloatButton(
              onPressed: controller.onPressedNovaComanda,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: CustomInputSearch(
                              focusNode: focusNode,
                              controller:
                                  controller.textEditingControllerPesquisa,
                              onFieldSubmitted: (value) async {
                                controller.textEditingControllerPesquisa.text =
                                    value;
                                controller.buscaComandas();
                              },
                              onChanged: (value) {
                                controller.buscaComandas();
                              },
                              placeholder: 'Buscar comanda',
                              textInputAction: TextInputAction.go,
                              isUpperCase: true,
                              maxLength: 80,
                              onPressedSuffix: controller.onPressedDeleteSearch,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/icons/arrows.svg',
                            width: 15.27.w,
                            height: 16.62.h,
                            color: StylesDefault().primaryColor,
                          ),
                          onPressed: controller.onPressedOrdenacao,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Expanded(
                    flex: 5,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await controller.buscaComandas();
                      },
                      backgroundColor: StylesDefault().secondaryColor,
                      child: controller.loading
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: StylesDefault().secondaryColor,
                              ),
                            )
                          : lista,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget get lista {
    if (!controller.loading) {
      var itemCount = 1;
      if (controller.comandas != null) {
        itemCount += controller.comandas.length;
      }
      return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: controller.scrollController,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (itemCount == 1) {
            if (controller.comandas != null) {
              return CustomNotFound(
                descricao: 'Nenhuma comanda aberta até o\n'
                    'momento. Assim que um pedido for\n'
                    'finalizado, a comanda aparecerá\n'
                    'nesta tela.',
              );
            } else {
              return CustomNotFound(
                descricao: 'Não foi possível carregar os \n'
                    'itens da lista, verifique a conexão\n'
                    'com internet e tente novamente',
              );
            }
          } else {
            if (index == itemCount - 1) {
              return itemCarregando();
            } else {
              var comanda = controller.comandas.elementAt(index);
              return item(comanda: comanda, last: index == itemCount - 2);
            }
          }
        },
      );
    } else {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: StylesDefault().secondaryColor,
          ),
        ),
      );
    }
  }

  Widget itemCarregando() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
    );
  }

  Widget item({Comanda comanda, bool last}) {
    return Material(
      color: StylesDefault().backgroundColor,
      child: InkWell(
        onTap: () {
          controller.selecionaComanda(comanda);
        },
        child: Ink(
          decoration: BoxDecoration(
            border: last
                ? null
                : Border(
                    bottom: BorderSide(
                        color: HexColor('#707070').withOpacity(0.5),
                        width: 0.5),
                  ),
          ),
          height: 71.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 6.w,
                color: comanda.getColor,
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            comanda.descMesa,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: StylesDefault().fontNunito(
                              fontSize: 14.sp,
                              color: StylesDefault().secondaryColor,
                            ),
                          ),
                          Text(
                            "${comanda.totalPessoas.toString()} pessoas",
                            style: StylesDefault().fontNunito(
                              fontSize: 14.sp,
                              color: StylesDefault()
                                  .secondaryColor
                                  .withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          comanda.formatConta,
                          style: StylesDefault().fontNunito(
                            fontSize: 35.sp,
                            color: StylesDefault().secondaryColor,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: StylesDefault().secondaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
