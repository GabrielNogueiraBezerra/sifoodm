import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../shared/features/styles/styles_default.dart';
import '../../../../shared/models/hex_color.dart';
import '../../../../shared/widgets/direitos_reservados.dart';
import 'inicio_controller.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends ModularState<InicioPage, InicioController> {
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
        backgroundColor: StylesDefault().backgroundColor,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 37.5.w,
                vertical: 53.h,
              ),
              child: Observer(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    boasVindas,
                    menu,
                    comandasAbertas,
                    direitosReservados,
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemMenu({
    @required int index,
    @required String imagem,
    @required String nome,
    @required GestureTapCallback onTap,
  }) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(31.h)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(31.h)),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(31.h)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagem,
                height: 59.76.h,
                width: 75.8.w,
              ),
              Text(
                nome,
                textAlign: TextAlign.center,
                style: StylesDefault().fontNunito(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get menu => Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: <Widget>[
            itemMenu(
              index: 0,
              imagem: 'assets/images/home/adicionar_comanda.png',
              nome: 'Lançar\nComanda',
              onTap: controller.onTapNovaComanda,
            ),
            itemMenu(
              index: 1,
              imagem: 'assets/images/home/mapa_comanda.png',
              nome: 'Mapa\nde Comandas',
              onTap: controller.onTapMapaComandas,
            ),
            itemMenu(
              index: 2,
              imagem: 'assets/images/home/transferencia_comanda.png',
              nome: 'Transferência\nentre Comandas',
              onTap: controller.onTapTransferencia,
            ),
            itemMenu(
              index: 3,
              imagem: 'assets/images/home/desconectar.png',
              nome: 'Desconectar',
              onTap: controller.onTapLogout,
            ),
          ],
        ),
      );

  Widget get direitosReservados => DireitosReservados();

  Widget get comandasAbertas => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          controller.appController.usuario != null
              ? Text(
                  controller.appController.empresa.totalMesasAbertas
                      .toString()
                      .padLeft(2, '0'),
                  style: StylesDefault().fontNunito(
                    color: StylesDefault().secondaryColor,
                    fontSize: 35.sp,
                  ),
                )
              : Container(),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Comanda(s) aberta(s) por você',
                style: StylesDefault().fontNunito(
                  fontSize: 13.sp,
                  color: StylesDefault().secondaryColor,
                ),
              ),
              Text(
                DateFormat.yMMMd('pt_Br').format(DateTime.now()),
                style: StylesDefault().fontNunito(
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ],
      );

  Widget get boasVindas => controller.appController.usuario != null
      ? Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Olá, ${controller.appController.usuario.nomeUsu}',
                    style: StylesDefault().fontNunito(
                      color: StylesDefault().secondaryColor,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    '${controller.appController.usuario.grupo.nomeGrupo}, ${controller.appController.empresa.fantasiaEmp}',
                    overflow: TextOverflow.ellipsis,
                    style: StylesDefault().fontNunito(
                      color: HexColor('#666666'),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: controller.appController.usuario.empresas.length > 1,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                  onTap: controller.onPressedSelEmpresa,
                  borderRadius: BorderRadius.circular(50),
                  child: Ink(
                    height: 54.h,
                    width: 54.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/icons/shop.svg',
                        color: StylesDefault().secondaryColor,
                        width: 17.99.w,
                        height: 16.2.h,
                      ),
                      onPressed: controller.onPressedSelEmpresa,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      : Container();
}
