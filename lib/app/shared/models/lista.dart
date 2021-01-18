import 'package:flutter/material.dart';

abstract class Lista {
  Widget item({VoidCallback onTap, @required BuildContext context});
}
