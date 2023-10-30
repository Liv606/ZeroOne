import 'package:sqflite/sqflite.dart';
import 'local.dart';

class TabDeviceHelper {
  Database? _db;

  get conexao async {
    LocalHelper dblocal = LocalHelper();
    if (_db != null) {
      return _db;
    } else {
      _db = await dblocal.initDB();
      return _db;
    }
  }

  Future<Device> saveDevice(Device device) async {
    Database db = await conexao;
    await db.insert('tdevice', device.toMap());
    return device;
  }

  Future<Device> updateDevice(int id, Device device) async {
    Database db = await conexao;
    await db
        .update('tdevice', device.toMap(), where: "id = ?", whereArgs: [id]);
    return device;
  }

  Future<int> deleteDevice({required int id}) async {
    Database db = await conexao;
    return await db.delete('tdevice', where: 'id = ?', whereArgs: [id]);
  }

  Future<Device> getid(String nome) async {
    Database db = await conexao;
    List<Map> maps = await db.query('tdevice',
        columns: [
          'id',
          'nome_device',
          'topic',
          'valoron',
          'valoroff',
          'imagem',
          'coloron',
          'coloroff',
          'nomegrupo',
          'tipo',
          'lastPayload'
        ],
        where: "nome_device = ?",
        whereArgs: [nome]);
    if (maps.isNotEmpty) {
      return Device.fromMap(maps.first);
    } else {
      return Device(-1, 0, '', '', '', '', '', '', '', '', '', '');
    }
  }

  Future<Device> getidTopic(String topic) async {
    Database db = await conexao;
    List<Map> maps = await db.query('tdevice',
        columns: [
          'id',
          'nome_device',
          'topic',
          'valoron',
          'valoroff',
          'imagem',
          'coloron',
          'coloroff',
          'nomegrupo',
          'tipo',
          'lastPayload'
        ],
        where: "topic = ?",
        whereArgs: [topic]);
    if (maps.isNotEmpty) {
      return Device.fromMap(maps.first);
    } else {
      return Device(0, 0, '', '', '', '', '', '', '', '', '', '');
    }
  }

  Future<List<Device>> getDevice() async {
    Database db = await conexao;
    List listMap = await db.rawQuery("SELECT * FROM tdevice");
    List<Device> listDevice = [];
    for (Map m in listMap) {
      listDevice.add(Device.fromMap(m));
    }
    return listDevice;
  }

  Future<int> proximo() async {
    Database db = await conexao;
    List listMap = await db.rawQuery("SELECT max(id) as conta FROM tdevice");
    int proximo = listMap.first['conta'];
    return (proximo + 1);
  }

  Future close() async {
    Database db = await conexao;
    db.close();
  }
}

class Device {
  int id = 0;
  int idserver = 0;
  String nomedevice = '';
  String topic = '';
  String valoron = 'liga';
  String valoroff = 'desliga';
  String imagem = '14';
  String coloron = 'amber';
  String coloroff = 'gray';
  String nomegrupo = '';
  String tipo = '1';
  String lastPayload = '';

  Device(
      this.id,
      this.idserver,
      this.nomedevice,
      this.topic,
      this.valoron,
      this.valoroff,
      this.imagem,
      this.coloron,
      this.coloroff,
      this.nomegrupo,
      this.tipo,
      this.lastPayload);

  Device.fromMap(Map map) {
    id = map['id'] ?? 0;
    idserver = map['idserver'] ?? 0;
    nomedevice = map['nome_device'] ?? '';
    topic = map['topic'] ?? '';
    valoron = map['valoron'] ?? '';
    valoroff = map['valoroff'] ?? '';
    imagem = map['imagem'] ?? '14';
    coloron = map['coloron'] ?? '';
    coloroff = map['coloroff'] ?? '';
    nomegrupo = map['nomegrupo'] ?? '';
    tipo = map['tipo'] ?? '';
    lastPayload = map['lastPayload'] ?? '';
  }
  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      'id': id,
      'idserver': idserver,
      'nome_device': nomedevice,
      'topic': topic,
      'valoron': valoron,
      'valoroff': valoroff,
      'imagem': imagem.isEmpty ? '14' : imagem,
      'coloron': coloron,
      'coloroff': coloroff,
      'nomegrupo': nomegrupo,
      'tipo': tipo,
      'lastPayload': lastPayload,
    };
    return map;
  }

  @override
  String toString() {
    return "Device(id:$id, "
        "nomeDevice: $nomedevice, "
        "topic: $topic, "
        "lastPayload: $lastPayload)";
  }
}
