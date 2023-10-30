// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servers.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServerModel on _ServerModelBase, Store {
  late final _$isloadingAtom =
      Atom(name: '_ServerModelBase.isloading', context: context);

  @override
  STATE_TELA? get isloading {
    _$isloadingAtom.reportRead();
    return super.isloading;
  }

  @override
  set isloading(STATE_TELA? value) {
    _$isloadingAtom.reportWrite(value, super.isloading, () {
      super.isloading = value;
    });
  }

  late final _$paginaAtom =
      Atom(name: '_ServerModelBase.pagina', context: context);

  @override
  int? get pagina {
    _$paginaAtom.reportRead();
    return super.pagina;
  }

  @override
  set pagina(int? value) {
    _$paginaAtom.reportWrite(value, super.pagina, () {
      super.pagina = value;
    });
  }

  late final _$edtServerAtom =
      Atom(name: '_ServerModelBase.edtServer', context: context);

  @override
  String? get edtServer {
    _$edtServerAtom.reportRead();
    return super.edtServer;
  }

  @override
  set edtServer(String? value) {
    _$edtServerAtom.reportWrite(value, super.edtServer, () {
      super.edtServer = value;
    });
  }

  late final _$listaServersAtom =
      Atom(name: '_ServerModelBase.listaServers', context: context);

  @override
  ObservableList<Server> get listaServers {
    _$listaServersAtom.reportRead();
    return super.listaServers;
  }

  @override
  set listaServers(ObservableList<Server> value) {
    _$listaServersAtom.reportWrite(value, super.listaServers, () {
      super.listaServers = value;
    });
  }

  late final _$loadingServersAsyncAction =
      AsyncAction('_ServerModelBase.loadingServers', context: context);

  @override
  Future<void> loadingServers() {
    return _$loadingServersAsyncAction.run(() => super.loadingServers());
  }

  late final _$_ServerModelBaseActionController =
      ActionController(name: '_ServerModelBase', context: context);

  @override
  dynamic setIsLoading(STATE_TELA value) {
    final _$actionInfo = _$_ServerModelBaseActionController.startAction(
        name: '_ServerModelBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_ServerModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPagina(int value) {
    final _$actionInfo = _$_ServerModelBaseActionController.startAction(
        name: '_ServerModelBase.setPagina');
    try {
      return super.setPagina(value);
    } finally {
      _$_ServerModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEdtServer(String value) {
    final _$actionInfo = _$_ServerModelBaseActionController.startAction(
        name: '_ServerModelBase.setEdtServer');
    try {
      return super.setEdtServer(value);
    } finally {
      _$_ServerModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListaServers(List<Server> value) {
    final _$actionInfo = _$_ServerModelBaseActionController.startAction(
        name: '_ServerModelBase.setListaServers');
    try {
      return super.setListaServers(value);
    } finally {
      _$_ServerModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isloading: ${isloading},
pagina: ${pagina},
edtServer: ${edtServer},
listaServers: ${listaServers}
    ''';
  }
}
