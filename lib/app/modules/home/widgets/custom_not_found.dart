import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/features/styles/styles_default.dart';

class CustomNotFound extends StatelessWidget {
  final String descricao;

  const CustomNotFound({Key key, @required this.descricao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 70.h),
        SvgPicture.asset(
          'assets/images/icons/dust.svg',
          width: 78.w,
          height: 69.79.h,
          color: Colors.black.withOpacity(0.25),
        ),
        SizedBox(height: 20.h),
        Text(
          'Nada por aqui!',
          style: StylesDefault().fontNunito(
            fontSize: 21.sp,
            color: StylesDefault().primaryColor,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          descricao,
          textAlign: TextAlign.center,
          style: StylesDefault().fontNunito(fontSize: 13.sp),
        ),
      ],
    );
  }
}
