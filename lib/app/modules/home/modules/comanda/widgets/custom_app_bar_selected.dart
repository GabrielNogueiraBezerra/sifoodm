import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/features/styles/styles_default.dart';

class CustomAppBarSelected extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onPressedBack;
  final VoidCallback onPressedEdit;
  final VoidCallback onPressedDelete;
  final String title;

  const CustomAppBarSelected({
    Key key,
    @required this.onPressedBack,
    @required this.title,
    this.onPressedEdit,
    this.onPressedDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: onPressedBack,
        icon: Icon(
          Icons.arrow_back,
          color: StylesDefault().secondaryColor,
        ),
      ),
      actions: <Widget>[
        Visibility(
          visible: onPressedEdit != null,
          child: SizedBox(
            height: 20.h,
            child: IconButton(
              icon: Icon(
                Icons.edit,
                size: 20.71.h.w,
                color: StylesDefault().secondaryColor,
              ),
              onPressed: onPressedEdit,
            ),
          ),
        ),
        Icon(null),
        IconButton(
          onPressed: onPressedDelete,
          icon: Icon(
            Icons.delete,
            size: 20.71.h.w,
            color: StylesDefault().secondaryColor,
          ),
        ),
        Icon(null),
      ],
      title: Text(
        title,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      MediaQuery.of(Modular.navigatorKey.currentContext).size.height * 0.08);
}
