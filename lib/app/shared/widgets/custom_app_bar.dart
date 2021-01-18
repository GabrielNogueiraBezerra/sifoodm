import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/styles/styles_default.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GestureTapCallback onPressed;
  final Color backgroundColor;

  const CustomAppBar({
    Key key,
    @required this.title,
    @required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.chevron_left,
          color: StylesDefault().secondaryColor,
        ),
      ),
      title: Text(
        title,
        style: StylesDefault().fontNunito(
          fontSize: 20.sp,
          color: StylesDefault().secondaryColor,
        ),
      ),
      centerTitle: true,
      backgroundColor:
          backgroundColor == null ? Colors.transparent : backgroundColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      MediaQuery.of(Modular.navigatorKey.currentContext).size.height * 0.08);
}
