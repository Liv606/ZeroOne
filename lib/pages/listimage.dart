import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myhomemqtt/helpers/image_helper.dart';

class ListImage extends StatefulWidget {
  final Function setImage;
  const ListImage({required this.setImage, Key? key}) : super(key: key);

  @override
  State<ListImage> createState() => _ListImageState();
}

class _ListImageState extends State<ListImage> {
  int selectedImageIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolher Imagem'),
      ),
      body: ListView.builder(
        itemCount: ImagesSVG.lista.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              // Define o índice da imagem selecionada
              setState(() {
                selectedImageIndex = index;
              });
              widget.setImage(index.toString());
            },
            selected: index == selectedImageIndex,
            trailing: SizedBox(
              width: 50,
              height: 50,
              child: selectedImageIndex == index
                  ? const Icon(
                      Icons.check,
                      size: 25,
                    )
                  : Container(),
            ),
            title: SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.string(
                getImageSVG((index).toString()),
                width: 50, // Defina o tamanho desejado para a imagem SVG
                height: 50,
              ),
            ),
          );
        },
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Faça algo com a imagem selecionada, por exemplo, exibir em outra tela
          if (selectedImageIndex >= 0 &&
              selectedImageIndex < ImagesSVG.lista.length) {
            String selectedSvg = getImageSVG(selectedImageIndex.toString());
            //ImagesSVG.lista[selectedImageIndex.toString()]!;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SelectedImageScreen(selectedSvg),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),*/
    );
  }
}

class SelectedImageScreen extends StatelessWidget {
  final String svg;

  const SelectedImageScreen(this.svg, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagem Selecionada'),
      ),
      body: Center(
        child: SvgPicture.string(
          svg,
          width: 200, // Defina o tamanho desejado para a imagem SVG
          height: 200,
        ),
      ),
    );
  }
}
