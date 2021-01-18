import 'dart:convert';

import 'configuracao.dart';

class Empresa {
  Empresa({
    this.codEmp,
    this.fantasiaEmp,
    this.totalMesasAbertas,
    this.configuracoes,
    this.statusLicenca,
    this.retornoLicenca,
  });

  final int codEmp;
  final String fantasiaEmp;
  final int totalMesasAbertas;
  final Configuracao configuracoes;
  final int statusLicenca;
  final String retornoLicenca;

  Empresa copyWith({
    int codEmp,
    String fantasiaEmp,
    int totalMesasAbertas,
    Configuracao configuracoes,
    int statusLicenca,
    String retornoLicenca,
  }) =>
      Empresa(
        codEmp: codEmp ?? this.codEmp,
        fantasiaEmp: fantasiaEmp ?? this.fantasiaEmp,
        totalMesasAbertas: totalMesasAbertas ?? this.totalMesasAbertas,
        configuracoes: configuracoes ?? this.configuracoes,
        statusLicenca: statusLicenca ?? this.statusLicenca,
        retornoLicenca: retornoLicenca ?? this.retornoLicenca,
      );

  factory Empresa.fromJson(String str) => Empresa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Empresa.fromMap(Map<String, dynamic> json) => Empresa(
        codEmp: json["cod_emp"] == null ? null : json["cod_emp"],
        fantasiaEmp: json["fantasia_emp"] == null ? null : json["fantasia_emp"],
        totalMesasAbertas: json["total_mesas_abertas"] == null
            ? 0
            : json["total_mesas_abertas"],
        configuracoes: json["configuracoes"] == null
            ? null
            : Configuracao.fromMap(json["configuracoes"]),
        statusLicenca:
            json["status_licenca"] == null ? null : json["status_licenca"],
        retornoLicenca:
            json["retorno_licenca"] == null ? null : json["retorno_licenca"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp == null ? null : codEmp,
        "fantasia_emp": fantasiaEmp == null ? null : fantasiaEmp,
        "total_mesas_abertas":
            totalMesasAbertas == null ? null : totalMesasAbertas,
        "configuracoes": configuracoes == null ? null : configuracoes.toMap(),
        "status_licenca": statusLicenca == null ? null : statusLicenca,
        "retorno_licenca": retornoLicenca == null ? null : retornoLicenca,
      };
}
