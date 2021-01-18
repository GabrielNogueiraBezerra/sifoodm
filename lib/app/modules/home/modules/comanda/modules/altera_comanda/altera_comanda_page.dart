import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/features/styles/styles_default.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../widgets/custom_input_label.dart';
import 'altera_comanda_controller.dart';

class AlteraComandaPage extends StatefulWidget {
  final String title;
  const AlteraComandaPage({Key key, this.title = "Editar Comanda"})
      : super(key: key);

  @override
  _AlteraComandaPageState createState() => _AlteraComandaPageState();
}

class _AlteraComandaPageState
    extends ModularState<AlteraComandaPage, AlteraComandaController> {
  @override
  void initState() {
    controller.preencheDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onPressedBack,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: StylesDefault().backgroundColor,
          statusBarBrightness:
              Theme.of(context).platform == TargetPlatform.android
                  ? Brightness.dark
                  : Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: StylesDefault().backgroundColor,
          systemNavigationBarDividerColor: StylesDefault().primaryColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: StylesDefault().backgroundColor,
          appBar: CustomAppBar(
            onPressed: controller.onPressedBack,
            title: widget.title,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    'assets/images/decoration/altera_comanda.png',
                    width: 190.27.w,
                    height: 189.49.h,
                  ),
                  Text(
                    'Sem problemas!',
                    style: StylesDefault().fontNunitoSemiBold(
                      fontSize: 21.sp,
                      color: StylesDefault().primaryColor,
                    ),
                  ),
                  Text(
                    'Faça as alterações que forem necessárias.',
                    style: StylesDefault().fontNunito(
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.08),
                    child: Form(
                      key: controller.form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          CustomInputLabel(
                            controller:
                                controller.textEditingControllerDescricao,
                            onFieldSubmitted: (value) {
                              controller.focusNumeroPessoas.requestFocus();
                            },
                            placeholder: 'ex: Cliente joão da Silva',
                            textInputAction: TextInputAction.next,
                            title: 'Descrição da comanda',
                            focusNode: controller.focusDescricao,
                            isUpperCase: true,
                            maxLength: 80,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 20.h),
                          CustomInputLabel(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller:
                                controller.textEditingControllerNumeroPessoas,
                            onFieldSubmitted: (value) => null,
                            placeholder: '--',
                            textInputAction: TextInputAction.done,
                            title: 'Número de pessoas',
                            focusNode: controller.focusNumeroPessoas,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 40.h),
                          Observer(builder: (context) {
                            return CustomButton(
                              onPressed: controller.onPressedSalvar,
                              caption: 'Salvar',
                              loading: controller.loading,
                              height: 37.h,
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
