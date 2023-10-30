import 'package:flutter/material.dart';
import 'package:myhomemqtt/styles.dart';

Widget searchEditField(
    {required TextEditingController searchController,
    required Function procPesquisa}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      // Add padding around the search bar
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      // Use a Material design search bar
      child: TextFormField(
        style: Styles.textoPesquisa,
        controller: searchController,
        textInputAction: TextInputAction.go,
        onFieldSubmitted: (value) {
          procPesquisa(searchController.text);
        },
        decoration: InputDecoration(
            fillColor: Styles.iconePesquisaCor,
            focusColor: Styles.iconePesquisaCor,
            iconColor: Styles.iconePesquisaCor,
            prefixIconColor: Styles.iconePesquisaCor,
            suffixIconColor: Styles.iconePesquisaCor,
            hintText: 'Procurar...',
            prefixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                procPesquisa('');
              },
            ),
            // Add a search icon or button to the search bar
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Perform the search here
                procPesquisa(searchController.text);
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.black12),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.black26),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    ),
  );
}
