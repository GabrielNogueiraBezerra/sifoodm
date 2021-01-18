import 'dart:convert';

import 'package:easy_udp/easy_udp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:udp/udp.dart';
import 'package:wifi_ip/wifi_ip.dart';

import '../../../../app_controller.dart';
import '../../../../shared/models/ip.dart';
import '../../../../shared/utils/utils.dart';
import 'widgets/custom_bottom_sheet_ips.dart';

part 'configuracao_controller.g.dart';

@Injectable()
class ConfiguracaoController = _ConfiguracaoControllerBase with _$ConfiguracaoController;

abstract class _ConfiguracaoControllerBase with Store implements Disposable {
  final AppController _appController = Modular.get<AppController>();

  TextEditingController textEditingControllerHost = TextEditingController();
  TextEditingController textEditingControllerPorta = TextEditingController();

  FocusNode focusHost = FocusNode();
  FocusNode focusPorta = FocusNode();

  int portaUDPServer = 8761;
  int portaUDPClient = 8763;

  @override
  void dispose() {
    textEditingControllerHost.dispose();
    textEditingControllerPorta.dispose();
    focusHost.dispose();
    focusPorta.dispose();
  }

  GlobalKey<FormState> form = GlobalKey<FormState>();

  @observable
  bool loading = false;

  @observable
  bool loadingServer = false;

  @observable
  bool loadingBuscaConfigurations = false;

  @action
  Future<void> onTapSalvaConfiguracoes() async {
    try {
      loading = true;
      if (form.currentState.validate()) {
        form.currentState.save();

        await _appController.storageConfigurations?.salvarConfiguracao(
          host: textEditingControllerHost.text.trim(),
          porta: textEditingControllerPorta.text.trim(),
        );

        loadingServer = true;

        await onPressedBack();
      }
      loading = false;
    } on Exception catch (e) {
      loading = false;
      Utils().showAlert(mensagem: e.toString());
    }
  }

  Future<void> startServer() async {
    dynamic ipAddress;
    var foundIp = false;
    try {
      ipAddress = await WifiIp.getWifiIp;
      ipAddress = ipAddress.ip;
      foundIp = true;
    } on Exception catch (_) {
      Utils().hideCustomProgressDialog();
      Utils().showAlert(mensagem: 'Não foi possivel buscar IP do dispositivo.');
      return;
    }

    final socket = await EasyUDPSocket.bind(ipAddress, portaUDPClient);

    var tentativas = 10;

    dynamic configurations;

    while (!loadingServer && tentativas > 0 && foundIp) {
      final datagram = await socket.receive(timeout: 1000);

      if (datagram == null) {
        tentativas--;
        continue;
      }

      loadingServer = true;

      configurations = json.decode(ascii.decode(datagram.data));
    }

    Utils().hideCustomProgressDialog();

    if (!loadingServer) {
      Utils().showAlert(mensagem: 'Não foi possível carregar informações do servidor.');
    } else {
      loadingServer = false;
      var ips = List<Ip>.from((configurations['ips']).map((e) => Ip.fromMap(e)));

      if (ips.length == 1) {
        var ip = ips.elementAt(0);
        await onTapIps(configurations['porta_server'].toString(), ip.ip);
      } else {
        await showModalBottomSheet(
          context: Modular.navigatorKey.currentState.overlay.context,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return CustomBottomSheetIps(
              ip: ips,
              onPressedIp: onTapIps,
              porta: configurations['porta_server'].toString(),
            );
          },
        );
      }
    }
  }

  @action
  Future<void> onTapIps(String porta, String ip) async {
    textEditingControllerHost.text = ip;
    textEditingControllerPorta.text = porta;

    Utils().showAlert(mensagem: 'Informações sincronizadas com sucesso.');

    loadingServer = false;
  }

  @action
  Future<void> onTapBuscaConfigurations() async {
    try {
      Utils().showCustomProgressDialog(title: "Por favor, aguarde enquanto consultamos os dados do servidor...");
      loadingBuscaConfigurations = true;

      // inicio o servidor de comunicação
      if (!loadingServer) {
        startServer();
      }

      // mando a requisição de informações
      var sender = await UDP.bind(Endpoint.any(port: Port(portaUDPClient)));

      await sender.send("SIFOODM".codeUnits, Endpoint.broadcast(port: Port(portaUDPServer)));

      loadingBuscaConfigurations = false;
    } on Exception catch (e) {
      loadingServer = true;
      loadingBuscaConfigurations = false;
      Utils().showAlert(mensagem: e.toString());
    }
  }

  Future<void> onPressedBack() async {
    loadingServer = true;
    Modular.to.pop();
  }

  _ConfiguracaoControllerBase() {
    if (_appController.storageConfigurations != null) {
      if (_appController.storageConfigurations.conexao != null) {
        textEditingControllerHost = TextEditingController(text: _appController.storageConfigurations.conexao.host);
        textEditingControllerPorta = TextEditingController(text: _appController.storageConfigurations.conexao.porta);
      }
    }
  }
}
