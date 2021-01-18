import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/features/styles/styles_default.dart';
import '../../shared/models/hex_color.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_checkbox.dart';
import '../../shared/widgets/custom_input.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    controller.buscaConexao();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                    left: -301.7.w,
                    top: -191.h,
                    child: Hero(
                      tag: 'imgFood1',
                      child: Image.asset(
                        'assets/images/decoration/login_img.png',
                        height: 447.h,
                        width: 482.06.w,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 284.w,
                    top: 23.h,
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: controller.onTapGear,
                        borderRadius: BorderRadius.circular(50),
                        child: Ink(
                          height: 60.h,
                          width: 60.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/images/icons/gear.svg',
                              color: StylesDefault().secondaryColor,
                              width: 21.69.w,
                              height: 22.95.h,
                            ),
                            onPressed: controller.onTapGear,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 70.3.w,
                    top: 352.h,
                    child: Hero(
                      tag: 'imgFood2',
                      child: Image.asset(
                        'assets/images/decoration/login_img.png',
                        height: 447.h,
                        width: 482.06.w,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 145.w,
                    top: 66.67.h,
                    child: IgnorePointer(
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/images/logo/logo-login.png',
                          height: 100.19.h,
                          width: 69.41.w,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 28.w,
                    top: 184.h,
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
        height: 395.h,
        width: 304.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(54.w)),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Bem vindo!',
                              style: StylesDefault().fontNunito(fontSize: 20.sp, color: StylesDefault().secondaryColor),
                            ),
                            Text(
                              'Preencha os campos e efetue o login.',
                              style: StylesDefault().fontNunito(
                                fontSize: 14.sp,
                                color: HexColor('#666666'),
                              ),
                            ),
                          ],
                        ),
                        CustomInput(
                          placeholder: "Nome de usuário",
                          controller: controller.textEditingControllerNomeUsuario,
                          maxLength: 10,
                          isUpperCase: true,
                          validator: (value) {
                            if (value == null) {
                              return "Preencha o nome do usuário.";
                            }

                            if (value.trim() == '') {
                              return "Preencha o nome do usuário.";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: controller.focusUsuario,
                          onFieldSubmitted: (_) => controller.focusSenha.requestFocus(),
                        ),
                        CustomInput(
                          placeholder: "Senha",
                          isPassword: true,
                          controller: controller.textEditingControllerSenha,
                          maxLength: 12,
                          validator: (value) {
                            if (value == null) {
                              return "Preencha a senha.";
                            }

                            if (value.trim() == '') {
                              return "Preencha a senha.";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => null,
                          focusNode: controller.focusSenha,
                        ),
                        CustomCheckbox(
                          checked: controller.lembraCredenciais,
                          onTap: controller.changeCredenciais,
                          texto: 'Lembrar minhas credenciais',
                        ),
                        CustomButton(
                          loading: controller.loading,
                          onPressed: controller.loading ? () {} : controller.onTapLogin,
                          caption: 'Entrar',
                          height: 37.h,
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
