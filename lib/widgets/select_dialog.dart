import 'package:flutter/material.dart';

class ItemSelect {
  String? id;
  String? nome;
  ItemSelect(this.id, this.nome);
}

Widget selectDialog(BuildContext context, List<ItemSelect> itens, seleciona) {
  return SizedBox(
    height: MediaQuery.of(context).size.width * 0.7,
    width: MediaQuery.of(context).size.width * 0.9,
    child: Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: itens.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: ListTile(
                  title: Text(itens[index].nome!),
                ),
                onTap: () {
                  seleciona(itens[index].id);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}
