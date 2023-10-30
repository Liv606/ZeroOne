import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalHelper {
  static final LocalHelper _instance = LocalHelper.internal();

  factory LocalHelper() => _instance;

  LocalHelper.internal();

  Database? _db;

  get conexao async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDB();
      return _db;
    }
  }

  Future<Database> initDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final databasesPath = appDocPath;
    final path = join(databasesPath, "myhomemaqtt.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("DROP TABLE IF EXISTS tparam");
      await db.execute("DROP TABLE IF EXISTS tserver");
      await db.execute("DROP TABLE IF EXISTS tdevice");
      await db.execute("DROP TABLE IF EXISTS tdiscovery");

      await db.execute("CREATE TABLE IF NOT EXISTS tparam( "
          "empresa varchar(02),"
          "parametro varchar(20),"
          "modulo varchar(20),"
          "valor varchar(200),"
          "tipo varchar(1),"
          "valores varchar(500),"
          "descricao varhcar(100)"
          ")");

      await db.execute(
          "CREATE TABLE IF NOT EXISTS tserver( id integer PRIMARY KEY AUTOINCREMENT,nomeserver varchar(200),ip varhchar(100),porta varchar(10),username varchar(20),password varchar(20),status varchar(20))");

      await db.execute('CREATE TABLE IF NOT EXISTS tdevice('
          'id integer PRIMARY KEY AUTOINCREMENT,'
          'idserver integer,'
          'nome_device varchar(60),'
          'topic varchar(255),'
          "valoron varchar(255),"
          "valoroff varchar(255),"
          "imagem varchar(100),"
          "coloron varchar(100),"
          "coloroff varchar(100),"
          "nomegrupo varchar(100),"
          "tipo varchar(1),"
          "lastPayload varchar(1024)"
          ')');

      await db.execute(
          'CREATE TABLE IF NOT EXISTS tdiscovery(id integer PRIMARY KEY AUTOINCREMENT,device varchar(500),payload varchar(5000))');
    });
  }
}
