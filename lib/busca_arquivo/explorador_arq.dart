// bibliotecas-classes
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

// importação arquivos
import 'package:editorconfiguracao/main.dart';
import 'package:editorconfiguracao/separa_arquivo/separador.dart';

class ExploradorArquivos extends StatefulWidget {
  const ExploradorArquivos({Key? key}) : super(key: key);

  @override
  State<ExploradorArquivos> createState() => _ExploradorArquivosState();
}

class _ExploradorArquivosState extends State<ExploradorArquivos> {
  var _recebeCaminho = '';
  var _conteudo = '';
  var novd;

// abre o explorador e armazena o caminho do arquivo em uma variavel
  Future<void> abreArquivo() async {
    _recebeCaminho = '';
    String? caminhoArquivo = r'/storage/';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      caminhoArquivo = result.files.single.path;
    } else {
      // validar um erro
    }
    setState(() {
      _recebeCaminho = caminhoArquivo!;
    });
  }

// lê e decodifica o texto do arquivo;
  Future<void> _lerDados() async {
    final _meuArquivo = File(_recebeCaminho);
    final _dadosArquivo = await File(_recebeCaminho)
        .readAsStringSync(encoding: Latin1Codec(allowInvalid: true));

// variavel conteudo recebendo o texto decodificado
    setState(() {
      if (_conteudo != null) {
        _conteudo = _dadosArquivo;
      } else {
        _conteudo = "#teste|teste CPO csc^csc TIT ";
      }
    });
  }

  tabela() {
    final _teste = _conteudo;
    final start = '#';
    final end = 'CPO ';
    final startIndex = _teste.indexOf(start);
    final endIndex = _teste.indexOf(end);
    final _result =
        _teste.substring(startIndex + start.length, endIndex).trim();

    final inicio = 'CPO ';
    final fim = ' TIT ';
    final inicioInd = _teste.indexOf(inicio);
    final fimInd = _teste.indexOf(fim);
    final _novo = _teste.substring(inicioInd + inicio.length, fimInd);

    List<String> strarray = _result.split('|');

    List<String> estacao = _novo.split('^');

    Widget build(context) {
      return DataTable(horizontalMargin: 10, columns: [
        for (var i = 0; i < strarray.length; i++) ...{
          DataColumn(
              label: Text(
            '${strarray[i]}',
            style: TextStyle(fontSize: 20),
          )),
        }
      ], rows: [
        for (var i = 0; i < 1; i++) ...{
          DataRow(cells: [
            for (var i = 0; i < estacao.length; i++) ...{
              DataCell(Text('${estacao[i]}'.toString())),
            }
          ]),
        }
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: tabela(),
        )
      ]),
    ));
  }
}
