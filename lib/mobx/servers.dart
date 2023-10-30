// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import 'package:myhomemqtt/helpers/parametros.dart';
import 'package:myhomemqtt/helpers/tabserver.dart';

part 'servers.g.dart';

class ServerModel = _ServerModelBase with _$ServerModel;

abstract class _ServerModelBase with Store {
  @observable
  STATE_TELA? isloading;
  @action
  setIsLoading(STATE_TELA value) => isloading = value;

  @observable
  int? pagina;
  @action
  setPagina(int value) => pagina = value;

  @observable
  String? edtServer;
  @action
  setEdtServer(String value) {
    edtServer = value;
    loadingServers();
  }

  @observable
  ObservableList<Server> listaServers = ObservableList<Server>().asObservable();
  @action
  void setListaServers(List<Server> value) {
    listaServers = value.asObservable();
  }

  @action
  Future<void> loadingServers() async {
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
    TabServerHelper helper = TabServerHelper();
    List<Server> lista = await helper.getServer();
    setListaServers(lista);
    // print(lista);
  }

  Future<void> filtraDevice({required String query}) async {
    await _carregaServers();
    setListaServers(listaServers
        .where((element) =>
            element.nomeserver!.toUpperCase().contains(query.toUpperCase()))
        .toList());
  }
}
