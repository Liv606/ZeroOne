// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mqtt.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$mqttclass on _mqttclassBase, Store {
  late final _$msgAtom = Atom(name: '_mqttclassBase.msg', context: context);

  @override
  String? get msg {
    _$msgAtom.reportRead();
    return super.msg;
  }

  @override
  set msg(String? value) {
    _$msgAtom.reportWrite(value, super.msg, () {
      super.msg = value;
    });
  }

  late final _$_mqttclassBaseActionController =
      ActionController(name: '_mqttclassBase', context: context);

  @override
  dynamic setMsg(String value) {
    final _$actionInfo = _$_mqttclassBaseActionController.startAction(
        name: '_mqttclassBase.setMsg');
    try {
      return super.setMsg(value);
    } finally {
      _$_mqttclassBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
msg: ${msg}
    ''';
  }
}
