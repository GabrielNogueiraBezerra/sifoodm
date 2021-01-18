import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:overlay_support/overlay_support.dart';

import 'shared/features/styles/styles_default.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      toastTheme: ToastThemeData(
        alignment: Alignment.bottomCenter,
        background: Colors.black.withOpacity(0.6),
        textColor: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          var currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Si Food',
          debugShowCheckedModeBanner: false,
          navigatorKey: Modular.navigatorKey,
          theme: ThemeData(
            primarySwatch: StylesDefault().primarySwatch,
            backgroundColor: StylesDefault().primaryColor,
            accentColor: StylesDefault().backgroundColor,
            brightness: Brightness.light,
            appBarTheme: AppBarTheme(
              brightness: Brightness.light,
            ),
          ),
          initialRoute: '/',
          onGenerateRoute: Modular.generateRoute,
          themeMode: ThemeMode.dark,
        ),
      ),
    );
  }
}
