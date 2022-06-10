import 'dart:io';
import 'package:flutter/material.dart';

//Paginas
import 'package:editorconfiguracao/busca_arquivo/explorador_arq.dart';

class pesquisaArquivo extends StatelessWidget {
  const pesquisaArquivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: SizedBox(
                  height: 36,
                  width: 500,
                  child: Stack(
                    children: [
                      SizedBox(width: 400, child: DiretorioArquivo()),
                      Positioned(
                        top: 4,
                        left: 410,
                        child: BotaoArquivo(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DiretorioArquivo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
      prefixIcon: Icon(Icons.archive),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      labelText: 'Arquivo',
    ));
  }
}

class BotaoArquivo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: Text("Procurar"),
        style: ElevatedButton.styleFrom(
          primary: Color(0XFF673AB7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ));
  }
}
