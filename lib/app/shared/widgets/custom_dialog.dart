import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../features/styles/styles_default.dart';
import 'custom_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String mensagem;

  const CustomDialog({
    Key key,
    this.title,
    @required this.mensagem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.h,
      decoration: BoxDecoration(
        color: StylesDefault().backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.h),
          topRight: Radius.circular(35.h),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 36.w,
          vertical: 22.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/icons/information.svg',
              height: 80.h,
              width: 80.w,
            ),
            Text(
              title,
              style: StylesDefault().fontNunitoSemiBold(
                fontSize: 18.sp,
                color: Colors.black,
              ),
            ),
            Text(
              mensagem,
              textAlign: TextAlign.justify,
              style: StylesDefault().fontNunito(
                fontSize: 12.sp,
                color: Colors.black,
              ),
            ),
            CustomButton(
              onPressed: () {
                Modular.to.pop();
              },
              caption: 'Entendido!',
              height: 37.h,
            ),
          ],
        ),
      ),
    );
  }
}
