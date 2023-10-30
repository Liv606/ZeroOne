import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:myhomemqtt/helpers/image_helper.dart';
import 'package:myhomemqtt/helpers/tabdevices.dart';
import 'package:myhomemqtt/pages/listimage.dart';
import 'package:myhomemqtt/widgets/delete_button.dart';
import 'package:myhomemqtt/widgets/dialog_yesno.dart';
import 'package:myhomemqtt/widgets/edit_field.dart';
import 'package:myhomemqtt/widgets/select_tipo.dart';

class DeviceEdit extends StatefulWidget {
  final Device device;
  const DeviceEdit({required this.device, super.key});

  @override
  State<DeviceEdit> createState() => _DeviceEditState();
}

String validar(String? value) {
  return '';
}

class _DeviceEditState extends State<DeviceEdit> {
  TextEditingController cIdServer = TextEditingController();
  TextEditingController cNomedevice = TextEditingController();
  TextEditingController cTopic = TextEditingController();
  TextEditingController cValoron = TextEditingController();
  TextEditingController cValoroff = TextEditingController();
  TextEditingController cImage = TextEditingController();
  TextEditingController cColoron = TextEditingController();
  TextEditingController cColoroff = TextEditingController();
  TextEditingController cNomeGrupo = TextEditingController();
  TextEditingController cTipo = TextEditingController();
  TextEditingController cLastPayload = TextEditingController();
  int id = 0;
  String mensagem = '';
  final hdevice = GetIt.I.get<TabDeviceHelper>();

  Future<void> carregaDevices() async {
    cIdServer.text = widget.device.idserver.toString();
    cNomedevice.text = widget.device.nomedevice;
    cTopic.text = widget.device.topic;
    cValoron.text = widget.device.valoron;
    cValoroff.text = widget.device.valoroff;
    cImage.text = widget.device.imagem.isEmpty ? '14' : widget.device.imagem;
    cColoron.text = widget.device.coloron;
    cColoroff.text = widget.device.coloroff;
    cNomeGrupo.text = widget.device.nomegrupo;
    cTipo.text = widget.device.tipo;
    cLastPayload.text = widget.device.lastPayload;
    setState(() {});
  }

  @override
  void initState() {
    carregaDevices();

    super.initState();
  }

  Future<bool> salvaDevice() async {
    Device? dev;
    if (widget.device.id == -1) {
      int nextID = await hdevice.proximo();
      if (nextID > 0) {
        setState(() {
          widget.device.id = nextID;
        });
        dev = await hdevice.saveDevice(Device(
            widget.device.id,
            widget.device.idserver,
            cNomedevice.text,
            cTopic.text,
            cValoron.text,
            cValoroff.text,
            cImage.text,
            cColoron.text,
            cColoroff.text,
            cNomeGrupo.text,
            cTipo.text,
            cLastPayload.text));
      }
    } else {
      dev = await hdevice.updateDevice(
          widget.device.id,
          Device(
              widget.device.id,
              widget.device.idserver,
              cNomedevice.text,
              cTopic.text,
              cValoron.text,
              cValoroff.text,
              cImage.text,
              cColoron.text,
              cColoroff.text,
              cNomeGrupo.text,
              cTipo.text,
              cLastPayload.text));
    }
    return dev!.nomedevice.isNotEmpty;
  }

  Future<void> excluiDevice({required id}) async {
    final ret = await dialogAlertYesNo(context, 'Exclui device?');
    if (ret) {
      await hdevice.deleteDevice(id: widget.device.id);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  void setTipo(String c) async {
    setState(() {
      cTipo.text = c;
    });
  }

  void setImage(String index) {
    setState(() {
      cImage.text = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Device Editar'), actions: [
        IconButton(
            onPressed: () async {
              const Duration animDuration = Duration(milliseconds: 500);
              const Duration animDurationE = Duration(milliseconds: 2000);

              final ret = await salvaDevice();
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
              selectTipo(
                  valorInicial: widget.device.tipo.toString(),
                  setTipo: setTipo),
              const SizedBox(
                width: 10,
              ),
              const SizedBox(
                height: 8.0,
              ),
              editField(
                  hint: 'Device Name',
                  senha: false,
                  controller: cNomedevice,
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
                          hint: 'Valor ON',
                          senha: false,
                          controller: cValoron,
                          validador: validar)),
                  const SizedBox(
                    width: 8.0,
                  ),
                  SizedBox(
                      width: (largura / 2 - 20),
                      child: editField(
                          hint: 'Valor OFF',
                          senha: false,
                          controller: cValoroff,
                          validador: validar)),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              editField(
                  hint: 'Grupo',
                  senha: false,
                  controller: cNomeGrupo,
                  validador: validar),
              const SizedBox(
                height: 8.0,
              ),
              editField(
                  hint: 'Topic',
                  senha: false,
                  controller: cTopic,
                  validador: validar),
              const SizedBox(
                height: 8.0,
              ),
              //Text(cImage.text),
              InkWell(
                child: SvgPicture.string(
                  getImageSVG(cImage.text),
                  width: 100,
                  height: 100,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListImage(
                              setImage: setImage,
                            )),
                  );
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              deleteButton(id: widget.device.id, deleteFunction: excluiDevice),
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
