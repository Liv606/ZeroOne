import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:myhomemqtt/helpers/tabserver.dart';
import 'package:myhomemqtt/widgets/delete_button.dart';
import 'package:myhomemqtt/widgets/dialog_yesno.dart';
import 'package:myhomemqtt/widgets/edit_field.dart';

class ServerEdit extends StatefulWidget {
  final Server server;
  const ServerEdit({required this.server, super.key});

  @override
  State<ServerEdit> createState() => _ServerEditState();
}

String validar(String? value) {
  return '';
}

class _ServerEditState extends State<ServerEdit> {
  TextEditingController cIdServer = TextEditingController();
  TextEditingController cNomeServer = TextEditingController();
  TextEditingController cIP = TextEditingController();
  TextEditingController cPorta = TextEditingController();
  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cStatus = TextEditingController();
  int id = 0;
  String mensagem = '';
  final hServer = GetIt.I.get<TabServerHelper>();

  Future<void> carregaServers() async {
    cIdServer.text = widget.server.id.toString();
    cNomeServer.text = widget.server.nomeserver!;
    cIP.text = widget.server.ip!;
    cUsername.text = widget.server.username!;
    cPassword.text = widget.server.password!;
    cPorta.text = widget.server.porta!;
    cStatus.text = widget.server.status!;
    setState(() {});
  }

  @override
  void initState() {
    carregaServers();

    super.initState();
  }

  Future<bool> salvaServer() async {
    Server? ser;
    if (widget.server.id == -1) {
      int nextID = await hServer.proximo();
      if (nextID > 0) {
        setState(() {
          widget.server.id = nextID;
        });
        ser = await hServer.saveServer(Server(
            widget.server.id,
            cNomeServer.text,
            cIP.text,
            cPorta.text,
            cUsername.text,
            cPassword.text,
            cStatus.text));
      }
    } else {
      ser = await hServer.updateServer(
          widget.server.id!,
          Server(widget.server.id, cNomeServer.text, cIP.text, cPorta.text,
              cUsername.text, cPassword.text, cStatus.text));
    }
    return ser!.ip!.isNotEmpty;
  }

  Future<void> excluiServer({required id}) async {
    final ret = await dialogAlertYesNo(context, 'Exclui Server?');
    if (ret) {
      final i = await hServer.deleteServer(id: widget.server.id!);
      if (i < 0) {
        // ignore: use_build_context_synchronously
        await dialogAlertYesNo(context, 'Não foi possivel excluir Server');
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Server Editar'), actions: [
        IconButton(
            onPressed: () async {
              const Duration animDuration = Duration(milliseconds: 500);
              const Duration animDurationE = Duration(milliseconds: 2000);

              final ret = await salvaServer();
              if (ret) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Salvo com sucess'),
                  duration: animDuration,
                ));
                setState(() {});
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('problema na gravação'),
                    duration: animDurationE,
                    backgroundColor: Colors.red));
                setState(() {});
              }
            },
            icon: const Icon(Icons.check))
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(children: [
              const SizedBox(
                height: 10.0,
              ),
              editField(
                  hint: 'Server Name',
                  senha: false,
                  controller: cNomeServer,
                  validador: validar),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: (largura / 2 - 20),
                      child: editField(
                          hint: 'IP',
                          senha: false,
                          controller: cIP,
                          validador: validar)),
                  const SizedBox(
                    width: 8.0,
                  ),
                  SizedBox(
                      width: (largura / 2 - 20),
                      child: editField(
                          hint: 'Porta',
                          senha: false,
                          controller: cPorta,
                          validador: validar)),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              editField(
                  hint: 'Username',
                  senha: false,
                  controller: cUsername,
                  validador: validar),
              const SizedBox(
                height: 8.0,
              ),
              editField(
                  hint: 'Password',
                  senha: true,
                  controller: cPassword,
                  validador: validar),
              const SizedBox(
                height: 10.0,
              ),
              deleteButton(id: widget.server.id!, deleteFunction: excluiServer),
              const SizedBox(
                height: 8.0,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
