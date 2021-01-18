import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/features/styles/styles_default.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/direitos_reservados.dart';
import '../../widgets/custom_input_label.dart';
import 'nova_comanda_controller.dart';

class NovaComandaPage extends StatefulWidget {
  final String title;
  const NovaComandaPage({Key key, this.title = "Lançar Comanda"})
      : super(key: key);

  @override
  _NovaComandaPageState createState() => _NovaComandaPageState();
}

class _NovaComandaPageState
    extends ModularState<NovaComandaPage, NovaComandaController> {
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
              child: Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 37.w),
                        child: Form(
                          key: controller.form,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CustomInputLabel(
                                title: 'Informe o número da comanda',
                                placeholder: '--',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller:
                                    controller.textEditingControllerComanda,
                                textInputAction: TextInputAction.done,
                                isUpperCase: true,
                                validator: (value) {
                                  if (value == null) {
                                    return "Informe a comanda.";
                                  }
                                  if (value.trim() == "") {
                                    return "Informe a comanda.";
                                  }

                                  return null;
                                },
                                focusNode: controller.focusComanda,
                                onFieldSubmitted: null,
                              ),
                              CustomInputLabel(
                                title: 'Descrição da comanda',
                                placeholder: 'Ex: Cliente João da Silva',
                                keyboardType: TextInputType.text,
                                controller: controller
                                    .textEditingControllerDescricaoComanda,
                                textInputAction: TextInputAction.next,
                                isUpperCase: true,
                                validator: (value) => null,
                                focusNode: controller.focusDescricaoComanda,
                                onFieldSubmitted: (value) => controller
                                    .focusPessoasComanda
                                    .requestFocus(),
                              ),
                              CustomInputLabel(
                                title: 'Número de pessoas na mesa',
                                placeholder: '--',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller: controller
                                    .textEditingControllerPessoasComanda,
                                textInputAction: TextInputAction.done,
                                isUpperCase: true,
                                validator: (value) => null,
                                focusNode: controller.focusPessoasComanda,
                                onFieldSubmitted: (value) => null,
                              ),
                              Observer(builder: (context) {
                                return CustomButton(
                                  loading: controller.loading,
                                  caption: 'Continuar',
                                  onPressed: controller.onPressedNovaComanda,
                                  height: 37.h,
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    DireitosReservados(),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
