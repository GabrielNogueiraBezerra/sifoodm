import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/features/styles/styles_default.dart';
import '../../../../../shared/widgets/custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final VoidCallback onTapConfirma;
  final VoidCallback onTapSair;
  final String titulo;
  final String mensagem;
  final String textButton;
  final String buttonTitle;

  const CustomAlertDialog({
    Key key,
    @required this.onTapConfirma,
    @required this.onTapSair,
    this.titulo = 'Atenção',
    @required this.mensagem,
    this.textButton = 'Confirma Itens',
    this.buttonTitle = 'Sair mesmo assim',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 250.h,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: 37.h,
          horizontal: 44.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(36.h)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              titulo,
              style: StylesDefault().fontNunitoBold(
                fontSize: 14.sp,
                color: StylesDefault().secondaryColor,
              ),
            ),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: StylesDefault().fontNunito(
                fontSize: 14.sp,
                color: StylesDefault().secondaryColor,
              ),
            ),
            Column(
              children: <Widget>[
                CustomButton(
                  onPressed: () {
                    Modular.to.pop();
                    onTapConfirma();
                  },
                  caption: textButton,
                  height: 37.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Modular.to.pop();
                      onTapSair();
                    },
                    child: Ink(
                      color: Colors.white,
                      child: Text(
                        buttonTitle,
                        style: StylesDefault().fontNunito(
                          fontSize: 13.sp,
                          color: StylesDefault().secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
