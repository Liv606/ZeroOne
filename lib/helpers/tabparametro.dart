import 'package:sqflite/sqflite.dart';
import 'local.dart';

class TabParametroHelper {
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

  Future<Parametro> saveParametro(Parametro parametro) async {
    Database dbParametro = await conexao;
    Parametro p;
    p = await getParametro('CNPJ');
    if (p.parametro == '') {
      await dbParametro.insert('tparam', parametro.toMap());
    }
    return parametro;
  }

  Future<Parametro> getParametro(String id) async {
    Database dbParametro = await conexao;
    List<Map> maps = await dbParametro.query('tparam',
        columns: [
          'empresa',
          'parametro',
          'modulo',
          'valor',
          'tipo',
          'valores',
          'descricao'
        ],
        where: "parametro = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Parametro.fromMap(maps.first);
    } else {
      return Parametro('', '', '', '', '', '', '');
    }
  }

  Future<int> deleteParametro(String id) async {
    Database dbcliente = await conexao;
    return await dbcliente
        .delete('tparam', where: "parametro = ?", whereArgs: [id]);
  }

  Future<int> updateParametro(String id, String valor) async {
    Database dbcliente = await conexao;
    return await dbcliente.update('tparam', {'valor': valor},
        where: "parametro = ?", whereArgs: [id]);
  }

  Future<List> getAllParamtros() async {
    Database dbParametro = await conexao;
    List listMap = await dbParametro.rawQuery("SELECT * FROM tparam");
    List<Parametro> listParametro = [];
    for (Map m in listMap) {
      listParametro.add(Parametro.fromMap(m));
    }
    return listParametro;
  }

  Future close() async {
    Database dbParametro = await conexao;
    dbParametro.close();
  }

  Future validarParamentros() async {
    Parametro p;
    p = await getParametro('DBVERSAO');
    if (p.parametro == '') {
      p.empresa = '0';
      p.parametro = 'DBVERSAO';
      p.valor = '0';
      p.valores = '';
      p.modulo = 'SISTEMA';
      p.descricao = 'Versao do db internal';
      saveParametro(p);
    }
  }
}

class Parametro {
  String? empresa = '';
  String? parametro = '';
  String? modulo = '';
  String? valor = '';
  String? tipo = '';
  String? valores = '';
  String? descricao = '';

  Parametro(empresa, parametro, modulo, valor, tipo, valores, descricao);

  Parametro.fromMap(Map map) {
    empresa = map['empresa'];
    parametro = map['parametro'];
    modulo = map['modulo'];
    valor = map['valor'];
    tipo = map['tipo'];
    valores = map['valores'];
    descricao = map['descricao'];
  }
  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      'empresa': empresa,
      'parametro': parametro,
      'modulo': modulo,
      'valor': valor,
      'tipo': tipo,
      'valores': valores,
      'descricao': descricao
    };
    return map;
  }

  @override
  String toString() {
    return "Parametro(id:$parametro, "
        "Descricao:   $descricao, "
        "Valor:  $valor)";
  }
}
