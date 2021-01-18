import 'dart:convert';

class Setor {
  Setor({
    this.codSetor,
    this.descSetor,
  });

  final int codSetor;
  final String descSetor;

  Setor copyWith({
    int codSetor,
    String descSetor,
  }) =>
      Setor(
        codSetor: codSetor ?? this.codSetor,
        descSetor: descSetor ?? this.descSetor,
      );

  factory Setor.fromJson(String str) => Setor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Setor.fromMap(Map<String, dynamic> json) => Setor(
        codSetor: json["cod_setor"] == null ? null : json["cod_setor"],
        descSetor: json["desc_setor"] == null ? null : json["desc_setor"],
      );

  Map<String, dynamic> toMap() => {
        "cod_setor": codSetor == null ? null : codSetor,
        "desc_setor": descSetor == null ? null : descSetor,
      };
}
