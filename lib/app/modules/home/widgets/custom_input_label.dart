import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/features/styles/styles_default.dart';
import '../../../shared/models/hex_color.dart';

class CustomInputLabel extends StatefulWidget {
  final String placeholder;
  final bool isPassword;
  final TextEditingController controller;
  final bool isUpperCase;
  final int maxLength;
  final FormFieldValidator<String> validator;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputType keyboardType;
  final String title;
  final List<TextInputFormatter> inputFormatters;

  const CustomInputLabel({
    Key key,
    @required this.placeholder,
    this.isPassword = false,
    @required this.controller,
    this.isUpperCase = false,
    this.maxLength,
    this.validator,
    @required this.textInputAction,
    this.focusNode,
    @required this.onFieldSubmitted,
    this.keyboardType,
    @required this.title,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _CustomInputLabelState createState() => _CustomInputLabelState();
}

class _CustomInputLabelState extends State<CustomInputLabel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.title,
          style: StylesDefault().fontNunitoLight(
            fontSize: 14.sp,
            color: HexColor('#666666'),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(
          inputFormatters: widget.inputFormatters,
          textAlign: TextAlign.center,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          controller: widget.controller,
          textCapitalization: widget.isUpperCase
              ? TextCapitalization.characters
              : TextCapitalization.none,
          onSaved: (value) {
            widget.controller.text = value.trim();
          },
          obscureText: widget.isPassword,
          maxLength: widget.maxLength,
          validator: widget.validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: widget.placeholder,
            hintStyle: StylesDefault().fontNunitoLight(
              fontSize: 14.sp,
              color: HexColor('#666666'),
            ),
            counterText: '',
            errorStyle: StylesDefault().fontNunitoLight(
              fontSize: 11.sp,
              color: Colors.red,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(31.h),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(31.h),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(31.h),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          style: StylesDefault().fontNunitoBold(
            fontSize: 14.sp,
            color: StylesDefault().secondaryColor,
          ),
        ),
      ],
    );
  }
}
