import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/features/styles/styles_default.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GestureTapCallback onPressed;
  final String subtitle;
  final VoidCallback onTap;

  const CustomAppBar({
    Key key,
    @required this.title,
    @required this.onPressed,
    @required this.subtitle,
    @required this.onTap,
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
      actions: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * .05),
          child: Material(
            color: StylesDefault().backgroundColor,
            child: InkWell(
              onTap: onTap,
              child: Ink(
                color: StylesDefault().backgroundColor,
                child: Center(
                  child: Text(
                    'editar',
                    style: StylesDefault().fontNunito(
                      fontSize: 11.sp,
                      color: StylesDefault().secondaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      title: Column(
        children: <Widget>[
          Text(
            title,
            style: StylesDefault().fontNunito(
              fontSize: 20.sp,
              color: StylesDefault().secondaryColor,
            ),
          ),
          Text(
            subtitle,
            style: StylesDefault().fontNunito(
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      MediaQuery.of(Modular.navigatorKey.currentContext).size.height * 0.08);
}
