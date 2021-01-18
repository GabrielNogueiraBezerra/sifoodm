import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../shared/features/styles/styles_default.dart';
import '../../../../../../../shared/models/hex_color.dart';
import '../../../../../../../shared/models/item_comanda.dart';
import '../../../../../../../shared/utils/utils.dart';
import '../../../../../../../shared/widgets/custom_button.dart';

class QuantidadeItem extends StatefulWidget {
  final ItemComanda itemComanda;
  final int index;
  final void Function(ItemComanda, int, double) onConfirmed;

  const QuantidadeItem({
    Key key,
    @required this.onConfirmed,
    @required this.itemComanda,
    @required this.index,
  }) : super(key: key);

  @override
  _QuantidadeItemState createState() => _QuantidadeItemState();
}

class _QuantidadeItemState extends State<QuantidadeItem> {
  var focusQuantidade = FocusNode();

  var textEditingController;

  @override
  void initState() {
    super.initState();

    textEditingController =
        TextEditingController(text: widget.itemComanda.quant.toString());
  }

  @override
  void dispose() {
    super.dispose();

    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 260.h,
        width: 304.w,
        padding: EdgeInsets.symmetric(
          vertical: 35.h,
          horizontal: 37.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(36.h)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Selecione a quantidade',
              style: StylesDefault().fontNunito(
                fontSize: 13.sp,
                color: StylesDefault().secondaryColor,
              ),
            ),
            Divider(color: Colors.black),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.itemComanda.descCupom,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StylesDefault().fontNunitoSemiBold(
                          fontSize: 14.sp,
                          color: StylesDefault().secondaryColor,
                        ),
                      ),
                      Text(
                        "${Utils().formatNumber(widget.itemComanda.quant)} x R\$ ${Utils().formatNumber(widget.itemComanda.valor)}",
                        overflow: TextOverflow.ellipsis,
                        style: StylesDefault().fontNunitoSemiBold(
                          fontSize: 10.sp,
                          color: HexColor('#707070'),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'R\$ ${Utils().formatNumber(widget.itemComanda.total)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StylesDefault().fontNunitoSemiBold(
                    fontSize: 14.sp,
                    color: StylesDefault().secondaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            TextFormField(
              focusNode: focusQuantidade,
              onChanged: (value) {},
              onFieldSubmitted: (value) {
                if (textEditingController.text == '') {
                  textEditingController.text = '1';
                  return;
                }

                if (double.parse(textEditingController.text) < 0) {
                  textEditingController.text = '1';
                  return;
                }

                if (double.parse(textEditingController.text) >
                    widget.itemComanda.quant) {
                  textEditingController.text =
                      widget.itemComanda.quant.toString();
                  return;
                }
              },
              controller: textEditingController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"^\d+\,?\d{0,3}"))
              ],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () {
                    focusQuantidade.unfocus();
                    focusQuantidade.canRequestFocus = false;

                    if (textEditingController.text == '') {
                      textEditingController.text = '1';
                      return;
                    }

                    if (double.parse(textEditingController.text) + 1 <=
                        widget.itemComanda.quant) {
                      textEditingController.text =
                          (double.parse(textEditingController.text) + 1)
                              .toString();
                    }
                    Future.delayed(Duration(milliseconds: 100)).then((v) async {
                      focusQuantidade.canRequestFocus = true;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    focusQuantidade.unfocus();
                    focusQuantidade.canRequestFocus = false;
                    if (textEditingController.text == '') {
                      textEditingController.text = '1';
                      return;
                    }

                    if (double.parse(textEditingController.text) > 1) {
                      textEditingController.text =
                          (double.parse(textEditingController.text) - 1)
                              .toString();
                    }
                    Future.delayed(Duration(milliseconds: 100)).then((v) async {
                      focusQuantidade.canRequestFocus = true;
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: HexColor('#707070'),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomButton(
              onPressed: () {
                if (textEditingController.text == '') {
                  Utils().showAlert(mensagem: 'Informe a quantidade.');
                  return;
                }

                if (double.parse(textEditingController.text
                        .toString()
                        .replaceAll(',', '.')) >
                    widget.itemComanda.quant) {
                  Utils().showAlert(mensagem: 'Informe uma quantidade válida.');
                  return;
                }

                widget.onConfirmed(
                    widget.itemComanda,
                    widget.index,
                    double.parse(textEditingController.text
                        .toString()
                        .replaceAll(',', '.')));
                Modular.to.pop();
              },
              caption: 'Continuar',
              height: 37.h,
            )
          ],
        ),
      ),
    );
  }
}
