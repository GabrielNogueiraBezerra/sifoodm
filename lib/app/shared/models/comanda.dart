import 'dart:convert';

import 'package:flutter/material.dart';

import 'hex_color.dart';

class Comanda {
  Comanda({
    this.codigo,
    this.status,
    this.conta,
    this.totalPessoas,
    this.descMesa,
    this.subTotal,
    this.taxaServico,
    this.parcial,
    this.total,
    this.codSetor,
  });

  final int codigo;
  final int status;
  final int conta;
  final int totalPessoas;
  final String descMesa;
  final double subTotal;
  final double taxaServico;
  final double parcial;
  final double total;
  final int codSetor;

  static List colorsStatus = [
    HexColor('#1AF17F'),
    HexColor('#6941D8'),
    HexColor('#FCBF14'),
  ];

  Color get getColor => colorsStatus.elementAt(status);

  String get formatConta =>
      conta == null ? '' : conta.toString().padLeft(3, '0');

  Comanda copyWith({
    int codigo,
    int status,
    int conta,
    int totalPessoas,
    String descMesa,
    double subTotal,
    double taxaServico,
    double parcial,
    double total,
    int codSetor,
  }) =>
      Comanda(
        codigo: codigo ?? this.codigo,
        status: status ?? this.status,
        conta: conta ?? this.conta,
        totalPessoas: totalPessoas ?? this.totalPessoas,
        descMesa: descMesa ?? this.descMesa,
        subTotal: subTotal ?? this.subTotal,
        taxaServico: taxaServico ?? this.taxaServico,
        parcial: parcial ?? this.parcial,
        total: total ?? this.total,
        codSetor: codSetor ?? this.codSetor,
      );

  factory Comanda.fromJson(String str) => Comanda.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Comanda.fromMap(Map<String, dynamic> json) => Comanda(
        codigo: json["codigo"] == null ? null : json["codigo"],
        status: json["status"] == null ? null : json["status"],
        conta: json["conta"] == null ? null : json["conta"],
        totalPessoas:
            json["total_pessoas"] == null ? null : json["total_pessoas"],
        descMesa: json["desc_mesa"] == null ? null : json["desc_mesa"],
        subTotal:
            json["sub_total"] == null ? null : json["sub_total"].toDouble(),
        taxaServico: json["taxa_servico"] == null
            ? null
            : json["taxa_servico"].toDouble(),
        parcial: json["parcial"] == null ? null : json["parcial"].toDouble(),
        total: json["total"] == null ? null : json["total"].toDouble(),
        codSetor: json["cod_setor"] == null ? null : json["cod_setor"],
      );

  Map<String, dynamic> toMap() => {
        "codigo": codigo == null ? null : codigo,
        "status": status == null ? null : status,
        "conta": conta == null ? null : conta,
        "total_pessoas": totalPessoas == null ? null : totalPessoas,
        "desc_mesa": descMesa == null ? null : descMesa,
        "sub_total": subTotal == null ? null : subTotal,
        "taxa_servico": taxaServico == null ? null : taxaServico,
        "parcial": parcial == null ? null : parcial,
        "total": total == null ? null : total,
        "cod_setor": codSetor == null ? null : codSetor,
      };
}
