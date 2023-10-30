import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:myhomemqtt/helpers/tabdevices.dart';
import 'package:myhomemqtt/helpers/tabparametro.dart';
import 'package:myhomemqtt/helpers/tabserver.dart';
import 'package:myhomemqtt/mobx/devices.dart';
import 'package:myhomemqtt/mobx/mqtt.dart';
import 'package:myhomemqtt/mobx/servers.dart';
//import 'package:myhomemqtt/pages/listdevices.dart';
import 'package:myhomemqtt/pages/listservers.dart';

void main() {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<TabParametroHelper>(TabParametroHelper());
  getIt.registerSingleton<TabServerHelper>(TabServerHelper());
  getIt.registerSingleton<TabDeviceHelper>(TabDeviceHelper());
  getIt.registerSingleton<ServerModel>(ServerModel());
  getIt.registerSingleton<DeviceModel>(DeviceModel());
  getIt.registerSingleton<mqttclass>(mqttclass());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //inicializa();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'myHomeMQTT',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: FutureBuilder<Widget>(
          future: inicializa(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'lib/images/icon1024x1024.png',
                      fit: BoxFit.cover,
                      height: 1024,
                      width: 1024,
                    ),
                    // you can replace
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                      strokeWidth: 0.7,
                    ),
                  ],
                ),
              );
            } else {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                      'Houve um problema na execução da inicialização do app'),
                );
              } else {
                return snapshot.data!;
              }
            }
          },
        ));
  }
}

Future<Widget> inicializa() async {
  final TabParametroHelper param = GetIt.I.get<TabParametroHelper>();
  final TabServerHelper hserver = GetIt.I.get<TabServerHelper>();
  final TabDeviceHelper hdevice = GetIt.I.get<TabDeviceHelper>();
  await param.validarParamentros();
  var s = await hserver.getid(0);
  // print(s.toString());
  if (s.id == -1) {
    hserver.saveServer(
        Server(0, 'myHome', '10.0.60.4', '1883', 'mqtt', 'mqtt', 'OK'));
  }
  var d = await hdevice.getid('VARANDA');
  // print(d.toString());
  if (d.id == -1) {
    await hdevice.saveDevice(Device(
        0,
        0,
        'VARANDA',
        'cliente2/pinR1cmd',
        'liga',
        'desliga',
        '14',
        '4294961920',
        '4292072403',
        'DIRETO',
        '0',
        'desliga'));
    await hdevice.saveDevice(Device(
        1,
        0,
        'QUINTAL',
        'cliente2/pinR2cmd',
        'liga',
        'desliga',
        '14',
        '4294965248',
        '4292072403',
        'DIRETO',
        '0',
        'desliga'));
    await hdevice.saveDevice(Device(2, 0, 'PISCINA', 'piscina/pinR2cmd', 'liga',
        'desliga', '0', '4294963712', '4292072403', 'DIRETO', '0', 'desliga'));
    await hdevice.saveDevice(Device(3, 0, 'MESA RODRIGO', 'mesaro/R1', 'liga',
        'desliga', '8', '4294959872', '4292072403', 'GRUPO3', '0', 'liga'));
    await hdevice.saveDevice(Device(
        4,
        0,
        'MESA RO Troca Cor',
        'mesaro/R2',
        'liga',
        'desliga',
        '12',
        '4294944000',
        '4292072403',
        'GRUPO3',
        '0',
        'desliga'));
    await hdevice.saveDevice(Device(
        5,
        0,
        'Churrasqueira',
        'cmnd/tasmota_D4A2E2/Power1',
        'ON',
        'OFF',
        '9',
        '4294944000',
        '4292072403',
        'HASS',
        '0',
        'OFF'));
    await hdevice.saveDevice(Device(
        6,
        0,
        'Temperatura',
        'tele/tasmota_D4A2E2/SENSOR',
        '00',
        '11',
        '16',
        '4294944000',
        '4292072403',
        'HASS',
        '1',
        '{"Time":"2021-04-01T18:15:52","DHT11":{"Temperature":27.8,"Humidity":32.0,"DewPoint":9.6},"TempUnit":"C"}'));
  }
  return ListServers();
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'MQTT Home center',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/