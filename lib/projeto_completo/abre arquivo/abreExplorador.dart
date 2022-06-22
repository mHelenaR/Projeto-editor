import 'package:flutter/material.dart';

class PesquisaArquivo extends StatelessWidget {
  const PesquisaArquivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      width: 500,
      child: Wrap(
        spacing: 10,
        direction: Axis.horizontal,
        children: [
          Container(
            height: 30,
            width: 300,
            child: const DiretorioArquivo(),
          ),
          const BotaoArquivo(),
        ],
      ),
    );
  }
}

class DiretorioArquivo extends StatelessWidget {
  const DiretorioArquivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
      prefixIcon: const Icon(Icons.archive),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      labelText: 'Arquivo',
    ));
  }
}

class BotaoArquivo extends StatelessWidget {
  const BotaoArquivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: const Text("Procurar"),
        style: ElevatedButton.styleFrom(
          primary: const Color(0XFF673AB7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ));
  }
}
