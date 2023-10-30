import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget editField(
    {String? hint,
    required senha,
    required controller,
    required FormFieldValidator<String> validador,
    bool enable = true,
    bool iconsearch = false,
    Function? fsearch,
    TextInputType? tipoteclado = TextInputType.text}) {
  return TextFormField(
    enabled: enable,
    controller: controller,
    validator: validador,
    obscureText: senha,
    style: const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
    keyboardType: tipoteclado,
    decoration: InputDecoration(
      labelText: hint,
      labelStyle: const TextStyle(color: Colors.black38),
      hintStyle: const TextStyle(color: Colors.black38),
      suffixIcon: iconsearch
          ? IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (fsearch != null) {
                  fsearch();
                }
              },
            )
          : null,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 3, color: Colors.black26),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 3, color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 3, color: Colors.black26),
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

Widget memoField(
    {String? hint,
    required senha,
    required controller,
    required FormFieldValidator<String> validador,
    TextInputType? tipoteclado = TextInputType.text}) {
  return TextFormField(
    controller: controller,
    validator: validador,
    obscureText: senha,
    maxLines: 4,
    style: const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
    keyboardType: tipoteclado,
    decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.black38),
        hintStyle: const TextStyle(color: Colors.black38),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.black26),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        )),
  );
}

Widget mySwith({required bool valor, required onMudar}) {
  return Switch(
    value: valor,
    onChanged: onMudar,
    activeColor: Colors.blueGrey,
  );
}

class RowFormatters extends StatelessWidget {
  final String label;
  final TextInputFormatter formatter;
  final TextEditingController controller;
  final TextInputType? tipoteclado;

  const RowFormatters(
      {super.key,
      required this.label,
      required this.formatter,
      required this.controller,
      this.tipoteclado = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: tipoteclado,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black38),
          hintStyle: const TextStyle(color: Colors.black38),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.black26),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          )),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        formatter,
      ],
    );
  }
}
