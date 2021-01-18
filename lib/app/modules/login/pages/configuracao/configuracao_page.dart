import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/features/styles/styles_default.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_input.dart';
import 'configuracao_controller.dart';

class ConfiguracaoPage extends StatefulWidget {
  final String title;
  const ConfiguracaoPage({Key key, this.title = "Configurações"}) : super(key: key);

  @override
  _ConfiguracaoPageState createState() => _ConfiguracaoPageState();
}

class _ConfiguracaoPageState extends ModularState<ConfiguracaoPage, ConfiguracaoController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: StylesDefault().backgroundColor,
        statusBarBrightness: Theme.of(context).platform == TargetPlatform.android ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: StylesDefault().backgroundColor,
        systemNavigationBarDividerColor: StylesDefault().primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: StylesDefault().backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 192.82.w,
                    top: -191.h,
                    child: Hero(
                      tag: 'imgFood1',
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(90 / 360),
                        child: Image.asset(
                          'assets/images/decoration/login_img.png',
                          height: 447.h,
                          width: 482.06.w,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 345.47.h,
                    left: -191.18.w,
                    child: Hero(
                      tag: 'imgFood2',
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(90 / 360),
                        child: Image.asset(
                          'assets/images/decoration/login_img.png',
                          height: 447.h,
                          width: 482.06.w,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85.h,
                    left: 32.19.h,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: controller.onPressedBack,
                          icon: Icon(
                            Icons.chevron_left,
                            color: StylesDefault().secondaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 34.28.w,
                        ),
                        Text(
                          widget.title,
                          style: StylesDefault().fontNunito(
                            fontSize: 20.sp,
                            color: StylesDefault().secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 194.h,
                    left: 28.w,
                    child: formulario,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get formulario => Container(
        height: 320.h,
        width: 304.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(54)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 50.h,
            horizontal: 27.5.w,
          ),
          child: Form(
            key: controller.form,
            child: LayoutBuilder(builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: Observer(builder: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomInput(
                          placeholder: "IP ou HOST de Conexão",
                          controller: controller.textEditingControllerHost,
                          isUpperCase: true,
                          validator: (value) {
                            if (value == null) {
                              return "Preencha o HOST.";
                            }

                            if (value.trim() == '') {
                              return "Preencha o HOST.";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: controller.focusHost,
                          onFieldSubmitted: (_) => controller.focusPorta.requestFocus(),
                        ),
                        CustomInput(
                          placeholder: "Porta",
                          keyboardType: TextInputType.number,
                          controller: controller.textEditingControllerPorta,
                          validator: (value) {
                            if (value == null) {
                              return "Preencha a porta.";
                            }

                            if (value.trim() == '') {
                              return "Preencha a porta.";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          focusNode: controller.focusPorta,
                          onFieldSubmitted: (_) => null,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: <Widget>[
                            CustomButton(
                              loading: controller.loading,
                              onPressed: controller.onTapSalvaConfiguracoes,
                              caption: 'Salvar Configurações',
                              height: 37.h,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Visibility(
                              visible: Theme.of(context).platform == TargetPlatform.android,
                              child: Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: controller.onTapBuscaConfigurations,
                                  child: Ink(
                                    color: Colors.white,
                                    height: 40.h,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                        'Buscar Configurações',
                                        textAlign: TextAlign.center,
                                        style: StylesDefault().fontNunito(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              );
            }),
          ),
        ),
      );
}
