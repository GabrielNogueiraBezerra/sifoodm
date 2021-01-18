import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/styles/styles_default.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String caption;
  final bool loading;
  final double height;
  final Color backgroundColor;
  final Color color;
  final Color textColor;
  final double width;

  const CustomButton({
    Key key,
    @required this.onPressed,
    @required this.caption,
    this.loading = false,
    @required this.height,
    this.backgroundColor,
    this.color,
    this.textColor,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width == null ? MediaQuery.of(context).size.width : width,
      child: RaisedButton(
        elevation: 0,
        color: backgroundColor == null
            ? StylesDefault().primaryColor
            : backgroundColor,
        onPressed: loading ? () {} : onPressed,
        child: loading
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
                height: MediaQuery.of(context).size.width * 0.05,
                child: CircularProgressIndicator(),
              )
            : Text(
                caption,
                style: StylesDefault().fontNunito(
                    fontSize: 13.sp,
                    color: textColor == null
                        ? StylesDefault().secondaryColor
                        : textColor),
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(31.h),
          side: BorderSide(
            width: 1,
            color: color == null ? StylesDefault().primaryColor : color,
          ),
        ),
      ),
    );
  }
}
