// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';

// ignore: deprecated_member_use
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:editorconfiguracao/projeto_completo/componentes_telas/app_bar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';

class PesquisaArquivo extends StatelessWidget {
  const PesquisaArquivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        // verticalDirection: VerticalDirection.down,
        children: [
          // Container(
          //   width: 300,
          //   height: 30,
          //   child: const DiretorioArquivo(),
          // ),
          // Container(
          //   width: 200,
          //   height: 30,
          //   child: const Arquivo(),
          // ),
          Expanded(
            child: CarregarTabelas(),
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
    if (kDebugMode) {
      print(conteudo);
    }
    return conteudo;
  }

  Future<String> a() async {
    await abreArquivo();
    var envia = conteudo;
    if (kDebugMode) {
      print(envia);
    }
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

class CarregarTabelas extends StatelessWidget {
  CarregarTabelas({Key? key}) : super(key: key);
  List<String> test = ["kfmekf"];
  List<String> test2 = [
    "kfmekf",
    "nfsniefle",
    "knsckjndec",
    "jbcskjbdv",
    "kfmekf",
    "nfsniefle",
    "knsckjndec",
    "jbcskjbdv",
    "kfmekf",
    "nfsniefle",
    "knsckjndec",
    "jbcskjbdv",
    "kfmekf",
    "nfsniefle",
    "knsckjndec",
    "jbcskjbdv",
    "kfmekf",
    "nfsniefle",
    "knsckjndec",
    "jbcskjbdv",
    "kfmekf",
    "nfsniefle",
    "knsckjndec",
    "jbcskjbdv",
    "kfmekf",
    "nfsniefle",
    "knsckjndec",
    "jbcskjbdv",
    "kfmekf",
    "nfsniefle",
    "knsckjndec",
    "jbcskjbdv",
    "kfmekf",
    "nfsniefle",
    "knsckjndec",
    "jbcskjbdv",
    "kfmekf",
    "nfsniefle",
    "knsckjndec",
    "jbcskjbdv"
  ];

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columns: [
        for (final nome in test) ...{
          DataColumn2(
            label: Text('$nome'),
          ),
        },
      ],
      rows: [
        for (int i = 0; i < test.length; i++) ...{
          DataRow2(
            cells: [
              for (final nome in test) ...{
                DataCell(Text('$nome')),
              },
            ],
          ),
        },
      ],
    );
  }
}
