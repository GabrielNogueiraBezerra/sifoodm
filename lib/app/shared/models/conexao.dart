import 'dart:convert';

class Conexao {
  Conexao({
    this.host,
    this.porta,
    this.protocolo,
    this.lembraCredenciais,
    this.nomeUsuario,
    this.dismiss,
    this.ordenacao,
  });

  final String host;
  final String porta;
  final String protocolo;
  final bool lembraCredenciais;
  final String nomeUsuario;
  final bool dismiss;
  final int ordenacao;

  String get baseUrl => protocolo == null
      ? "http://${host}:${porta}"
      : "${protocolo}://${host}:${porta}";

  Conexao copyWith({
    String host,
    String porta,
    String protocolo,
    bool lembraCredenciais,
    String nomeUsuario,
    bool dismiss,
    int ordenacao,
  }) =>
      Conexao(
        host: host ?? this.host,
        porta: porta ?? this.porta,
        protocolo: protocolo ?? this.protocolo,
        lembraCredenciais: lembraCredenciais ?? this.lembraCredenciais,
        nomeUsuario: nomeUsuario ?? this.nomeUsuario,
        dismiss: dismiss ?? this.dismiss,
        ordenacao: ordenacao ?? this.ordenacao,
      );

  factory Conexao.fromJson(String str) => Conexao.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Conexao.fromMap(Map<String, dynamic> json) => Conexao(
        host: json["host"] == null ? null : json["host"],
        porta: json["porta"] == null ? null : json["porta"],
        protocolo: json["protocolo"] == null ? null : json["protocolo"],
        lembraCredenciais: json["lembra_credenciais"] == null
            ? false
            : json["lembra_credenciais"],
        nomeUsuario: json["nome_usuario"] == null ? null : json["nome_usuario"],
        dismiss: json["dismiss"] == null ? false : json["dismiss"],
        ordenacao: json["ordenacao"] == null ? 0 : json["ordenacao"],
      );

  Map<String, dynamic> toMap() => {
        "host": host == null ? null : host,
        "porta": porta == null ? null : porta,
        "protocolo": protocolo == null ? null : protocolo,
        "lembra_credenciais":
            lembraCredenciais == null ? null : lembraCredenciais,
        "nome_usuario": nomeUsuario == null ? null : nomeUsuario,
        "dismiss": dismiss == null ? false : dismiss,
        "ordenacao": ordenacao == null ? 0 : ordenacao,
      };
}
