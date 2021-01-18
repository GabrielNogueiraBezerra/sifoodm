import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/features/styles/styles_default.dart';
import '../../../../widgets/custom_input_search.dart';
import '../../../../widgets/custom_not_found.dart';
import '../../widgets/custom_app_bar.dart';
import 'busca_controller.dart';

class BuscaPage extends StatefulWidget {
  const BuscaPage({Key key}) : super(key: key);

  @override
  _BuscaPageState createState() => _BuscaPageState();
}

class _BuscaPageState extends ModularState<BuscaPage, BuscaController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              MediaQuery.of(Modular.navigatorKey.currentContext).size.height *
                  0.08),
          child: Observer(builder: (context) {
            return CustomAppBar(
              onPressed: controller.comandaController.onPressedBack,
              onTap: controller.comandaController.onTapEditarComanda,
              title:
                  'Comanda ${controller.comandaController.comanda?.formatConta ?? ''}',
              subtitle: '${controller.comandaController.comanda.descMesa}',
            );
          }),
        ),
        backgroundColor: StylesDefault().backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 37.w,
                  ),
                  child: CustomInputSearch(
                    focusNode: controller.focusBusca,
                    placeholder: 'Buscar item por nome',
                    controller: controller.textEditingControllerPesquisa,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) => null,
                    onChanged: controller.onFieldSubmittedPesquisa,
                    onPressedSuffix: controller.clearDataTextPesquisa,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Expanded(
                  child: PageView(
                    controller: controller.comandaController.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      categorias,
                      categoriasProduto,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get descricaoBuscaProduto {
    var descricao = '';

    if (controller.secao != null) {
      descricao = '${controller.secao?.nomeSec ?? 0}';
    } else {
      if (controller.busca != null) {
        descricao =
            '${controller.page * 10 > controller.busca["length"] ? controller.busca["length"] : controller.page * 10} resultados encontrados de ${controller.busca["length"]}';
      }
    }
    if (descricao.isEmpty) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: controller.onChangeTabCategorias,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.chevron_left),
                SizedBox(width: 10.w),
                Text(
                  descricao,
                  style: StylesDefault().fontNunitoBold(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget get categoriasProduto => Observer(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              descricaoBuscaProduto,
              SizedBox(
                height: 15.w,
              ),
              Expanded(
                child: listaProdutos,
              ),
            ],
          );
        },
      );

  Widget get listaProdutos {
    if (!controller.loading) {
      var itemCount = 1;

      if (controller.busca != null) {
        if (controller.produtos != null) {
          itemCount += controller.produtos.length;

          if (controller.busca["count"] > controller.page) {
            itemCount++;
          }
        }
      }

      if (itemCount <= 1) {
        return RefreshIndicator(
          onRefresh: () async {
            await controller.buscaProdutos();
          },
          backgroundColor: StylesDefault().secondaryColor,
          child: ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            controller: controller.scrollControllerProdutos,
            separatorBuilder: (context, index) => index < itemCount - 2
                ? Divider(color: Colors.grey)
                : Container(),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return CustomNotFound(
                descricao: 'Nenhum produto cadastrado até\n'
                    'o momento. Assim que cadastrar aparecerão\n'
                    'nesta tela.',
              );
            },
          ),
        );
      } else {
        return Observer(builder: (context) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.buscaProdutos();
            },
            backgroundColor: StylesDefault().secondaryColor,
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              controller: controller.scrollControllerProdutos,
              separatorBuilder: (_, __) => Divider(color: Colors.grey),
              itemCount: controller.busca["count"] > controller.page
                  ? controller.produtos.length + 1
                  : controller.produtos.length,
              itemBuilder: (context, index) {
                if (index == controller.produtos.length) {
                  if (controller.busca["count"] > controller.page) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .08,
                      ),
                      child: Container(
                        color: StylesDefault().backgroundColor,
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                            width: MediaQuery.of(context).size.height * 0.02,
                            child: CircularProgressIndicator(
                              backgroundColor: StylesDefault().secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                    );
                  }
                } else {
                  return controller.produtos.elementAt(index).item(
                        onTap: () {
                          controller.focusBusca.unfocus();
                          controller.onTapInsereProduto(
                            produto: controller.produtos.elementAt(index),
                          );
                        },
                        context: context,
                      );
                }
              },
            ),
          );
        });
      }
    } else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: StylesDefault().secondaryColor,
        ),
      );
    }
  }

  Widget get categorias => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .08,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Categorias',
                style: StylesDefault().fontNunitoBold(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Observer(
            builder: (context) {
              return Expanded(
                child: listaCategorias,
              );
            },
          ),
        ],
      );

  Widget get listaCategorias {
    if (!controller.appController.loading) {
      var itemCount = 1;
      if (controller.appController.secoes != null) {
        itemCount += controller.appController.secoes.length;
      }

      return RefreshIndicator(
        onRefresh: () async {
          await controller.appController.buscaSecoes();
        },
        backgroundColor: StylesDefault().secondaryColor,
        child: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(),
          separatorBuilder: (_, __) => Divider(color: Colors.grey),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (itemCount == 1) {
              if (controller.appController.secoes != null) {
                return CustomNotFound(
                  descricao: 'Nenhuma seção cadastrada no\n'
                      'momento. Assim que as seções forem\n'
                      'cadastradas aparecerão nessa mesma tela.',
                );
              } else {
                return CustomNotFound(
                  descricao: 'Não foi possível carregar os \n'
                      'itens da lista, verifique a conexão\n'
                      'com internet e tente novamente',
                );
              }
            } else {
              if (index < itemCount - 1) {
                return controller.appController.secoes.elementAt(index).item(
                      onTap: () {
                        controller.changeTabCategoriaProduto(
                          controller.appController.secoes.elementAt(index),
                        );
                      },
                      context: context,
                    );
              } else {
                return Container();
              }
            }
          },
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: StylesDefault().secondaryColor,
        ),
      );
    }
  }
}
