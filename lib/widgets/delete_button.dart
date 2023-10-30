import 'package:flutter/material.dart';

Widget deleteButton({required int id, required Function deleteFunction}) {
  return id != -1
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () async {
                  await deleteFunction(id: id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 48,
                )),
            const SizedBox(
              width: 8.0,
            ),
            const Text('Excluir ?')
          ],
        )
      : Container();
}
