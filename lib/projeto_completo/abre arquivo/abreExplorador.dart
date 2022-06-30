import 'dart:convert';
import 'dart:io';

// ignore: deprecated_member_use
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';

class PesquisaArquivo extends StatelessWidget {
  const PesquisaArquivo({Key? key}) : super(key: key);

  // Corpo principal da tela
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        verticalDirection: VerticalDirection.down,
        children: const [
          Arquivo(),
        ],
      ),
    );
  }
}

class Arquivo extends StatefulWidget {
  const Arquivo({Key? key}) : super(key: key);

  @override
  State<Arquivo> createState() => ArquivoState();
}

class ArquivoState extends State<Arquivo> {
  String _recebeCaminhoArquivo = "";
  String conteudoArquivo = "";
  String dadosArquivo = "";
  String _separaArquivo = "";
  var _arrayString, _linhasArquivo, estacao;

  //Abre o explorador e pega o caminho do arquivo
  Future<void> abreArquivo() async {
    String? caminhoArquivo = r'/storage/';
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      caminhoArquivo = result.files.single.path;
    }
    setState(
      () {
        _recebeCaminhoArquivo = caminhoArquivo!;
      },
    );

    final dadosArquivo = await File(_recebeCaminhoArquivo).readAsStringSync(
      encoding: const Latin1Codec(allowInvalid: true),
    );
    setState(
      () {
        conteudoArquivo = dadosArquivo;
      },
    );

    print(conteudoArquivo);
  }

  //recebe o arquivo e decodifica para preservar os caracteres especiais
  Future<void> carregaArquivo() async {
    _separaArquivo = await conteudoArquivo;
    final _teste = _separaArquivo.split('\r\n');

    for (int i = 0; i < _teste.length; i++) {
      var cont = i + 1;
      //var nome = _teste[cont].substring(0, 3);
      if (_teste[i++].substring(0, 3) == 'TIT') {
        List<String> strarray = _teste[i++].split('|');
        setState(
          () {
            _arrayString = strarray;
          },
        );
      } else if (_teste[i++].substring(0, 3) == 'CPO') {
        List<String> estacao = _teste[i++].split('^');

        setState(
          () {
            _linhasArquivo = estacao;
          },
        );
      }
    }
  }

  // Tabela e pesquisa montadas
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      verticalDirection: VerticalDirection.down,
      children: [
        SizedBox(
          width: 300,
          height: 30,
          child: pesquisa(),
        ),
        SizedBox(
          width: 200,
          height: 30,
          child: button(),
        ),
        SizedBox(
          height: 700,
          child: tabelas(),
        ),
      ],
    );
  }

  //Criação das tabelas
  Widget tabelas() {
    //String recebendo = "mfrlksmfjwemflimfj|fcwefefe";
    //List<String> test2 = ["kfmekf"];
    /* List<String> test = [
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
*/

    return Container(
      decoration: decoracaoContainer,
      child: DataTable2(
        minWidth: 3000,
        horizontalMargin: 10,
        showCheckboxColumn: true,
        columnSpacing: 2,
        checkboxHorizontalMargin: 2.5,
        columns: [
          if (_arrayString != null) ...{
            for (final nomeColuna in _arrayString) ...{
              DataColumn2(
                label: Text(nomeColuna),
              ),
            },
          } else ...{
            const DataColumn2(
              label: Text(""),
            ),
          }
        ],
        rows: [
          if (_linhasArquivo != null) ...{
            for (int i = 0; i <= estacao.toString().length; i++) ...{
              DataRow2(
                cells: [
                  for (final nomelinha in _linhasArquivo) ...{
                    DataCell(Text(nomelinha)),
                  },
                ],
              ),
            },
          } else ...{
            const DataRow2(
              cells: [
                DataCell(Text("")),
              ],
            ),
          }
        ],
      ),
    );
  }

  //Criação dos boroes para abrir e carregar o arquivo
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

  //barra que recebe o caminho do arquivo
  Widget pesquisa() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.archive),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        labelText: 'Arquivo',
      ),
    );
  }
}
