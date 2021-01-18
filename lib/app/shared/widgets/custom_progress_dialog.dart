import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../features/styles/styles_default.dart';

class CustomProgressDialog extends StatelessWidget {
  final EdgeInsets dialogPadding;
  final TextDirection direction;
  final Alignment progressWidgetAlignment;
  final String dialogMessage;
  final TextAlign textAlignMessage;

  const CustomProgressDialog({
    Key key,
    this.dialogPadding = const EdgeInsets.all(0),
    this.direction = TextDirection.ltr,
    this.progressWidgetAlignment = Alignment.centerLeft,
    this.dialogMessage = 'Carregando...',
    this.textAlignMessage = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loader = Align(
      alignment: progressWidgetAlignment,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.width * 0.1,
        child: CircularProgressIndicator(
          backgroundColor: StylesDefault().secondaryColor,
        ),
      ),
    );

    final text = Expanded(
      child: Text(
        dialogMessage,
        textAlign: textAlignMessage,
        textDirection: direction,
        style: StylesDefault().fontNunito(
          fontSize: MediaQuery.of(context).size.height * 0.025,
          color: Colors.black,
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: ZoomIn(
        duration: Duration(milliseconds: 300),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 8,
          backgroundColor: Colors.white,
          insetAnimationCurve: Curves.easeInOut,
          insetAnimationDuration: Duration(milliseconds: 100),
          child: Container(
            padding: dialogPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    direction == TextDirection.ltr ? loader : text,
                    SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                    direction == TextDirection.rtl ? loader : text,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
