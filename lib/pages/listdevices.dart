import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:myhomemqtt/helpers/parametros.dart';
import 'package:myhomemqtt/helpers/tabdevices.dart';
import 'package:myhomemqtt/helpers/tabserver.dart';
import 'package:myhomemqtt/mobx/devices.dart';
import 'package:myhomemqtt/mobx/mqtt.dart';
import 'package:myhomemqtt/pages/caddevice.dart';
import 'package:myhomemqtt/pages/widgets/devicecard.dart';
import 'package:myhomemqtt/pages/widgets/devicecardtipo1.dart';
import 'package:myhomemqtt/widgets/search_edit.dart';
import 'package:myhomemqtt/styles.dart';

@immutable
class ListDevices extends StatefulWidget {
  final Server server;

  const ListDevices({required this.server, super.key});

  @override
  State<ListDevices> createState() => _ListDevicesState();
}

class _ListDevicesState extends State<ListDevices> {
  final _ctrpesquisa = TextEditingController();

  final DeviceModel items = GetIt.I.get<DeviceModel>();
  final mqttclass mqtt = GetIt.I.get<mqttclass>();

  @override
  void initState() {
    inicializa();
    super.initState();
  }

  @override
  void dispose() {
    mqtt.client.disconnect();
    super.dispose();
  }

  void inicializa() async {
    items.setPagina(0);
    items.setIsLoading(STATE_TELA.LOADING);
    items.setServerid(widget.server.id!);
    await items.loadingDevices();
    final ret = await mqtt.setMQTT(widget.server.ip!, widget.server.username!,
        widget.server.password!, items.listaDevices);
    if (ret) {
      items.setIsLoading(STATE_TELA.SUCESS);
    } else {
      items.setIsLoading(STATE_TELA.ERROR);
    }
  }

  void filtra(value) async {
    await items.filtraDevice(query: value);
  }

  void refreshDevices() async {
    inicializa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Column(
          children: [Text('Lista de Devices')],
        )),
        floatingActionButton: FloatingActionButton(
          heroTag: 'tagheronewgrp',
          onPressed: () async {
            final g = Device(-1, widget.server.id!, '', '', 'liga', 'desliga',
                '', '', '', '', '0', '');
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => DeviceEdit(device: g)));
            refreshDevices();
          },
          child: const Icon(Icons.add),
        ),
        body: Observer(builder: (_) {
          if (items.isloading == STATE_TELA.LOADING) {
            return const LinearProgressIndicator();
          }
          if (items.isloading == STATE_TELA.ERROR) {
            return const Center(
              child:
                  Text('Problema na Inicialização', style: Styles.textoError),
            );
          } else {
            return Column(
              children: [
                searchEditField(
                    searchController: _ctrpesquisa, procPesquisa: filtra),
                Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        children:
                            List.generate(items.listaDevices.length, (index) {
                          return Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: items.listaDevices[index].tipo == '0'
                                      ? DeviceCard(items.listaDevices[index],
                                          refreshDevices)
                                      : DeviceCard1(
                                          items.listaDevices[index])));
                        }))),
              ],
            );
          }
        }));
  }
}
