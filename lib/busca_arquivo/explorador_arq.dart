// bibliotecas-classes
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:editorconfiguracao/tela_principal/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

// importação arquivos
import 'package:editorconfiguracao/main.dart';
import 'package:editorconfiguracao/separa_arquivo/separador.dart';
import 'package:editorconfiguracao/tela_principal/interface_inicial.dart';

class ExploradorArquivos extends StatefulWidget {
  const ExploradorArquivos({Key? key}) : super(key: key);

  @override
  State<ExploradorArquivos> createState() => _ExploradorArquivosState();
}

class _ExploradorArquivosState extends State<ExploradorArquivos> {
  var _recebeCaminho = '';
  var _conteudo = '';
  var strarray, estacao, _estac, _array, teste, _nj;
  var nom;

// abre o explorador e armazena o caminho do arquivo em uma variavel
  Future<void> abreArquivo() async {
    _recebeCaminho = '';
    String? caminhoArquivo = r'/storage/';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      caminhoArquivo =
          result.files.single.path; // variavel que recebe o caminho do arquivo
    } else {
      // validar um erro
    }
    setState(() {
      _recebeCaminho =
          caminhoArquivo!; // espera a variavel ser inicializada para receber valor
    });
  }

// lê e decodifica o texto do arquivo;
  Future<void> _lerDados() async {
    final _meuArquivo = File(_recebeCaminho);
    final _dadosArquivo = await File(_recebeCaminho)
        .readAsStringSync(encoding: Latin1Codec(allowInvalid: true));

// variavel conteudo recebendo o texto decodificado
    setState(() {
      _conteudo = _dadosArquivo;
    });
  }

  Future<void> _tabela() async {
    _nj = await _conteudo;
    final _teste = _nj.split('\r\n');

    for (int i = 0; i < _teste.length; i++) {
      var cont = i + 1;
      //var nome = _teste[cont].substring(0, 3);
      if (_teste[i++].substring(0, 3) == 'TIT') {
        List<String> strarray = _teste[cont].split('|');
        setState(() {
          _array = strarray;
        });
      } else if (_teste[i++].substring(0, 3) == 'CPO') {
        List<String> estacao = _teste[cont].split('^');

        setState(() {
          _estac = estacao;
        });
      }
    }
  }

// scrollbar bidimencional
  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: SingleChildScrollView(
        child: Column(children: [
          Container(
              child: Column(children: [
            TextButton(onPressed: abreArquivo, child: Text('Abrir')),
            ElevatedButton(
              child: Text('Abrir'),

              onPressed:
                  _lerDados, // aqui ele recebe o arquivo e a conversao dele
            ),
          ])),
          Container(
            child: ElevatedButton(
              child: Text('tabela'),
              onPressed: _tabela,
            ),
          ),
          Container(
              height: 100,
              child: AdaptiveScrollbar(
                  controller: _verticalScrollController,
                  child: AdaptiveScrollbar(
                      controller: _horizontalScrollController,
                      position: ScrollbarPosition.bottom,
                      child: SingleChildScrollView(
                          controller: _verticalScrollController,
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                              controller: _horizontalScrollController,
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, bottom: 16.0),
                                child: tabelaDados(),
                              ))))))
        ]),
      )),
    );
  }

  Widget tabelaDados() {
    return DataTable(showCheckboxColumn: true, columns: [
      if (_array != null) ...{
        for (final nov in _array) ...{
          DataColumn(
              label: Text(
            '${nov}',
          )),
        }
      } else ...{
        DataColumn(
            label: Text(
          '${_array}',
        )),
      }
    ], rows: [
      if (_estac != null) ...{
        DataRow(cells: [
          for (final teste in _estac) ...{
            DataCell(Text('${teste}')),
          }
        ]),
      } else ...{
        DataRow(cells: [
          DataCell(Text('${_estac}')),
        ]),
      }
    ]);
  }
}
