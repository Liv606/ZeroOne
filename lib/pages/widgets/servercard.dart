import 'package:flutter/material.dart';
import 'package:myhomemqtt/helpers/tabserver.dart';
import 'package:myhomemqtt/pages/cadserver.dart';
import 'package:myhomemqtt/pages/listdevices.dart';

class ServerCard extends StatefulWidget {
  final Server server;
  final Function refreshServer;

  const ServerCard(this.server, this.refreshServer, {super.key});

  @override
  ServerCardState createState() => ServerCardState();
}

class ServerCardState extends State<ServerCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.server.nomeserver ?? "Sem nome",
                              style: const TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Image.asset('lib/images/mosquitto.png'),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Text(
                              'Status${widget.server.status}',
                              style: const TextStyle(fontSize: 12.0),
                            ),
                          ]))),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListDevices(server: widget.server)),
        );
      },
      onLongPress: () async {
        await longPress(context);
      },
    );
  }

  Future<void> longPress(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ServerEdit(server: widget.server)),
    );
    await widget.refreshServer();
  }
}
