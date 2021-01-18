import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../features/styles/styles_default.dart';
import 'hex_color.dart';
import 'lista.dart';

class Observacao implements Lista {
  Observacao({
    this.codObs,
    this.descObs,
    this.codSec,
  });

  final int codObs;
  final String descObs;
  final int codSec;

  Observacao copyWith({
    int codObs,
    String descObs,
    int codSec,
  }) =>
      Observacao(
        codObs: codObs ?? this.codObs,
        descObs: descObs ?? this.descObs,
        codSec: codSec ?? this.codSec,
      );

  factory Observacao.fromJson(String str) =>
      Observacao.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Observacao.fromMap(Map<String, dynamic> json) => Observacao(
        codObs: json["cod_obs"] == null ? null : json["cod_obs"],
        descObs: json["desc_obs"] == null ? null : json["desc_obs"],
        codSec: json["cod_sec"] == null ? null : json["cod_sec"],
      );

  Map<String, dynamic> toMap() => {
        "cod_obs": codObs == null ? null : codObs,
        "desc_obs": descObs == null ? null : descObs,
        "cod_sec": codSec == null ? null : codSec,
      };

  @override
  Widget item({VoidCallback onTap, BuildContext context, bool selected}) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                descObs,
                style: StylesDefault().fontNunito(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: StylesDefault().secondaryColor,
                ),
              ),
              selected
                  ? Icon(
                      Icons.check,
                      color: HexColor("#3FDC34"),
                    )
                  : SvgPicture.asset(
                      'assets/images/icons/unselect.svg',
                      height: MediaQuery.of(context).size.height * 0.02,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
