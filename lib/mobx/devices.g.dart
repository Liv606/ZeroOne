// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DeviceModel on _DeviceModelBase, Store {
  late final _$serveridAtom =
      Atom(name: '_DeviceModelBase.serverid', context: context);

  @override
  int? get serverid {
    _$serveridAtom.reportRead();
    return super.serverid;
  }

  @override
  set serverid(int? value) {
    _$serveridAtom.reportWrite(value, super.serverid, () {
      super.serverid = value;
    });
  }

  late final _$isloadingAtom =
      Atom(name: '_DeviceModelBase.isloading', context: context);

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
      Atom(name: '_DeviceModelBase.pagina', context: context);

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

  late final _$edtDeviceAtom =
      Atom(name: '_DeviceModelBase.edtDevice', context: context);

  @override
  String? get edtDevice {
    _$edtDeviceAtom.reportRead();
    return super.edtDevice;
  }

  @override
  set edtDevice(String? value) {
    _$edtDeviceAtom.reportWrite(value, super.edtDevice, () {
      super.edtDevice = value;
    });
  }

  late final _$listaDevicesAtom =
      Atom(name: '_DeviceModelBase.listaDevices', context: context);

  @override
  ObservableList<Device> get listaDevices {
    _$listaDevicesAtom.reportRead();
    return super.listaDevices;
  }

  @override
  set listaDevices(ObservableList<Device> value) {
    _$listaDevicesAtom.reportWrite(value, super.listaDevices, () {
      super.listaDevices = value;
    });
  }

  late final _$loadingDevicesAsyncAction =
      AsyncAction('_DeviceModelBase.loadingDevices', context: context);

  @override
  Future<void> loadingDevices() {
    return _$loadingDevicesAsyncAction.run(() => super.loadingDevices());
  }

  late final _$_DeviceModelBaseActionController =
      ActionController(name: '_DeviceModelBase', context: context);

  @override
  dynamic setServerid(int value) {
    final _$actionInfo = _$_DeviceModelBaseActionController.startAction(
        name: '_DeviceModelBase.setServerid');
    try {
      return super.setServerid(value);
    } finally {
      _$_DeviceModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsLoading(STATE_TELA value) {
    final _$actionInfo = _$_DeviceModelBaseActionController.startAction(
        name: '_DeviceModelBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_DeviceModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPagina(int value) {
    final _$actionInfo = _$_DeviceModelBaseActionController.startAction(
        name: '_DeviceModelBase.setPagina');
    try {
      return super.setPagina(value);
    } finally {
      _$_DeviceModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEdtDevice(String value) {
    final _$actionInfo = _$_DeviceModelBaseActionController.startAction(
        name: '_DeviceModelBase.setEdtDevice');
    try {
      return super.setEdtDevice(value);
    } finally {
      _$_DeviceModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListaDevices(List<Device> value) {
    final _$actionInfo = _$_DeviceModelBaseActionController.startAction(
        name: '_DeviceModelBase.setListaDevices');
    try {
      return super.setListaDevices(value);
    } finally {
      _$_DeviceModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDevice(Device device) {
    final _$actionInfo = _$_DeviceModelBaseActionController.startAction(
        name: '_DeviceModelBase.setDevice');
    try {
      return super.setDevice(device);
    } finally {
      _$_DeviceModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
serverid: ${serverid},
isloading: ${isloading},
pagina: ${pagina},
edtDevice: ${edtDevice},
listaDevices: ${listaDevices}
    ''';
  }
}
