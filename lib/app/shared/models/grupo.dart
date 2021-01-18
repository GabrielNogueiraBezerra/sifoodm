import 'dart:convert';

import 'funcao.dart';

class Grupo {
  Grupo({
    this.codGrupo,
    this.nomeGrupo,
    this.funcoes,
    this.superGrupo,
  });

  final int codGrupo;
  final String nomeGrupo;
  final List<Funcao> funcoes;
  final bool superGrupo;

  Grupo copyWith({
    int codGrupo,
    String nomeGrupo,
    List<Funcao> funcoes,
    bool superGrupo,
  }) =>
      Grupo(
        codGrupo: codGrupo ?? this.codGrupo,
        nomeGrupo: nomeGrupo ?? this.nomeGrupo,
        funcoes: funcoes ?? this.funcoes,
        superGrupo: superGrupo ?? this.superGrupo,
      );

  factory Grupo.fromJson(String str) => Grupo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Grupo.fromMap(Map<String, dynamic> json) => Grupo(
        codGrupo: json["cod_grupo"] == null ? null : json["cod_grupo"],
        nomeGrupo: json["nome_grupo"] == null ? null : json["nome_grupo"],
        funcoes: json["funcoes"] == null
            ? null
            : List<Funcao>.from(json["funcoes"].map((x) => Funcao.fromMap(x))),
        superGrupo:
            json["super_grupo"] == null ? false : json["super_grupo"] == "S",
      );

  Map<String, dynamic> toMap() => {
        "cod_grupo": codGrupo == null ? null : codGrupo,
        "nome_grupo": nomeGrupo == null ? null : nomeGrupo,
        "funcoes": funcoes == null
            ? null
            : List<dynamic>.from(funcoes.map((x) => x.toMap())),
        "super_grupo": superGrupo == null ? "N" : superGrupo ? "S" : "N",
      };
}
