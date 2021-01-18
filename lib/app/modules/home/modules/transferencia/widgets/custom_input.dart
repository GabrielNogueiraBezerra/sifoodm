import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/features/styles/styles_default.dart';
import '../../../../../shared/models/hex_color.dart';

class CustomInput extends StatelessWidget {
  final String descricao;
  final TextEditingController controller;
  final ValueChanged<String> onFieldSubmitted;

  const CustomInput(
      {Key key,
      @required this.descricao,
      this.controller,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            descricao,
            style: StylesDefault().fontNunitoSemiBold(
              fontSize: 15.sp,
              color: StylesDefault().secondaryColor,
            ),
          ),
          SizedBox(height: 10.h),
          Material(
            elevation: 20.0,
            borderRadius: BorderRadius.circular(50),
            shadowColor: Colors.black.withOpacity(0.3),
            child: TextFormField(
              onFieldSubmitted: onFieldSubmitted,
              textAlign: TextAlign.center,
              controller: controller,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Buscar comanda',
                hintStyle: StylesDefault().fontNunitoLight(
                  fontSize: 14.sp,
                  color: HexColor('#666666'),
                ),
                counterText: '',
                errorStyle: StylesDefault().fontNunitoLight(
                  fontSize: 11.sp,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
