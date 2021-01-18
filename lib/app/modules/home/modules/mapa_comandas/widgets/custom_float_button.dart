import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/features/styles/styles_default.dart';

class CustomFloatButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatButton({Key key, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 286.w,
      height: 37.h,
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        label: Text(
          'Abrir nova comanda',
          style: StylesDefault().fontNunitoBold(
            fontSize: 14.sp,
            color: StylesDefault().secondaryColor,
          ),
        ),
        backgroundColor: StylesDefault().primaryColor,
      ),
    );
  }
}
