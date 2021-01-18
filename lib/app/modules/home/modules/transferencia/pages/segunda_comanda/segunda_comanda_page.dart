import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/features/styles/styles_default.dart';
import '../../../../../../shared/models/comanda.dart';
import '../../../../../../shared/models/item_comanda.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../../../shared/widgets/custom_input.dart';
import 'segunda_comanda_controller.dart';

class SegundaComandaPage extends StatefulWidget {
  final Comanda comanda;
  final List<ItemComanda> itensComanda;
  final String title;
  const SegundaComandaPage({
    Key key,
    this.title = "Transferência",
    this.comanda,
    this.itensComanda,
  }) : super(key: key);

  @override
  _SegundaComandaPageState createState() => _SegundaComandaPageState();
}

class _SegundaComandaPageState
    extends ModularState<SegundaComandaPage, SegundaComandaController> {
  @override
  void initState() {
    super.initState();

    controller.comanda = widget.comanda;
    controller.itensComanda = widget.itensComanda;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: StylesDefault().backgroundColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: StylesDefault().backgroundColor,
        systemNavigationBarDividerColor: StylesDefault().backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Observer(builder: (context) {
        return Scaffold(
          backgroundColor: StylesDefault().backgroundColor,
          appBar: CustomAppBar(
            title: widget.title,
            onPressed: () {
              Modular.to.pop();
            },
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              left: 26.w,
              right: 26.w,
              bottom: 26.h,
            ),
            child: CustomButton(
              loading: controller.loading,
              onPressed: controller.comandaTransferencia == null &&
                      controller.busca == null &&
                      !controller.loading
                  ? controller.buscaComandaTransferencia
                  : controller.transfereItens,
              caption: controller.comandaTransferencia == null &&
                      controller.busca == null &&
                      !controller.loading
                  ? 'Buscar comanda'
                  : 'Transferir',
              height: 37.h,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: ListView(
              children: <Widget>[
                Text(
                  'Para qual comanda você\n'
                  'quer transferir?',
                  style: StylesDefault().fontNunitoSemiBold(
                    color: StylesDefault().secondaryColor,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomInput(
                  placeholder: 'Número da comanda',
                  controller: controller.textEditingControllerComanda,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => {},
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  focusNode: controller.focusNodeComanda,
                  textStyle: StylesDefault().fontNunitoSemiBold(
                    color: StylesDefault().secondaryColor,
                    fontSize: 32.sp,
                  ),
                  onChanged: (_) {
                    controller.busca = null;
                    controller.comandaTransferencia = null;
                  },
                ),
                Visibility(
                  visible: controller.comandaTransferencia == null &&
                      controller.busca != null &&
                      !controller.loading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40.h),
                      Text(
                        'Essa comanda não está\n'
                        'aberta, complemente se\n'
                        'necessário',
                        style: StylesDefault().fontNunitoSemiBold(
                          color: StylesDefault().secondaryColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomInput(
                        placeholder: 'Descrição da comanda',
                        controller:
                            controller.textEditingControllerDescricaoComanda,
                        textInputAction: TextInputAction.next,
                        isUpperCase: true,
                        onFieldSubmitted: (_) =>
                            controller.focusNodeTotalPessoas.requestFocus(),
                        keyboardType: TextInputType.text,
                        textStyle: StylesDefault().fontNunitoSemiBold(
                          color: StylesDefault().secondaryColor,
                          fontSize: 18.sp,
                        ),
                        focusNode: controller.focusNodeDescricao,
                      ),
                      SizedBox(height: 60.h),
                      CustomInput(
                        placeholder: 'Número de pessoas da mesa',
                        controller:
                            controller.textEditingControllerPessoasComanda,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => {},
                        textStyle: StylesDefault().fontNunitoSemiBold(
                          color: StylesDefault().secondaryColor,
                          fontSize: 18.sp,
                        ),
                        focusNode: controller.focusNodeTotalPessoas,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
