import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_controller.dart';
import '../features/styles/styles_default.dart';

class CustomBottomSheetSetores extends StatefulWidget {
  final void Function(int) onTapSetor;

  const CustomBottomSheetSetores({Key key, @required this.onTapSetor})
      : super(key: key);
  @override
  _CustomBottomSheetSetoresState createState() =>
      _CustomBottomSheetSetoresState();
}

class _CustomBottomSheetSetoresState extends State<CustomBottomSheetSetores> {
  AppController controller = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 256.h,
      decoration: BoxDecoration(
        color: StylesDefault().backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.h),
          topRight: Radius.circular(35.h),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 22.h,
          left: 36.w,
          right: 36.w,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Selecione o Setor',
              style: StylesDefault().fontNunitoBold(
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 41.h,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var setor = controller.setores.elementAt(index);
                  return Material(
                    color: StylesDefault().backgroundColor,
                    child: InkWell(
                      onTap: () {
                        widget.onTapSetor(setor.codSetor);
                      },
                      child: Ink(
                        height: 35.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              setor.descSetor,
                              style: StylesDefault().fontNunito(
                                fontSize: 14.sp,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: controller.setores.length,
                separatorBuilder: (_, __) => Divider(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
