import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/styles/styles_default.dart';
import '../models/hex_color.dart';

class CustomInput extends StatefulWidget {
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
  final Icon prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final TextStyle textStyle;
  final ValueChanged<String> onChanged;

  const CustomInput({
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
    this.prefixIcon,
    this.inputFormatters,
    this.textStyle,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
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
        prefixIcon: widget.prefixIcon,
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
      ),
      style: widget.textStyle != null
          ? widget.textStyle
          : StylesDefault().fontNunitoLight(
              fontSize: 14.sp,
            ),
    );
  }
}
