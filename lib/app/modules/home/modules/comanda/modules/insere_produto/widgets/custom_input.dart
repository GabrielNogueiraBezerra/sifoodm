import 'package:flutter/material.dart';

import '../../../../../../../shared/models/hex_color.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onFieldSubmitted;

  const CustomInput({
    Key key,
    this.controller,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#707070'),
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        hintText: 'Adicione uma observação',
      ),
    );
  }
}
