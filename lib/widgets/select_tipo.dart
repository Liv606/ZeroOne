import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';

class CTipo {
  int id = 0;
  String tipo = '';

  CTipo(this.id, this.tipo);
}

Widget selectTipo({required String valorInicial, required Function setTipo}) {
  List<CTipo> atipo = [];

  Future<List> loadTipos() async {
    atipo = [];
    atipo.add(CTipo(0, 'swith on/off'));
    atipo.add(CTipo(1, 'Sensor'));
    return atipo;
  }

  return valorInicial.isNotEmpty
      ? FutureBuilder(
          future: loadTipos(),
          builder: (context, snapshot) {
            return DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black26),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  label: Text('Tipo device')),
              style: const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
              value: valorInicial,
              icon: const Icon(Icons.arrow_downward),
              onChanged: (String? value) {
                setTipo(value!);
              },
              items: atipo.map((e) {
                return DropdownMenuItem<String>(
                  value: e.id.toString(),
                  child:
                      Text(e.tipo, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
            );
          },
        )
      : Container();
}
