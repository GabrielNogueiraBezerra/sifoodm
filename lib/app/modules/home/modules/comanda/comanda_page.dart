import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/features/styles/styles_default.dart';
import '../../../../shared/models/comanda.dart';
import '../../../../shared/models/hex_color.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/custom_button.dart';
import 'comanda_controller.dart';
import 'modules/busca/busca_module.dart';
import 'modules/conferencia/conferencia_module.dart';
import 'modules/totais/totais_module.dart';

class ComandaPage extends StatefulWidget {
  final Comanda comanda;
  const ComandaPage({Key key, @required this.comanda}) : super(key: key);

  @override
  _ComandaPageState createState() => _ComandaPageState();
}

class _ComandaPageState extends ModularState<ComandaPage, ComandaController>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  bool floatingMenu = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();

    controller.comanda = widget.comanda;
    controller.page = 0;
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPopScope,
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
        child: Scaffold(
          backgroundColor: StylesDefault().backgroundColor,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Observer(
            builder: (context) {
              return controller.page != 2
                  ? Container()
                  : FloatingActionBubble(
                      iconData: floatingMenu ? Icons.close : Icons.print,
                      items: <Bubble>[
                        Bubble(
                          title: 'Imprimir Cozinha/Balcão',
                          icon: Icons.print,
                          iconColor: StylesDefault().secondaryColor,
                          bubbleColor: StylesDefault().primarySwatch,
                          titleStyle: StylesDefault().fontNunitoSemiBold(
                            fontSize: 13.sp,
                            color: StylesDefault().secondaryColor,
                          ),
                          onPress: () async {
                            _animationController.reverse();
                            setState(() {
                              floatingMenu = !floatingMenu;
                            });

                            await controller.imprimirComanda();
                          },
                        ),
                        Bubble(
                          title: "Conferência resumida",
                          icon: Icons.assignment,
                          iconColor: StylesDefault().secondaryColor,
                          bubbleColor: StylesDefault().primarySwatch,
                          titleStyle: StylesDefault().fontNunitoSemiBold(
                            fontSize: 13.sp,
                            color: StylesDefault().secondaryColor,
                          ),
                          onPress: () async {
                            _animationController.reverse();
                            setState(() {
                              floatingMenu = !floatingMenu;
                            });

                            await controller.conferenciaResumida();
                          },
                        ),
                        Bubble(
                          title: 'Conferência detalhada',
                          icon: Icons.assignment,
                          iconColor: StylesDefault().secondaryColor,
                          bubbleColor: StylesDefault().primarySwatch,
                          titleStyle: StylesDefault().fontNunitoSemiBold(
                            fontSize: 13.sp,
                            color: StylesDefault().secondaryColor,
                          ),
                          onPress: () async {
                            _animationController.reverse();
                            setState(() {
                              floatingMenu = !floatingMenu;
                            });

                            await controller.conferenciaDetalhada();
                          },
                        ),
                      ],
                      animation: _animation,
                      onPress: () {
                        floatingMenu
                            ? _animationController.reverse()
                            : _animationController.forward();

                        setState(() {
                          floatingMenu = !floatingMenu;
                        });
                      },
                      iconColor: StylesDefault().secondaryColor,
                      backGroundColor: StylesDefault().primarySwatch,
                    );
            },
          ),
          body: SafeArea(
            child: Observer(builder: (context) {
              return IndexedStack(
                children: <Widget>[
                  RouterOutlet(
                    module: BuscaModule(),
                  ),
                  RouterOutlet(
                    module: ConferenciaModule(),
                  ),
                  RouterOutlet(
                    module: TotaisModule(),
                  ),
                ],
                index: controller.page,
              );
            }),
          ),
          bottomNavigationBar: Observer(builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                totais,
                finalizaConferencia,
                bottomNavigationBar,
                Visibility(
                  visible: Theme.of(context).platform == TargetPlatform.android,
                  child: Container(
                    height: 3.h,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 200),
                          left: (MediaQuery.of(context).size.width / 3) *
                              controller.page,
                          top: 0,
                          child: Container(
                            color: StylesDefault().secondaryColor,
                            height: 3.h,
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget get bottomNavigationBar => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: MediaQuery.of(context).size.width * 0.07,
              color: controller.page == 0
                  ? StylesDefault().secondaryColor
                  : Colors.black.withOpacity(0.6),
            ),
            // ignore: deprecated_member_use
            title: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.005),
              child: Text(
                'Buscar itens',
                style: StylesDefault().fontNunito(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: controller.page == 0
                      ? StylesDefault().secondaryColor
                      : Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: Text(
                'Confirmar itens',
                style: StylesDefault().fontNunito(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: controller.page == 1
                      ? StylesDefault().secondaryColor
                      : Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            icon: FlutterBadge(
              icon: SvgPicture.asset(
                'assets/images/icons/basket.svg',
                color: controller.page == 1
                    ? StylesDefault().secondaryColor
                    : Colors.black.withOpacity(0.6),
              ),
              itemCount: controller.itensComandaLancamento == null
                  ? 0
                  : controller.itensComandaLancamento.length,
              borderRadius: 20.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/icons/currency.svg',
              height: MediaQuery.of(context).size.height * 0.03,
              color: controller.page == 2
                  ? StylesDefault().secondaryColor
                  : Colors.black.withOpacity(0.6),
            ),
            // ignore: deprecated_member_use
            title: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: Text(
                'Totais',
                textAlign: TextAlign.center,
                style: StylesDefault().fontNunito(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: controller.page == 2
                      ? StylesDefault().secondaryColor
                      : Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          )
        ],
        onTap: (value) {
          controller.changeTab(value);
          if (value != 2) {
            if (floatingMenu) {
              _animationController.reverse();
              floatingMenu = false;
            }
          }
        },
        currentIndex: controller.page,
      );

  Widget get finalizaConferencia {
    var height = 0.h;
    if (controller.page == 1 && controller.itensComandaLancamento.isNotEmpty) {
      height = 120.h;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 37.w),
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total',
                        style: StylesDefault().fontNunitoSemiBold(
                          fontSize: 15.sp,
                          color: HexColor('#1E2019'),
                        ),
                      ),
                      Text(
                        'R\$ ${Utils().formatNumber(controller.totalItensComanda)}',
                        style: StylesDefault().fontNunitoSemiBold(
                          fontSize: 15.sp,
                          color: StylesDefault().primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Observer(builder: (context) {
                    return CustomButton(
                      loading: controller.loadingConfirmaPedido,
                      onPressed: controller.confirmaItens,
                      caption: 'Confirmar pedido',
                      height: 37.h,
                    );
                  })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget get totais {
    var heightTotais = controller.page == 2 ? 123.h : 0.h;

    if (controller.comanda.totalPessoas > 0 && controller.page == 2) {
      heightTotais += 10.h;
    }

    if (controller.appController.storageConfigurations.conexao != null) {
      if (controller.appController.storageConfigurations.conexao.dismiss &&
          controller.page == 2) {
        heightTotais = 50.h;
      }
    }

    var heightDrop = controller.page == 2 ? 11.h : 0.h;

    var visibleTotais =
        controller.appController.storageConfigurations.conexao.dismiss;

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            controller.appController.storageConfigurations.conexao =
                controller.appController.storageConfigurations.conexao.copyWith(
                    dismiss: !controller
                        .appController.storageConfigurations.conexao.dismiss);
          },
          onVerticalDragEnd: (_) {
            controller.appController.storageConfigurations.conexao =
                controller.appController.storageConfigurations.conexao.copyWith(
                    dismiss: !controller
                        .appController.storageConfigurations.conexao.dismiss);
          },
          child: Container(
            height: heightDrop,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
            ),
            child: SvgPicture.asset(
              'assets/images/icons/menu-drop.svg',
              color: Colors.black,
              height: 5.h,
              width: 5.w,
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: heightTotais,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: !visibleTotais ? 21.h : 0, horizontal: 37.w),
            child: LayoutBuilder(builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: !visibleTotais
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        visible: !visibleTotais,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Subtotal',
                              style: StylesDefault().fontNunitoSemiBold(
                                fontSize: 12.sp,
                                color: HexColor('#1E2019'),
                              ),
                            ),
                            Text(
                              'R\$ ${Utils().formatNumber(controller.comanda.subTotal)}',
                              style: StylesDefault().fontNunitoSemiBold(
                                fontSize: 12.sp,
                                color: HexColor('#1E2019'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !visibleTotais,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Taxa de serviço',
                              style: StylesDefault().fontNunitoSemiBold(
                                fontSize: 12.sp,
                                color: HexColor('#1E2019'),
                              ),
                            ),
                            Text(
                              'R\$ ${Utils().formatNumber(controller.comanda.taxaServico)}',
                              style: StylesDefault().fontNunitoSemiBold(
                                fontSize: 12.sp,
                                color: HexColor('#1E2019'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !visibleTotais,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total Parcial',
                              style: StylesDefault().fontNunitoSemiBold(
                                fontSize: 12.sp,
                                color: HexColor('#1E2019'),
                              ),
                            ),
                            Text(
                              'R\$ ${Utils().formatNumber(controller.comanda.parcial)}',
                              style: StylesDefault().fontNunitoSemiBold(
                                fontSize: 12.sp,
                                color: HexColor('#1E2019'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.comanda.totalPessoas > 0 &&
                            !visibleTotais,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total por Pessoa',
                              style: StylesDefault().fontNunitoSemiBold(
                                fontSize: 12.sp,
                                color: HexColor('#1E2019'),
                              ),
                            ),
                            Text(
                              'R\$ ${Utils().formatNumber(controller.comanda.total / controller.comanda.totalPessoas)}',
                              style: StylesDefault().fontNunitoSemiBold(
                                fontSize: 12.sp,
                                color: HexColor('#1E2019'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total',
                            style: StylesDefault().fontNunitoSemiBold(
                              fontSize: 15.sp,
                              color: HexColor('#1E2019'),
                            ),
                          ),
                          Text(
                            'R\$ ${Utils().formatNumber(controller.comanda.total)}',
                            style: StylesDefault().fontNunitoSemiBold(
                              fontSize: 15.sp,
                              color: StylesDefault().primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
