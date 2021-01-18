import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/features/styles/styles_default.dart';
import '../../../../shared/models/comanda.dart';
import '../../../../shared/models/hex_color.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../widgets/custom_input_search.dart';
import '../../widgets/custom_not_found.dart';
import 'transferencia_controller.dart';

class TransferenciaPage extends StatefulWidget {
  final String title;
  const TransferenciaPage({Key key, this.title = "Transferências"})
      : super(key: key);

  @override
  _TransferenciaPageState createState() => _TransferenciaPageState();
}

class _TransferenciaPageState
    extends ModularState<TransferenciaPage, TransferenciaController> {
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
        systemNavigationBarDividerColor: StylesDefault().backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: StylesDefault().backgroundColor,
        appBar: CustomAppBar(
          onPressed: controller.onPressedBack,
          title: widget.title,
        ),
        body: SafeArea(
          child: Observer(builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 25.w),
                  child: Text(
                    'Qual comanda você quer\ntransferir?',
                    style: StylesDefault().fontNunitoSemiBold(
                      color: StylesDefault().secondaryColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: CustomInputSearch(
                    placeholder: 'Buscar comanda',
                    controller: controller.textEditingPesquisaController,
                    textInputAction: TextInputAction.done,
                    focusNode: controller.focusNode,
                    onFieldSubmitted: (_) async {
                      controller.buscaComandas();
                    },
                    onPressedSuffix: () {
                      controller.textEditingPesquisaController.text = '';
                      controller.buscaComandas();
                    },
                    onChanged: (value) async {
                      controller.buscaComandas();
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                lista,
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget get lista {
    if (!controller.loading) {
      var itemCount = 1;
      if (controller.comandas != null) {
        itemCount += controller.comandas.length;
      }
      return Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.buscaComandas();
          },
          backgroundColor: StylesDefault().secondaryColor,
          child: ListView.builder(
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
                  return item(
                      comanda: controller.comandas.elementAt(index),
                      last: index == itemCount - 2);
                }
              }
            },
          ),
        ),
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
    if (controller.busca != null) {
      if (controller.page < controller.busca["count"]) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: StylesDefault().secondaryColor,
            ),
          ),
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }

  Widget item({Comanda comanda, bool last}) {
    return Material(
      color: StylesDefault().backgroundColor,
      child: InkWell(
        onTap: () async {
          await controller.onTapSelecionaComanda(comanda);
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
