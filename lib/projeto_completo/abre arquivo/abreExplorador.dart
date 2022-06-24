import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
          BotaoArquivo(),
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

class BotaoArquivo extends StatefulWidget {
  const BotaoArquivo({Key? key}) : super(key: key);

  @override
  State<BotaoArquivo> createState() => BotaoArquivoState();
}

class BotaoArquivoState extends State<BotaoArquivo> {
  var _recebeCaminho, conteudo, dadosArquivo;

  void aslteraValor() {
    setState(() {
      conteudo = !conteudo;
    });
  }

  Future<String> abreArquivo() async {
    String? caminhoArquivo = r'/storage/';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      caminhoArquivo = result.files.single.path;
    }

    _recebeCaminho = caminhoArquivo!;

    final dadosArquivo = await File(_recebeCaminho)
        .readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));

    //recebe(_conteudo);

    conteudo = dadosArquivo;
    print(conteudo);
    return conteudo;
  }

  String recebe(String afeefesfs) {
    conteudo = afeefesfs;
    return conteudo;
  }

  get n => conteudo;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: abreArquivo,
      child: const Text("Procurar"),
      style: ElevatedButton.styleFrom(
        primary: const Color(0XFF673AB7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
