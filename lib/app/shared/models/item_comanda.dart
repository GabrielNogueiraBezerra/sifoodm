import 'dart:convert';

import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../features/styles/styles_default.dart';
import '../utils/utils.dart';
import 'adicional.dart';
import 'hex_color.dart';
import 'lista.dart';
import 'produto.dart';

enum StatusItemComanda { normal, impresso, cancelado }

class ItemComanda implements Lista {
  ItemComanda({
    this.index,
    this.codPro,
    this.descCupom,
    this.quant,
    this.valor,
    this.totalParcial,
    this.cancelado,
    this.impresso,
    this.observacao,
    this.adicionais,
    this.total,
    this.hashItem,
    this.ordem,
    this.produto,
    this.expanded = false,
    this.quantSelecionada = 0,
    this.selecionado = false,
  });

  final int codPro;
  final String descCupom;
  final double quant;
  final double valor;
  final double totalParcial;
  final int cancelado;
  final String impresso;
  final String observacao;
  final List<Adicional> adicionais;
  final double total;

  final String hashItem;

  final int index;
  final int ordem;
  final Produto produto;
  final bool expanded;
  final double quantSelecionada;
  final bool selecionado;

  StatusItemComanda get status {
    if (cancelado == 1) {
      return StatusItemComanda.cancelado;
    } else if (impresso == 'S') {
      return StatusItemComanda.impresso;
    } else {
      return StatusItemComanda.normal;
    }
  }

  int get statusInteger {
    if (cancelado == 1) {
      return 0;
    } else if (impresso == 'S') {
      return 1;
    } else {
      return 2;
    }
  }

  List<Color> cores = [
    HexColor('#FA5280'),
    HexColor('#1AF17F'),
    HexColor('#707070'),
  ];

  ItemComanda copyWith({
    int index,
    int codPro,
    String descCupom,
    double quant,
    double valor,
    double totalParcial,
    int cancelado,
    String impresso,
    String observacao,
    List<Adicional> adicionais,
    double total,
    String hashItem,
    int ordem,
    Produto produto,
    bool expanded,
    double quantSelecionada,
    bool selecionado,
  }) =>
      ItemComanda(
        index: index ?? this.index,
        codPro: codPro ?? this.codPro,
        descCupom: descCupom ?? this.descCupom,
        quant: quant ?? this.quant,
        valor: valor ?? this.valor,
        totalParcial: totalParcial ?? this.totalParcial,
        cancelado: cancelado ?? this.cancelado,
        impresso: impresso ?? this.impresso,
        observacao: observacao ?? this.observacao,
        adicionais: adicionais ?? this.adicionais,
        total: total ?? this.total,
        hashItem: hashItem ?? this.hashItem,
        ordem: ordem ?? this.ordem,
        produto: produto ?? this.produto,
        expanded: expanded ?? this.expanded,
        quantSelecionada: quantSelecionada ?? this.quantSelecionada,
        selecionado: selecionado ?? this.selecionado,
      );

  factory ItemComanda.fromJson(String str) =>
      ItemComanda.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemComanda.fromMap(Map<String, dynamic> json) => ItemComanda(
        codPro: json["cod_pro"] == null ? null : json["cod_pro"],
        descCupom: json["desc_cupom"] == null ? null : json["desc_cupom"],
        quant: json["quant"] == null ? null : json["quant"].toDouble(),
        valor: json["valor"] == null ? null : json["valor"].toDouble(),
        totalParcial: json["total_parcial"] == null
            ? null
            : json["total_parcial"].toDouble(),
        cancelado: json["cancelado"] == null ? null : json["cancelado"],
        impresso: json["impresso"] == null ? null : json["impresso"],
        observacao: json["observacao"] == null ? null : json["observacao"],
        adicionais: json["adicionais"] == null
            ? null
            : List<Adicional>.from(
                json["adicionais"].map((x) => Adicional.fromMap(x))),
        total: json["total"] == null ? null : json["total"].toDouble(),
        ordem: json["ordem"] == null ? null : json["ordem"],
      );

  Map<String, dynamic> toMap() => {
        "cod_pro": codPro == null ? null : codPro,
        "desc_cupom": descCupom == null ? null : descCupom,
        "quant": quant == null ? null : quant,
        "valor": valor == null ? null : valor,
        "total_parcial": totalParcial == null ? null : totalParcial,
        "cancelado": cancelado == null ? null : cancelado,
        "impresso": impresso == null ? null : impresso,
        "observacao": observacao == null ? null : observacao,
        "adicionais": adicionais == null
            ? []
            : List<dynamic>.from(adicionais.map((x) => x.toMap())),
        "total": total == null ? null : total,
        "ordem": ordem == null ? null : ordem,
      };

