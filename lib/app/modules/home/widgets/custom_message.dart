import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/features/styles/styles_default.dart';
import '../../../shared/models/hex_color.dart';
import '../../../shared/widgets/custom_button.dart';

class CustomMessage extends StatelessWidget {
  final String title;
  final String message;
  final String titleConfirmed;
  final String titleOther;
  final VoidCallback onPressedConfirmed;
  final VoidCallback onPressedOther;

  const CustomMessage({
    Key key,
    this.title,
    @required this.message,
    @required this.titleConfirmed,
    @required this.titleOther,
    @required this.onPressedConfirmed,
    @required this.onPressedOther,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 455.h,
      decoration: BoxDecoration(
        color: StylesDefault().backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.h),
          topRight: Radius.circular(35.h),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 34.7.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/icons/information.svg',
              height: 106.81.h,
              width: 92.22.w,
            ),
            Text(
              title,
              style: StylesDefault().fontNunitoBold(
                fontSize: 16.sp,
                color: StylesDefault().secondaryColor,
              ),
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: StylesDefault().fontNunitoBold(
                fontSize: 13.sp,
                color: HexColor('#707070'),
              ),
            ),
            CustomButton(
              caption: titleConfirmed,
              onPressed: onPressedConfirmed,
              height: 37.h,
            ),
            GestureDetector(
              onTap: onPressedOther,
              child: Text(
                titleOther,
                style: StylesDefault().fontNunitoBold(
                  fontSize: 14.sp,
                  color: StylesDefault().secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
