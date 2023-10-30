import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mobx/mobx.dart';
import 'package:myhomemqtt/helpers/parametros.dart';
import 'package:myhomemqtt/helpers/tabdevices.dart';
import 'package:myhomemqtt/helpers/tabserver.dart';
import 'package:myhomemqtt/mobx/devices.dart';

part 'mqtt.g.dart';

// ignore: camel_case_types, library_private_types_in_public_api
class mqttclass = _mqttclassBase with _$mqttclass;

// ignore: camel_case_types
abstract class _mqttclassBase with Store {
  MqttServerClient client = MqttServerClient('', 'myHomeMqttCliente');
  final TabServerHelper hserver = GetIt.I.get<TabServerHelper>();
  final DeviceModel items = GetIt.I.get<DeviceModel>();
  final TabDeviceHelper tb = TabDeviceHelper();

  Future<bool> setMQTT(
      String ipServer, String username, String password, List ldevices) async {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    client = MqttServerClient(ipServer, 'myHMC$randomNumber');
    client.logging(on: false);
    client.getConnectMessage(username, password);
    client.setProtocolV311();
    client.keepAlivePeriod = 20;
    client.autoReconnect = true;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    await client.connect(username, password);
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      registerTopics(ldevices);
      setListen();
      await hserver.updateStatus(items.serverid!, 'CONNECT');
      return true;
    } else {
      await hserver.updateStatus(items.serverid!, 'ERROR');
      return false;
    }
  }

  void setListen() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      for (var e in c) {
        var recMess = e.payload as MqttPublishMessage;
        var pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        tb.getidTopic(e.topic).then((value) {
          value.lastPayload = pt;
          tb.updateDevice(value.id, value);
          items.setDevice(value);
        });
      }
    });
  }

  void registerTopics(ldevices) {
    for (var e in ldevices) {
      client.subscribe(e.topic, MqttQos.atLeastOnce);
    }
  }

  void publicar(String topic, String newpayload) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(newpayload);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  void onConnected() async {
    items.setIsLoading(STATE_TELA.SUCESS);
    await hserver.updateStatus(items.serverid!, 'CONNECT');
  }

  void onDisconnected() async {
    await hserver.updateStatus(items.serverid!, 'DISCONNECT');
  }

  void onSubscribed(String topic) {
    //print('confirmed for topic $topic');
  }

  @observable
  String? msg;
  @action
  setMsg(String value) => msg = value;
}
