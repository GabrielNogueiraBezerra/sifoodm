import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../shared/features/styles/styles_default.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import 'confirma_itens_controller.dart';

class ConfirmaItensPage extends StatefulWidget {
  const ConfirmaItensPage({Key key}) : super(key: key);

  @override
  _ConfirmaItensPageState createState() => _ConfirmaItensPageState();
}

class _ConfirmaItensPageState
    extends ModularState<ConfirmaItensPage, ConfirmaItensController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: StylesDefault().primaryColor,
        statusBarBrightness:
            Theme.of(context).platform == TargetPlatform.android
                ? Brightness.dark
                : Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: StylesDefault().primaryColor,
        systemNavigationBarDividerColor: StylesDefault().primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: StylesDefault().primaryColor,
        body: SafeArea(
          child: Center(
            child: Container(
              height: 327.h,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 37.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/icons/check.svg',
                      height: 61.43.h,
                      width: 84.43.w,
                    ),
                    Text(
                      'Pedido enviado!',
                      style: StylesDefault().fontNunitoSemiBold(
                        fontSize: 21.sp,
                        color: StylesDefault().secondaryColor,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        CustomButton(
                          caption: 'Abrir uma nova comanda',
                          height: 44.h,
                          onPressed: controller.onPressedAbrirNovaComanda,
                          backgroundColor: StylesDefault().secondaryColor,
                          color: StylesDefault().secondaryColor,
                          textColor: StylesDefault().primaryColor,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomButton(
                          caption: 'Continuar nesta comanda',
                          height: 44.h,
                          onPressed: controller.onPressedContinuaComanda,
                          backgroundColor: StylesDefault().primaryColor,
                          color: StylesDefault().secondaryColor,
                          textColor: StylesDefault().secondaryColor,
                        ),
                      ],
                    ),
                    Material(
                      color: StylesDefault().primaryColor,
                      child: InkWell(
                        onTap: controller.onTapMenuPrincipal,
                        child: Ink(
                          color: StylesDefault().primaryColor,
                          child: Text('Voltar para o Menu Principal'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
