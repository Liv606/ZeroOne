import 'package:sqflite/sqflite.dart';
import 'local.dart';

class TabServerHelper {
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

  Future<int> proximo() async {
    Database db = await conexao;
    List listMap = await db.rawQuery("SELECT max(id) as conta FROM tserver");
    int proximo = listMap.first['conta'];
    return (proximo + 1);
  }

  Future<Server> saveServer(Server server) async {
    Database db = await conexao;
    await db.insert('tserver', server.toMap());
    return server;
  }

  Future<Server> updateServer(int id, Server server) async {
    Database db = await conexao;
    await db
        .update('tserver', server.toMap(), where: "id = ?", whereArgs: [id]);
    return server;
  }

  Future<bool> updateStatus(int id, String status) async {
    Database db = await conexao;
    await db.update('tserver', {'status': status},
        where: "id = ?", whereArgs: [id]);
    return true;
  }

  Future<int> deleteServer({required int id}) async {
    Database db = await conexao;
    List exist = await db
        .rawQuery('select count(*) as conta from tdevice where idserver = $id');
    if (exist.first['conta'] == 0) {
      return await db.delete('tserver', where: 'id = ?', whereArgs: [id]);
    } else {
      return -1;
    }
  }

  Future<Server> getid(int id) async {
    Database db = await conexao;
    List<Map> maps = await db.query('tserver',
        columns: [
          'id',
          'nomeserver',
          'ip',
          'porta',
          'username',
          'password',
          'status'
        ],
        where: "id = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Server.fromMap(maps.first);
    } else {
      return Server(-1, '', '', '', '', '', '');
    }
  }

  Future<List<Server>> getServer() async {
    Database db = await conexao;
    List listMap = await db.rawQuery("SELECT * FROM tserver");
    List<Server> listServer = [];
    for (Map m in listMap) {
      listServer.add(Server.fromMap(m));
    }
    return listServer;
  }

  Future close() async {
    Database db = await conexao;
    db.close();
  }
}

class Server {
  int? id;
  String? nomeserver;
  String? ip;
  String? porta;
  String? username;
  String? password;
  String? status;

  Server(this.id, this.nomeserver, this.ip, this.porta, this.username,
      this.password, this.status);

  Server.fromMap(Map map) {
    id = map['id'];
    nomeserver = map['nomeserver'];
    ip = map['ip'];
    porta = map['porta'];
    username = map['username'];
    password = map['password'];
    status = map['status'];
  }
  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      'id': id,
      'nomeserver': nomeserver,
      'ip': ip,
      'porta': porta,
      'username': username,
      'password': password,
      'status': status
    };
    return map;
  }

  @override
  String toString() {
    return "Server(id:$id, "
        "nomeserver: $nomeserver, "
        "ip: $ip)";
  }
}
