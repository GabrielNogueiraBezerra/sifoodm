import 'dart:convert';

class Funcao {
  Funcao({
    this.codFuncao,
    this.nomeFuncao,
    this.itemMenu,
  });

  final int codFuncao;
  final String nomeFuncao;
  final String itemMenu;

  Funcao copyWith({
    int codFuncao,
    String nomeFuncao,
    String itemMenu,
  }) =>
      Funcao(
        codFuncao: codFuncao ?? this.codFuncao,
        nomeFuncao: nomeFuncao ?? this.nomeFuncao,
        itemMenu: itemMenu ?? this.itemMenu,
      );

  factory Funcao.fromJson(String str) => Funcao.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Funcao.fromMap(Map<String, dynamic> json) => Funcao(
        codFuncao: json["cod_funcao"] == null ? null : json["cod_funcao"],
        nomeFuncao: json["nome_funcao"] == null ? null : json["nome_funcao"],
        itemMenu: json["item_menu"] == null ? null : json["item_menu"],
      );

  Map<String, dynamic> toMap() => {
        "cod_funcao": codFuncao == null ? null : codFuncao,
        "nome_funcao": nomeFuncao == null ? null : nomeFuncao,
        "item_menu": itemMenu == null ? null : itemMenu,
      };
}
