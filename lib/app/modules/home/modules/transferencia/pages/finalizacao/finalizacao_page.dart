import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../shared/features/styles/styles_default.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import 'finalizacao_controller.dart';

class FinalizacaoPage extends StatefulWidget {
  final String title;
  const FinalizacaoPage({Key key, this.title = "Finalizacao"})
      : super(key: key);

  @override
  _FinalizacaoPageState createState() => _FinalizacaoPageState();
}

class _FinalizacaoPageState
    extends ModularState<FinalizacaoPage, FinalizacaoController> {
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
                      'Transferência concluída\n'
                      'com sucesso!',
                      textAlign: TextAlign.center,
                      style: StylesDefault().fontNunitoSemiBold(
                        fontSize: 21.sp,
                        color: StylesDefault().secondaryColor,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        CustomButton(
                          caption: 'Realizar nova transferência',
                          height: 44.h,
                          onPressed: controller.onPressedFazerNovaTransferencia,
                          backgroundColor: StylesDefault().secondaryColor,
                          color: StylesDefault().secondaryColor,
                          textColor: StylesDefault().primaryColor,
                        ),
                        SizedBox(
                          height: 20.h,
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
