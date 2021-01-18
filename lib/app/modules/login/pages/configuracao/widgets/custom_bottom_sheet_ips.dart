import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/features/styles/styles_default.dart';
import '../../../../../shared/models/ip.dart';

class CustomBottomSheetIps extends StatelessWidget {
  final void Function(String, String) onPressedIp;
  final List<Ip> ip;
  final String porta;

  const CustomBottomSheetIps({
    Key key,
    @required this.onPressedIp,
    @required this.ip,
    @required this.porta,
  }) : super(key: key);

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
              'Selecione o IP',
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
                  return Material(
                    color: StylesDefault().backgroundColor,
                    child: InkWell(
                      onTap: () {
                        Modular.to.pop();
                        onPressedIp(porta, ip.elementAt(index).ip);
                      },
                      child: Ink(
                        height: 35.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              ip.elementAt(index).ip,
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
                itemCount: ip.length,
                separatorBuilder: (_, __) => Divider(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
