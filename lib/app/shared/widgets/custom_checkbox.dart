import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/styles/styles_default.dart';
import '../models/hex_color.dart';

class CustomCheckbox extends StatelessWidget {
  final bool checked;
  final VoidCallback onTap;
  final String texto;
  final Color color;

  const CustomCheckbox({
    Key key,
    @required this.checked,
    @required this.onTap,
    @required this.texto,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Icon(
              checked ? Icons.check_box : Icons.check_box_outline_blank,
              color: checked
                  ? StylesDefault().primaryColor
                  : color == null ? HexColor('#E7E7E7') : color,
            ),
            SizedBox(
              width: 7.w,
            ),
            Text(
              texto,
              style: StylesDefault().fontNunitoLight(
                  fontSize: 12.sp,
                  color: color == null ? HexColor('#666666') : color),
            ),
          ],
        ),
      ),
    );
  }
}