  @override
  Widget item(
      {onTap,
      BuildContext context,
      bool last,
      bool usaStatus = true,
      VoidCallback onTapDelete,
      VoidCallback onTapEdit}) {
    if (usaStatus) {
      return ConfigurableExpansionTile(
        header: headeItem(
            context: context, last: last, active: false, usaStatus: usaStatus),
        children: itemChildren(context),
        kExpand: Duration(milliseconds: 200),
        headerExpanded: headeItem(
            context: context, last: last, active: true, usaStatus: usaStatus),
      );
    } else {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        actions: <Widget>[
          IconSlideAction(
            caption: 'Alterar',
            color: StylesDefault().primaryColor,
            foregroundColor: StylesDefault().secondaryColor,
            icon: Icons.archive,
            onTap: onTapEdit,
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Deletar',
            color: Colors.red,
            icon: Icons.delete,
            onTap: onTapDelete,
          ),
        ],
        child: ConfigurableExpansionTile(
          header: headeItem(
              context: context,
              last: last,
              active: false,
              usaStatus: usaStatus),
          children: itemChildren(context),
          kExpand: Duration(milliseconds: 200),
          headerExpanded: headeItem(
              context: context, last: last, active: true, usaStatus: usaStatus),
        ),
      );
    }
  }

  List<Widget> itemChildren(BuildContext context) {
    if (adicionais == null) {
      return [];
    } else {
      if (adicionais.isEmpty) {
        return [];
      } else {
        var listAdicionais = <Widget>[];

        for (var item in adicionais) {
          listAdicionais.add(
            itemAdicional(
              adicional: item,
              context: context,
              last: item == adicionais.last,
              status: Colors.green,
            ),
          );
        }

        return listAdicionais;
      }
    }
  }

  Widget itemAdicional(
      {BuildContext context, Adicional adicional, bool last, Color status}) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.065,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 37.w,
        ),
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
                    adicional.descCupom,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: StylesDefault().fontNunito(
                      fontSize: 11.sp,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${Utils().formatNumber(adicional.quant)} x R\$ ${Utils().formatNumber(adicional.valor)}",
                    style: StylesDefault().fontNunito(
                      fontSize: 11.sp,
                      color: Colors.black.withOpacity(0.35),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "R\$ ${Utils().formatNumber(adicional.total)}",
              style: StylesDefault().fontNunito(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headeItem(
      {BuildContext context, bool last, bool active, bool usaStatus}) {
    return Container(
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(
                bottom: BorderSide(
                    color: HexColor('#707070').withOpacity(0.5), width: 0.5),
              ),
      ),
      height: MediaQuery.of(context).size.height * 0.13,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Visibility(
            visible: usaStatus,
            child: Container(
              width: 4,
              color: cores[statusInteger],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        descCupom,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: StylesDefault().fontNunito(
                          fontSize: 13.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "${usaStatus ? ordem.toString().padLeft(3, '0') : ''} ${Utils().formatNumber(quant)} x R\$ ${Utils().formatNumber(valor)}",
                        style: StylesDefault().fontNunito(
                          fontSize: 13.sp,
                          color: Colors.black.withOpacity(0.35),
                        ),
                      ),
                      Visibility(
                        visible: observacao != null && observacao != '',
                        child: Text(
                          observacao,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: StylesDefault().fontNunito(
                            fontSize: 13.sp,
                            color: Colors.black.withOpacity(0.35),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "R\$ ${Utils().formatNumber(total)}",
                          style: StylesDefault().fontNunito(
                            fontSize: (totalParcial > 0) ? 8.sp : 13.sp,
                            color: Colors.black,
                            decoration: (totalParcial > 0)
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        Visibility(
                          visible: totalParcial > 0,
                          child: Text(
                            "R\$ ${Utils().formatNumber(total - totalParcial)}",
                            style: StylesDefault().fontNunito(
                              fontSize: 13.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                        active
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: adicionais != null
                            ? adicionais.isNotEmpty
                                ? StylesDefault().secondaryColor
                                : Colors.transparent
                            : Colors.transparent),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
