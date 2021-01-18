import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/styles/styles_default.dart';
import 'lista.dart';

class Secao implements Lista {
  Secao({
    this.codSecao,
    this.nomeSec,
  });

  final int codSecao;
  final String nomeSec;

  Secao copyWith({
    int codSecao,
    String nomeSec,
  }) =>
      Secao(
        codSecao: codSecao ?? this.codSecao,
        nomeSec: nomeSec ?? this.nomeSec,
      );

  factory Secao.fromJson(String str) => Secao.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Secao.fromMap(Map<String, dynamic> json) => Secao(
        codSecao: json["cod_secao"] == null ? null : json["cod_secao"],
        nomeSec: json["nome_sec"] == null ? null : json["nome_sec"],
      );

  Map<String, dynamic> toMap() => {
        "cod_secao": codSecao == null ? null : codSecao,
        "nome_sec": nomeSec == null ? null : nomeSec,
      };

  @override
  Widget item({onTap, BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      child: Material(
        color: StylesDefault().backgroundColor,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            color: StylesDefault().backgroundColor,
            height: 50.h,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  nomeSec,
                  style: StylesDefault().fontNunito(
                    fontSize: 14.sp,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
