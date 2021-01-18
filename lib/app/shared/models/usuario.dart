import 'dart:convert';

import 'empresa.dart';
import 'grupo.dart';

class Usuario {
  Usuario({
    this.codUsu,
    this.nomeUsu,
    this.codVend,
    this.grupo,
    this.empresas,
  });

  final int codUsu;
  final String nomeUsu;
  final int codVend;
  final Grupo grupo;
  final List<Empresa> empresas;

  Usuario copyWith({
    int codUsu,
    String nomeUsu,
    int codVend,
    Grupo grupo,
    List<Empresa> empresas,
  }) =>
      Usuario(
        codUsu: codUsu ?? this.codUsu,
        nomeUsu: nomeUsu ?? this.nomeUsu,
        codVend: codVend ?? this.codVend,
        grupo: grupo ?? this.grupo,
        empresas: empresas ?? this.empresas,
      );

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  bool haveAcess(String itemMenu) {
    if (grupo.superGrupo) {
      return true;
    }

    for (var funcao in grupo.funcoes) {
      if (funcao.itemMenu == itemMenu) {
        return true;
      }
    }

    return false;
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        codUsu: json["cod_usu"] == null ? null : json["cod_usu"],
        nomeUsu: json["nome_usu"] == null ? null : json["nome_usu"],
        codVend: json["cod_vend"] == null ? null : json["cod_vend"],
        grupo: json["grupo"] == null ? null : Grupo.fromMap(json["grupo"]),
        empresas: json["empresas"] == null
            ? null
            : List<Empresa>.from(
                json["empresas"].map((x) => Empresa.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "cod_usu": codUsu == null ? null : codUsu,
        "nome_usu": nomeUsu == null ? null : nomeUsu,
        "cod_vend": codVend == null ? null : codVend,
        "grupo": grupo == null ? null : grupo.toMap(),
        "empresas": empresas == null
            ? null
            : List<dynamic>.from(empresas.map((x) => x.toMap())),
      };
}
