import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../shared/features/styles/styles_default.dart';
import '../../../../../../shared/models/hex_color.dart';
import '../../../../../../shared/models/item_comanda.dart';
import '../../../../../../shared/models/produto.dart';
import '../../../../../../shared/utils/utils.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import 'insere_produto_controller.dart';
import 'widgets/custom_input.dart';

class InsereProdutoPage extends StatefulWidget {
  final Produto produto;
  final int index;
  final ItemComanda itemComanda;

  final String title;
  const InsereProdutoPage({
    Key key,
    this.title = "Adicionar item",
    this.produto,
    this.index,
    this.itemComanda,
  }) : super(key: key);

  @override
  _InsereProdutoPageState createState() => _InsereProdutoPageState();
}

class _InsereProdutoPageState
    extends ModularState<InsereProdutoPage, InsereProdutoController> {
  @override
  void initState() {
    super.initState();

    controller.produto = widget.produto;
    controller.preencheProduto(widget.index, widget.itemComanda);
  }

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
              title: controller.itemComandaSelecionado == null
                  ? widget.title
                  : 'Alterar item',
            ),
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  produtoInfo,
                  espaco,
                  observacoes,
                  espaco,
                  adicionais,
                  espaco,
                  finaliza,
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget get finaliza => Observer(builder: (context) {
        return Container(
          height: 180.h,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32.w,
              vertical: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                quantidadeItem,
                SizedBox(
                  height: 15.h,
                ),
                CustomButton(
                  caption: controller.itemComandaSelecionado == null
                      ? 'Adicionar ao Pedido R\$ ${Utils().formatNumber(controller.totalPedido)}'
                      : 'Alterar no Pedido R\$ ${Utils().formatNumber(controller.totalPedido)}',
                  height: MediaQuery.of(context).size.height * 0.06,
                  onPressed: controller.adicionaItem,
                ),
              ],
            ),
          ),
        );
      });

  Widget get adicionais {
    var height = 170.h;

    if (controller.adicionaisSelecionados != null) {
      height += 45.h * controller.adicionaisSelecionados.length;
    }

    return Observer(builder: (context) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.08,
            right: MediaQuery.of(context).size.width * 0.08,
            top: MediaQuery.of(context).size.height * 0.03,
            bottom: MediaQuery.of(context).size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              texto('adicionais'),
              SizedBox(
                height: 10.h,
              ),
              Material(
                borderRadius: BorderRadius.circular(19.h),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(19.h),
                  onTap: controller.selecioneAdicionais,
                  child: DashedContainer(
                    child: Container(
                      height: 37.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(19.h),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/icons/plus_circle.svg',
                            height: 14.h,
                            width: 14.w,
                            color: StylesDefault().secondaryColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Selecione os adicionais',
                            style: StylesDefault().fontNunito(
                              fontSize: 14.sp,
                              color: StylesDefault().secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    dashColor: StylesDefault().secondaryColor,
                    borderRadius: 19.h,
                    dashedLength: 10,
                    blankLength: 5,
                    strokeWidth: 1,
                  ),
                ),
              ),
              Visibility(
                visible: controller.adicionaisSelecionados != null,
                child: SizedBox(
                  height: 14.h,
                ),
              ),
              Visibility(
                visible: controller.adicionaisSelecionados != null,
                child: Expanded(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.adicionaisSelecionados.length,
                    separatorBuilder: (_, __) => SizedBox(
                      height: 8.h,
                    ),
                    itemBuilder: (context, index) {
                      var adicional =
                          controller.adicionaisSelecionados.elementAt(index);
                      return Material(
                        borderRadius: BorderRadius.circular(30.h),
                        color: StylesDefault().secondaryColor,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30.h),
                          onTap: controller.selecioneAdicionais,
                          child: Ink(
                            height: 37.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: StylesDefault().secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.h)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      '${Utils().formatNumber(adicional.quant)} x ${adicional.descCupom}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StylesDefault().fontNunito(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'R\$ ${Utils().formatNumber(adicional.total)}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: StylesDefault().fontNunito(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.removeAdicional(index);
                                        },
                                        child: Container(
                                          height: 37.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(12.sp),
                                            child: SvgPicture.asset(
                                              'assets/images/icons/delete.svg',
                                              height: 10.77.h,
                                              width: 10.77.w,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: controller.adicionaisSelecionados != null,
                child: SizedBox(
                  height: 7.h,
                ),
              ),
              texto('total adicionais'),
              Text(
                'R\$ ${Utils().formatNumber(controller.totalAdicionais)}',
                style: StylesDefault().fontNunito(
                  fontSize: 14.sp,
                  color: StylesDefault().secondaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget get quantidadeItem => TextFormField(
        controller: controller.textEditingControllerQuantidade,
        focusNode: controller.focusQuantidade,
        inputFormatters: <TextInputFormatter>[
          controller.produto.usaQuantidadeFracionaria
              ? FilteringTextInputFormatter.allow(RegExp(r"^\d+\,?\d{0,3}"))
              : FilteringTextInputFormatter.digitsOnly
        ],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIconConstraints: BoxConstraints(maxHeight: 100.h),
          suffixIcon: IconButton(
            onPressed: () {
              controller.focusQuantidade.unfocus();
              controller.focusQuantidade.canRequestFocus = false;

              controller.addQuantidade();

              setState(() {});

              Future.delayed(Duration(milliseconds: 100)).then((v) async {
                controller.focusQuantidade.canRequestFocus = true;
              });
            },
            icon: Icon(Icons.add),
          ),
          prefixIcon: IconButton(
            onPressed: () {
              controller.focusQuantidade.unfocus();
              controller.focusQuantidade.canRequestFocus = false;
              controller.removeQuantidade();

              setState(() {});

              Future.delayed(Duration(milliseconds: 100)).then((v) async {
                controller.focusQuantidade.canRequestFocus = true;
              });
            },
            icon: Icon(Icons.remove),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#707070'),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
      );

  Text texto(String descricao) {
    return Text(
      descricao,
      style: StylesDefault().fontNunito(
        fontSize: 12.sp,
        color: Colors.black.withOpacity(0.3),
      ),
    );
  }

  Widget get observacoes {
    var height = 150.h;

    if (controller.observacoesEscritas != null) {
      if (controller.observacoesEscritas.isNotEmpty) {
        height += 40.h * (controller.observacoesEscritas.length);
      }
    }
    if (controller.observacoesEscritas != null) {
      return AnimatedContainer(
        duration: Duration(
          milliseconds: 300,
        ),
        height: height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 32.w,
                      right: 32.w,
                      top: 11.h,
                    ),
                    child: texto('observacao'),
                  ),
                  espaco,
                  Padding(
                    padding: EdgeInsets.only(
                      left: 32.w,
                      right: 32.w,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: CustomInput(
                            controller:
                                controller.textEditingControllerObservacao,
                            onFieldSubmitted: (_) {
                              controller.adicionaObservacao();
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .03,
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/icons/send.svg',
                            height: 25.h,
                            width: 25.w,
                          ),
                          onPressed: controller.adicionaObservacao,
                        ),
                      ],
                    ),
                  ),
                  espaco,
                  observacoesEscritas,
                  SizedBox(
                    height: 11.h,
                  ),
                ],
              ),
            ),
          );
        }),
      );
    } else {
      return Container();
    }
  }

  Widget get observacoesEscritas {
    if (controller.observacoesEscritas != null) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 40.h * controller.observacoesEscritas.length,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.observacoesEscritas.length,
          itemBuilder: (context, index) {
            var observacao = controller.observacoesEscritas.elementAt(index);
            return Padding(
              padding: EdgeInsets.only(
                left: 32.w,
                right: 32.w,
              ),
              child: Container(
                height: 40.h,
                decoration: controller.observacoesEscritas.length - 1 == index
                    ? null
                    : BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: HexColor('#1E2019').withOpacity(0.2),
                          ),
                        ),
                      ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        observacao,
                        style: StylesDefault().fontNunito(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: StylesDefault().secondaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/icons/delete.svg',
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      onPressed: () {
                        controller.deleteObservacao(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget get espaco => SizedBox(
        height: MediaQuery.of(context).size.height * 0.015,
      );

  Widget get produtoInfo => Container(
        height: controller.produto.composicao == '' ? 47.h : 100.h,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        texto('produto'),
                        Text(
                          controller.produto.nomePro,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: StylesDefault().fontNunito(
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      texto('valor'),
                      Text(
                        'R\$ ${Utils().formatNumber(controller.produto.valorProduto)}',
                        style: StylesDefault().fontNunito(
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Visibility(
                visible: controller.produto.composicao != '',
                child: Text(
                  controller.produto.composicao,
                  maxLines: 3,
                  style: StylesDefault().fontNunito(
                    fontSize: 12.sp,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
