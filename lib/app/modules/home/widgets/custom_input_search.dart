import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/features/styles/styles_default.dart';
import '../../../shared/models/hex_color.dart';

class CustomInputSearch extends StatefulWidget {
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
  final VoidCallback onPressedSuffix;
  final ValueChanged<String> onChanged;
  final Color backgroundColor;

  const CustomInputSearch({
    Key key,
    @required this.placeholder,
    this.isPassword = false,
    @required this.controller,
    this.isUpperCase = false,
    this.maxLength,
    this.validator,
    @required this.textInputAction,
    @required this.focusNode,
    @required this.onFieldSubmitted,
    this.keyboardType,
    this.onPressedSuffix,
    this.onChanged,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _CustomInputSearchState createState() => _CustomInputSearchState();
}

class _CustomInputSearchState extends State<CustomInputSearch> {
  bool existeTexto = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged(value);
        }
        setState(() {
          existeTexto = value != "";
        });
      },
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
        fillColor: widget.backgroundColor == null
            ? Colors.white
            : widget.backgroundColor,
        prefixIcon: IconButton(
          onPressed: null,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .03,
          ),
          icon: Icon(
            Icons.search,
            color: StylesDefault().secondaryColor,
          ),
        ),
        suffixIcon: !existeTexto
            ? null
            : IconButton(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * .03,
                ),
                onPressed: () {
                  widget.focusNode.unfocus();
                  widget.focusNode.canRequestFocus = false;

                  if (widget.controller.text != '') {
                    widget.onPressedSuffix();
                  }

                  Future.delayed(Duration(milliseconds: 100)).then((v) async {
                    widget.focusNode.canRequestFocus = true;
                  });

                  setState(() {
                    existeTexto = false;
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: StylesDefault().secondaryColor,
                ),
              ),
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
      ),
      style: StylesDefault().fontNunitoLight(
        fontSize: 14.sp,
      ),
    );
  }
}
