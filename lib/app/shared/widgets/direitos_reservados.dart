import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/styles/styles_default.dart';

class DireitosReservados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Si Informática © Todos os direitos reservados',
      textAlign: TextAlign.center,
      style: StylesDefault().fontNunitoLight(
        fontSize: 14.sp,
      ),
    );
  }
}
