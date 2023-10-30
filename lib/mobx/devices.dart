import 'package:mobx/mobx.dart';
import 'package:myhomemqtt/helpers/parametros.dart';
import 'package:myhomemqtt/helpers/tabdevices.dart';

part 'devices.g.dart';

// ignore: library_private_types_in_public_api
class DeviceModel = _DeviceModelBase with _$DeviceModel;

abstract class _DeviceModelBase with Store {
  @observable
  int? serverid;
  @action
  setServerid(int value) => serverid = value;

  @observable
  STATE_TELA? isloading;
  @action
  setIsLoading(STATE_TELA value) => isloading = value;

  @observable
  int? pagina;
  @action
  setPagina(int value) => pagina = value;

  @observable
  String? edtDevice;
  @action
  setEdtDevice(String value) {
    edtDevice = value;
    loadingDevices();
  }

  @observable
  ObservableList<Device> listaDevices = ObservableList<Device>().asObservable();
  @action
  void setListaDevices(List<Device> value) {
    listaDevices = value.asObservable();
  }

  @action
  void setDevice(Device device) {
    int index = listaDevices.indexWhere((element) => element.id == device.id);
    listaDevices[index] = device;
    // print('setDevice->$device');
  }

  @action
  Future<void> loadingDevices() async {
    try {
      setIsLoading(STATE_TELA.LOADING);
      await _carregaServers();
      setIsLoading(STATE_TELA.SUCESS);
    } catch (e) {
      setIsLoading(STATE_TELA.ERROR);
      // print(e.toString());
    }
  }

  Future<void> _carregaServers() async {
    TabDeviceHelper helper = TabDeviceHelper();
    List<Device> lista = await helper.getDevice();
    //setListaDevices(lista);
    setListaDevices(
        lista.where((element) => element.idserver == serverid).toList());
  }

  Future<void> filtraDevice({required String query}) async {
    await _carregaServers();
    setListaDevices(listaDevices
        .where((element) =>
            element.nomedevice.toUpperCase().contains(query.toUpperCase()))
        .toList());
  }
}
