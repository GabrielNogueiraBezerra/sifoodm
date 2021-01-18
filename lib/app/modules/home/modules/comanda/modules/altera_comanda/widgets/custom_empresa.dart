import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../shared/features/styles/styles_default.dart';
import '../../../../../../../shared/models/hex_color.dart';

class CustomEmpresa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: Column(
        children: <Widget>[
          Text(
            'Alterar empresa vinculada',
            style: StylesDefault().fontNunitoLight(
              fontSize: 14.sp,
              color: HexColor('#666666'),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 50.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                'exemplo',
                style: StylesDefault().fontNunitoBold(
                  fontSize: 14.sp,
                  color: StylesDefault().secondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
