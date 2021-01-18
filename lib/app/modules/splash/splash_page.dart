import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/features/styles/styles_default.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: false);

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
            child: Hero(
              tag: 'logo',
              child: ElasticInLeft(
                child: Image.asset(
                  'assets/images/logo/logo-splash.png',
                  height: 146.57.h,
                  width: 113.w,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
