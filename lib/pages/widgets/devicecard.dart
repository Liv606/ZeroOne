import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:myhomemqtt/helpers/image_helper.dart';
import 'package:myhomemqtt/helpers/tabdevices.dart';
import 'package:myhomemqtt/mobx/mqtt.dart';
import 'package:myhomemqtt/pages/caddevice.dart';

class DeviceCard extends StatefulWidget {
  final Device device;
  final Function refreshDevices;

  const DeviceCard(this.device, this.refreshDevices, {super.key});

  @override
  DeviceCardState createState() => DeviceCardState();
}

class DeviceCardState extends State<DeviceCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.device.nomedevice,
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            widget.device.lastPayload == widget.device.valoron
                                ? SvgPicture.string(
                                    getImageSVG(widget.device.imagem),
                                    width:
                                        60, // Defina o tamanho desejado para a imagem SVG
                                    height: 60,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.amber, BlendMode.srcATop))
                                : SvgPicture.string(
                                    getImageSVG(widget.device.imagem),
                                    width:
                                        60, // Defina o tamanho desejado para a imagem SVG
                                    height: 60,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.grey, BlendMode.srcATop))
                          ]))),
            ],
          ),
        ),
      ),
      onTap: () {
        mudaStatus(widget.device);
        // ShowDialog(context);
      },
      onLongPress: () async {
        await longpress(context);
      },
    );
  }

  Future<void> longpress(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DeviceEdit(
                device: widget.device,
              )),
    );
    await widget.refreshDevices();
  }
}

void mudaStatus(device) async {
  final mqttclass mqtt = GetIt.I.get<mqttclass>();
  final newDevice = device;
  newDevice.lastPayload = device.lastPayload == newDevice.valoron
      ? newDevice.valoroff
      : newDevice.valoron;
  mqtt.publicar(device.topic, newDevice.lastPayload);
}
