import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/styles/styles_default.dart';
import '../utils/utils.dart';
import 'lista.dart';

class Produto implements Lista {
  Produto({
    this.codPro,
    this.referenciaPro,
    this.nomePro,
    this.valorPro,
    this.promocaoPro,
    this.descCupom,
    this.estoque,
    this.controlaEstoquePro,
    this.codigoTipo,
    this.usaQuantidadeFracionaria,
    this.composicao,
  });

  final int codPro;
  final String referenciaPro;
  final String nomePro;
  final double valorPro;
  final double promocaoPro;
  final String descCupom;
  final double estoque;
  final bool controlaEstoquePro;
  final int codigoTipo;
  final bool usaQuantidadeFracionaria;
  final String composicao;

  double get valorProduto => promocaoPro > 0 ? promocaoPro : valorPro;

  Produto copyWith({
    int codPro,
    String referenciaPro,
    String nomePro,
    double valorPro,
    double promocaoPro,
    String descCupom,
    double estoque,
    bool controlaEstoquePro,
    int codigoTipo,
    bool usaQuantidadeFracionaria,
    String composicao,
  }) =>
      Produto(
        codPro: codPro ?? this.codPro,
        referenciaPro: referenciaPro ?? this.referenciaPro,
        nomePro: nomePro ?? this.nomePro,
        valorPro: valorPro ?? this.valorPro,
        promocaoPro: promocaoPro ?? this.promocaoPro,
        descCupom: descCupom ?? this.descCupom,
        estoque: estoque ?? this.estoque,
        controlaEstoquePro: controlaEstoquePro ?? this.controlaEstoquePro,
        codigoTipo: codigoTipo ?? this.codigoTipo,
        usaQuantidadeFracionaria:
            usaQuantidadeFracionaria ?? this.usaQuantidadeFracionaria,
        composicao: composicao ?? this.composicao,
      );

  factory Produto.fromJson(String str) => Produto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Produto.fromMap(Map<String, dynamic> json) => Produto(
        codPro: json["cod_pro"] == null ? null : json["cod_pro"],
        referenciaPro:
            json["referencia_pro"] == null ? null : json["referencia_pro"],
        nomePro: json["nome_pro"] == null ? null : json["nome_pro"],
        valorPro:
            json["valor_pro"] == null ? null : json["valor_pro"].toDouble(),
        promocaoPro: json["promocao_pro"] == null
            ? null
            : json["promocao_pro"].toDouble(),
        descCupom: json["desc_cupom"] == null ? null : json["desc_cupom"],
        estoque: json["estoque"] == null ? null : json["estoque"],
        controlaEstoquePro: json["controla_estoque_pro"] == null
            ? false
            : json["controla_estoque_pro"] == 'S',
        codigoTipo: json["codigo_tipo"] == null ? null : json["codigo_tipo"],
        usaQuantidadeFracionaria: json["usa_quantidade_francionaria"] == null
            ? false
            : json["usa_quantidade_francionaria"] == 'S',
        composicao: json["composicao"] == null ? null : json["composicao"],
      );

  Map<String, dynamic> toMap() => {
        "cod_pro": codPro == null ? null : codPro,
        "referencia_pro": referenciaPro == null ? null : referenciaPro,
        "nome_pro": nomePro == null ? null : nomePro,
        "valor_pro": valorPro == null ? null : valorPro,
        "promocao_pro": promocaoPro == null ? null : promocaoPro,
        "desc_cupom": descCupom == null ? null : descCupom,
        "estoque": estoque == null ? null : estoque,
        "codigo_tipo": codigoTipo == null ? null : codigoTipo,
        "usa_quantidade_francionaria":
            usaQuantidadeFracionaria == null ? null : usaQuantidadeFracionaria,
        "composicao": composicao == null ? null : composicao,
      };

  @override
  Widget item({VoidCallback onTap, BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .08,
      ),
      child: Material(
        color: StylesDefault().backgroundColor,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            color: StylesDefault().backgroundColor,
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        nomePro,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: StylesDefault().fontNunito(
                          fontSize: 12.sp,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Visibility(
                            visible: referenciaPro != '',
                            child: Text(
                              'Referência: ${referenciaPro}',
                              style: StylesDefault().fontNunitoLight(
                                fontSize: 10.sp,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: referenciaPro != '',
                            child: SizedBox(
                              width: 15.w,
                            ),
                          ),
                          Text(
                            'Estoque: ${Utils().formatNumber(estoque)}',
                            style: StylesDefault().fontNunitoLight(
                              fontSize: 10.sp,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'R\$ ${Utils().formatNumber(valorPro)}',
                      overflow: TextOverflow.ellipsis,
                      style: StylesDefault().fontNunito(
                        fontSize: promocaoPro > 0 ? 8.sp : 12.sp,
                        color: Colors.black.withOpacity(0.8),
                        decoration: promocaoPro > 0
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    Visibility(
                      visible: promocaoPro > 0,
                      child: Text(
                        'R\$ ${Utils().formatNumber(promocaoPro)}',
                        overflow: TextOverflow.ellipsis,
                        style: StylesDefault().fontNunito(
                          fontSize: 12.sp,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
