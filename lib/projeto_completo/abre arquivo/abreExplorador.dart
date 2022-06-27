import 'dart:convert';
import 'dart:io';

import 'package:editorconfiguracao/projeto_completo/componentes_telas/app_bar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class PesquisaArquivo extends StatelessWidget {
  const PesquisaArquivo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        verticalDirection: VerticalDirection.down,
        children: [
          Wrap(
            spacing: 10,
            direction: Axis.horizontal,
            children: [
              Container(
                height: 30,
                width: 300,
                child: const DiretorioArquivo(),
              ),
              const Arquivo(),
            ],
          ),
          Container(
            height: 50,
            width: 50,
            color: Colors.amber,
          ),
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

class Arquivo extends StatefulWidget {
  const Arquivo({Key? key}) : super(key: key);

  @override
  State<Arquivo> createState() => ArquivoState();
}

class ArquivoState extends State<Arquivo> {
  var _recebeCaminho, conteudo, dadosArquivo;

  Future<void> abreArquivo() async {
    String? caminhoArquivo = r'/storage/';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      caminhoArquivo = result.files.single.path;
    }
    setState(() {
      _recebeCaminho = caminhoArquivo!;
    });
  }

  Future<String> carregaArquivo() async {
    final dadosArquivo = await File(_recebeCaminho)
        .readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));

    conteudo = dadosArquivo;
    print(conteudo);
    return conteudo;
  }

  Future<String> a() async {
    await abreArquivo();
    var envia = conteudo;
    print(envia);
    return envia;
  }

  @override
  Widget build(BuildContext context) {
    return button();
  }

  Widget button() {
    return Wrap(
      spacing: 10,
      children: [
        ElevatedButton(
          onPressed: abreArquivo,
          style: estiloBotao,
          child: const Text("Procurar"),
        ),
        ElevatedButton(
          onPressed: carregaArquivo,
          style: estiloBotao,
          child: const Text("Carregar"),
        ),
      ],
    );
  }
}
