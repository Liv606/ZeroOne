import 'package:flutter/material.dart';

Future<bool> dialogAlertYesNo(BuildContext context, String message) async {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    child: const Text("Não"),
    onPressed: () {
      // returnValue = false;
      Navigator.of(context).pop(false);
    },
  );
  Widget continueButton = ElevatedButton(
    child: const Text("Sim"),
    onPressed: () {
      // returnValue = true;
      Navigator.of(context).pop(true);
    },
  ); // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Responda ?"),
    content: Text(message),
    actions: [
      cancelButton,
      continueButton,
    ],
  ); // show the dialog
  final result = await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  return result ?? false;
}
