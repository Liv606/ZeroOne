import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myhomemqtt/helpers/tabdevices.dart';

class DeviceCard1 extends StatefulWidget {
  final Device device;

  const DeviceCard1(this.device, {super.key});

  @override
  DeviceCard1State createState() => DeviceCard1State();
}

class DeviceCard1State extends State<DeviceCard1> {
  @override
  Widget build(BuildContext context) {
    String pl = widget.device.lastPayload;
    final j = jsonDecode(pl);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: <Widget>[
            /* Container(
              width: 80.0,
              height: 80.0,
              child: FutureBuilder<Uint8List>(
                future: _getImageProduct(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting &&
                      snapshot.hasData &&
                      snapshot.data.isNotEmpty) {
                    return Image.memory(snapshot.data);
                  } else {
                    return Image.asset("image/productdefault.png");
                  }
                },
              ),
            ),*/
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.device.nomedevice,
                            style: const TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Grupo ${widget.device.nomegrupo}',
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            'Temperatura ${j['DHT11']['Temperature']}',
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            'Humidate ${j['DHT11']['Humidity']}',
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            'Ultima atualização {$j[\'Time\']}',
                            style: const TextStyle(fontSize: 12.0),
                          )
                        ]))),
            IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.red,
                ),
                onPressed: () {
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerTabs(widget.produto)),
                  );*/
                })
          ],
        ),
      ),
    );
  }
}
