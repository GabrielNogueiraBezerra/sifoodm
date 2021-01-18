import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

import '../widgets/custom_dialog.dart';
import '../widgets/custom_progress_dialog.dart';

class Utils {
  static Utils _instance;

  factory Utils() {
    _instance ??= Utils._internalConstructor();
    return _instance;
  }

  Utils._internalConstructor() {
    customProgressDialogDisplayed = false;
  }

  bool customProgressDialogDisplayed;

  Future<void> showAlert({String mensagem}) async {
    mensagem = mensagem.replaceAll('Exception:', '').trim();
    toast(
      mensagem,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> showCustomProgressDialog({String title}) async {
    customProgressDialogDisplayed = true;

    await showDialog<dynamic>(
      context: Modular.navigatorKey.currentState.overlay.context,
      barrierDismissible: false,
      builder: (context) {
        return CustomProgressDialog(
          dialogMessage: title,
          dialogPadding:
              EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
        );
      },
    );
  }

  void hideCustomProgressDialog() {
    customProgressDialogDisplayed = false;
    Modular.to.pop();
  }

  Future<void> showDialogError(
      {String title = 'Atenção', @required String mensagem}) async {
    showModalBottomSheet(
      context: Modular.navigatorKey.currentState.overlay.context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return CustomDialog(
          title: title,
          mensagem: mensagem,
        );
      },
    );
  }

  String formatNumber(double number) {
    if (number != 0) {
      var format = NumberFormat.currency(locale: 'pt-Br', decimalDigits: 3)
          .format(number)
          .replaceAll('BRL', '')
          .trim();
      if (format.substring(format.length - 1) == '0') {
        format = format.substring(0, format.length - 1);
      }
      return format;
    } else {
      return "0,00";
    }
  }
}
