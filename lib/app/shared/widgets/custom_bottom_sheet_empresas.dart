import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/styles/styles_default.dart';
import '../models/empresa.dart';

class CustomBottomSheetEmpresas extends StatefulWidget {
  final void Function(int) onPressedEmpresa;
  final List<Empresa> empresas;

  const CustomBottomSheetEmpresas({
    Key key,
    @required this.onPressedEmpresa,
    @required this.empresas,
  }) : super(key: key);

  @override
  _CustomBottomSheetEmpresasState createState() =>
      _CustomBottomSheetEmpresasState();
}

class _CustomBottomSheetEmpresasState extends State<CustomBottomSheetEmpresas> {
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
              'Selecione a Empresa',
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
                  var empresa = widget.empresas.elementAt(index);
                  return Material(
                    color: StylesDefault().backgroundColor,
                    child: InkWell(
                      onTap: () {
                        Modular.to.pop();
                        widget.onPressedEmpresa(index);
                      },
                      child: Ink(
                        height: 35.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              empresa.fantasiaEmp,
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
                itemCount: widget.empresas.length,
                separatorBuilder: (_, __) => Divider(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
