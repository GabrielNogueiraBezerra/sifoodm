import 'package:flutter/material.dart';

import '../../models/hex_color.dart';

class StylesDefault {
  static StylesDefault _instance;

  final Color primaryColor = HexColor('#FCBF14');
  final Color secondaryColor = HexColor('#582D22');
  final Color backgroundColor = HexColor('#F0F0F0');

  final MaterialColor primarySwatch = MaterialColor(
    0xFFFCBF14,
    {
      50: Color.fromRGBO(255, 191, 20, .1),
      100: Color.fromRGBO(255, 191, 20, .2),
      200: Color.fromRGBO(255, 191, 20, .3),
      300: Color.fromRGBO(255, 191, 20, .4),
      400: Color.fromRGBO(255, 191, 20, .5),
      500: Color.fromRGBO(255, 191, 20, .6),
      600: Color.fromRGBO(255, 191, 20, .7),
      700: Color.fromRGBO(255, 191, 20, .8),
      800: Color.fromRGBO(255, 191, 20, .9),
      900: Color.fromRGBO(255, 191, 20, 1),
    },
  );

  factory StylesDefault() {
    _instance ??= StylesDefault._internalConstructor();

    return _instance;
  }

  TextStyle fontCenturyGothic(
      {double fontSize = 12, Color color = Colors.black}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'CenturyGothic',
      color: color,
    );
  }

  TextStyle fontNunito(
      {double fontSize = 12,
      Color color = Colors.black,
      TextDecoration decoration = TextDecoration.none}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Nunito',
      color: color,
      decoration: decoration,
    );
  }

  TextStyle fontNunitoLight(
      {double fontSize = 12, Color color = Colors.black}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w300,
      color: color,
    );
  }

  TextStyle fontNunitoSemiBold(
      {double fontSize = 12, Color color = Colors.black}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  TextStyle fontNunitoBold({double fontSize = 12, Color color = Colors.black}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  StylesDefault._internalConstructor();
}
