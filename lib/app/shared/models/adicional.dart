import 'dart:convert';

class Adicional {
  Adicional({
    this.codPro,
    this.descCupom,
    this.quant,
    this.valor,
    this.total,
    this.cancelado,
    this.observacao,
    this.hashItem,
    this.ordem,
  });

  final int codPro;
  final String descCupom;
  final double quant;
  final double valor;
  final double total;
  final int cancelado;
  final String observacao;
  final String hashItem;
  final int ordem;

  Adicional copyWith({
    int codPro,
    String descCupom,
    double quant,
    double valor,
    double total,
    int cancelado,
    String observacao,
    String hashItem,
    int ordem,
  }) =>
      Adicional(
        codPro: codPro ?? this.codPro,
        descCupom: descCupom ?? this.descCupom,
        quant: quant ?? this.quant,
        valor: valor ?? this.valor,
        total: total ?? this.total,
        cancelado: cancelado ?? this.cancelado,
        observacao: observacao ?? this.observacao,
        hashItem: hashItem ?? this.hashItem,
        ordem: ordem ?? this.ordem,
      );

  factory Adicional.fromJson(String str) => Adicional.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Adicional.fromMap(Map<String, dynamic> json) => Adicional(
        codPro: json["cod_pro"] == null ? null : json["cod_pro"],
        descCupom: json["desc_cupom"] == null ? null : json["desc_cupom"],
        quant: json["quant"] == null ? null : json["quant"].toDouble(),
        valor: json["valor"] == null ? null : json["valor"].toDouble(),
        total: json["total"] == null ? null : json["total"].toDouble(),
        cancelado: json["cancelado"] == null ? null : json["cancelado"],
        observacao: json["observacao"] == null ? null : json["observacao"],
        ordem: json["ordem"] == null ? null : json["ordem"],
      );

  Map<String, dynamic> toMap() => {
        "cod_pro": codPro == null ? null : codPro,
        "desc_cupom": descCupom == null ? null : descCupom,
        "quant": quant == null ? null : quant,
        "valor": valor == null ? null : valor,
        "total": total == null ? null : total,
        "cancelado": cancelado == null ? null : cancelado,
        "observacao": observacao == null ? null : observacao,
        "ordem": ordem == null ? null : ordem,
      };
}
