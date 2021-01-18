import 'dart:convert';

class Configuracao {
  Configuracao({
    this.codProdPadrao,
    this.taxaRestaurante,
    this.usarSetorComandasRest,
    this.saidasEstoqueNegativo,
    this.mostraTodasMesaSifood,
    this.inverteCbCobrancaRestaurante,
  });

  final int codProdPadrao;
  final double taxaRestaurante;
  final bool usarSetorComandasRest;
  final bool saidasEstoqueNegativo;
  final bool mostraTodasMesaSifood;
  final bool inverteCbCobrancaRestaurante;

  Configuracao copyWith({
    int codProdPadrao,
    double taxaRestaurante,
    bool usarSetorComandasRest,
    bool saidasEstoqueNegativo,
    bool mostraTodasMesaSifood,
    bool inverteCbCobrancaRestaurante,
  }) =>
      Configuracao(
        codProdPadrao: codProdPadrao ?? this.codProdPadrao,
        taxaRestaurante: taxaRestaurante ?? this.taxaRestaurante,
        usarSetorComandasRest:
            usarSetorComandasRest ?? this.usarSetorComandasRest,
        saidasEstoqueNegativo:
            saidasEstoqueNegativo ?? this.saidasEstoqueNegativo,
        mostraTodasMesaSifood:
            mostraTodasMesaSifood ?? this.mostraTodasMesaSifood,
        inverteCbCobrancaRestaurante:
            inverteCbCobrancaRestaurante ?? this.inverteCbCobrancaRestaurante,
      );

  factory Configuracao.fromJson(String str) =>
      Configuracao.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Configuracao.fromMap(Map<String, dynamic> json) => Configuracao(
        codProdPadrao:
            json["cod_prod_padrao"] == null ? null : json["cod_prod_padrao"],
        taxaRestaurante:
            json["taxa_restaurante"] == null ? null : json["taxa_restaurante"],
        usarSetorComandasRest: json["usar_setor_comandas_rest"] == null
            ? false
            : json["usar_setor_comandas_rest"] == 'S',
        saidasEstoqueNegativo: json["saidas_estoque_negativo"] == null
            ? false
            : json["saidas_estoque_negativo"] == 'S',
        mostraTodasMesaSifood: json["mostra_todas_mesa_sifood"] == null
            ? false
            : json["mostra_todas_mesa_sifood"] == 'S',
        inverteCbCobrancaRestaurante:
            json["inverte_cb_cobranca_restaurante"] == null
                ? false
                : json["inverte_cb_cobranca_restaurante"] == 'S',
      );

  Map<String, dynamic> toMap() => {
        "cod_prod_padrao": codProdPadrao == null ? null : codProdPadrao,
        "taxa_restaurante": taxaRestaurante == null ? null : taxaRestaurante,
        "usar_setor_comandas_rest": usarSetorComandasRest == null
            ? 'N'
            : usarSetorComandasRest ? 'S' : 'N',
        "saidas_estoque_negativo": saidasEstoqueNegativo == null
            ? 'N'
            : saidasEstoqueNegativo ? 'S' : 'N',
        "mostra_todas_mesa_sifood": mostraTodasMesaSifood == null
            ? 'N'
            : mostraTodasMesaSifood ? 'S' : 'N',
        "inverte_cb_cobranca_restaurante": inverteCbCobrancaRestaurante == null
            ? 'N'
            : inverteCbCobrancaRestaurante ? 'S' : 'N',
      };
}
