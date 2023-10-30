import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:myhomemqtt/helpers/parametros.dart';
import 'package:myhomemqtt/helpers/tabserver.dart';
import 'package:myhomemqtt/mobx/servers.dart';
import 'package:myhomemqtt/pages/cadserver.dart';
import 'package:myhomemqtt/pages/widgets/servercard.dart';
import 'package:myhomemqtt/widgets/search_edit.dart';

@immutable
class ListServers extends StatelessWidget {
  ListServers({super.key});

  final _ctrpesquisa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ServerModel servers = GetIt.I.get<ServerModel>();
    servers.setPagina(0);
    servers.loadingServers();

    void filtra(value) async {
      await servers.filtraDevice(query: value);
    }

    void refreshDevices() async {
      await servers.loadingServers();
    }

    return Scaffold(
        appBar: AppBar(
            title: const Column(
          children: [Text('Lista de Servers')],
        )),
        floatingActionButton: FloatingActionButton(
          heroTag: 'tagheronewgrp',
          onPressed: () async {
            final g = Server(-1, '', '0.0.0.0', '1883', '', '', '');
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => ServerEdit(server: g)));
            refreshDevices();
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            searchEditField(
                searchController: _ctrpesquisa, procPesquisa: filtra),
            Expanded(
              child: Observer(builder: (_) {
                if (servers.isloading == STATE_TELA.LOADING) {
                  return const LinearProgressIndicator();
                }
                if (servers.isloading == STATE_TELA.ERROR) {
                  return const Center(
                    child: Text('Problema na consulta'),
                  );
                }
                return GridView.count(
                    crossAxisCount: 2,
                    children:
                        List.generate(servers.listaServers.length, (index) {
                      return Center(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ServerCard(servers.listaServers[index],
                                  refreshDevices)));
                    }));
              }),
            ),
          ],
        ));
  }
}
