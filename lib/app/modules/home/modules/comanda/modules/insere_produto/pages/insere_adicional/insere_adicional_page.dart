import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../shared/features/styles/styles_default.dart';
import '../../../../../../../../shared/models/adicional.dart';
import '../../../../../../../../shared/models/hex_color.dart';
import '../../../../../../../../shared/utils/utils.dart';
import '../../../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../../../shared/widgets/custom_button.dart';
import '../../../../../../widgets/custom_input_search.dart';
import '../../../../../../widgets/custom_not_found.dart';
import 'insere_adicional_controller.dart';

class InsereAdicionalPage extends StatefulWidget {
  final String title;
  const InsereAdicionalPage({Key key, this.title = "Adicionais"})
      : super(key: key);

  @override
  _InsereAdicionalPageState createState() => _InsereAdicionalPageState();
}

class _InsereAdicionalPageState
    extends ModularState<InsereAdicionalPage, InsereAdicionalController> {
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness:
            Theme.of(context).platform == TargetPlatform.android
                ? Brightness.dark
                : Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.title,
          onPressed: () {
            Modular.to.pop();
          },
          backgroundColor: Colors.white,
        ),
        backgroundColor: HexColor('#F9F9F9'),
        body: SafeArea(
          child: Observer(
            builder: (context) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 17.w, vertical: 20.h),
                    child: CustomInputSearch(
                      focusNode: focusNode,
                      placeholder: 'Buscar adicionais por nome ou referência',
                      controller:
                          controller.textEditingControllerPesquisaAdicionais,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => null,
                      onChanged: (_) {
                        controller.buscarAdicionais();
                      },
                      onPressedSuffix: () {
                        controller
                            .textEditingControllerPesquisaAdicionais.text = '';
                        controller.buscarAdicionais();
                      },
                    ),
                  ),
                  Expanded(child: listView),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: Observer(builder: (context) {
          return Container(
            color: Colors.white,
            height: 71.h,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 18.h,
                horizontal: 37.h,
              ),
              child: CustomButton(
                onPressed: () {
                  Modular.to.pop();
                },
                caption:
                    'Confirmar R\$ ${Utils().formatNumber(controller.totalAdicionais)}',
                height: 37.h,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget get listView {
    if (controller.loading && controller.adicionais == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: StylesDefault().secondaryColor,
        ),
      );
    } else {
      if (controller.adicionais == null) {
        return Expanded(
          child: Center(
            child: CustomNotFound(descricao: 'Nenhum adicional encontrado.'),
          ),
        );
      } else {
        var count = controller.adicionais.length;
        if (controller.page < controller.busca['count']) {
          count++;
        }
        return ListView.separated(
          controller: controller.scrollController,
          separatorBuilder: (_, __) => SizedBox(
            height: 7.h,
          ),
          itemCount: count,
          itemBuilder: (context, index) {
            if (index == count - 1 &&
                controller.page < controller.busca['count']) {
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                  width: MediaQuery.of(context).size.height * 0.02,
                  child: CircularProgressIndicator(
                    backgroundColor: StylesDefault().secondaryColor,
                  ),
                ),
              );
            } else {
              var adicional = controller.adicionais.elementAt(index);
              var indexSelecionado = -1;

              Adicional adicionalSelecionado;

              if (controller.insereProdutoController.adicionaisSelecionados !=
                  null) {
                indexSelecionado = controller
                    .insereProdutoController.adicionaisSelecionados
                    .indexWhere(
                        (element) => element.codPro == adicional.codPro);

                if (indexSelecionado != -1) {
                  adicionalSelecionado = controller
                      .insereProdutoController.adicionaisSelecionados
                      .elementAt(indexSelecionado);
                }
              }
              return Material(
                color: adicionalSelecionado != null
                    ? Colors.white
                    : Colors.grey[100],
                child: InkWell(
                  onTap: () {
                    controller.addItem(
                        adicional, adicionalSelecionado, indexSelecionado);
                  },
                  child: Ink(
                    color: adicionalSelecionado != null
                        ? Colors.white
                        : Colors.grey[100],
                    height: 47.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 17.w,
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  adicional.descCupom,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: StylesDefault().fontNunito(
                                    fontSize: 14.sp,
                                    color: StylesDefault().secondaryColor,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    'R\$ ${Utils().formatNumber(adicional.valorProduto)}',
                                    style: StylesDefault().fontNunitoLight(
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    adicionalSelecionado == null
                                        ? 'Quantidade: 0'
                                        : 'Quantidade: ${Utils().formatNumber(adicionalSelecionado.quant)}',
                                    style: StylesDefault().fontNunitoLight(
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          adicionalSelecionado == null
                              ? 'R\$ 0,00'
                              : 'R\$ ${Utils().formatNumber(adicionalSelecionado.total)}',
                          style: StylesDefault().fontNunito(
                            fontSize: 14.sp,
                            color: StylesDefault().secondaryColor,
                          ),
                        ),
                        Visibility(
                          visible: adicionalSelecionado == null,
                          child: SizedBox(
                            width: 17.w,
                          ),
                        ),
                        Visibility(
                          visible: adicionalSelecionado != null,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                width: 6.w,
                                color: StylesDefault().primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      }
    }
  }
}
