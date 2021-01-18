import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/features/styles/styles_default.dart';
import '../../../../../shared/models/hex_color.dart';
import '../mapa_comandas_controller.dart';

class Ordenacao extends StatefulWidget {
  @override
  _OrdenacaoState createState() => _OrdenacaoState();
}

class _OrdenacaoState extends State<Ordenacao> {
  MapaComandasController controller = Modular.get<MapaComandasController>();

  @override
  Widget build(BuildContext context) {
    var itens = ["Ordem numérica", "Ordem alfabética", "Status da comanda"];

    return Dialog(
      shape: RoundedRectangleBorder(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 251.h,
        width: 254.w,
        padding: EdgeInsets.symmetric(
          vertical: 19.h,
          horizontal: 16.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Ordenar por:",
                style: StylesDefault().fontNunitoBold(
                  fontSize: 13.sp,
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Expanded(
              child: Observer(builder: (context) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    var item = itens[index];
                    return Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          controller.changeOrdenacao(index);
                          Modular.to.pop();
                        },
                        child: Ink(
                          color: Colors.white,
                          height: 40.h,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                item,
                                style: StylesDefault().fontNunito(
                                  fontSize: 13.sp,
                                ),
                              ),
                              Visibility(
                                visible: index == controller.ordenacao,
                                child: Icon(
                                  Icons.check,
                                  color: HexColor("#3FDC34"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: itens.length,
                  separatorBuilder: (_, __) => Divider(color: Colors.grey),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
