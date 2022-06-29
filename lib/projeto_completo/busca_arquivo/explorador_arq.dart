// bibliotecas-classes
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:editorconfiguracao/projeto_completo/abre%20arquivo/abreExplorador.dart';
import 'package:editorconfiguracao/projeto_completo/componentes_telas/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

// importação arquivos
import 'package:editorconfiguracao/main.dart';
import 'package:editorconfiguracao/projeto_completo/tabelas/menu/tabelas_page.dart';

class ExploradorArquivos extends StatefulWidget {
  const ExploradorArquivos({Key? key}) : super(key: key);

  @override
  State<ExploradorArquivos> createState() => ExploradorArquivosState();
}

class ExploradorArquivosState extends State<ExploradorArquivos> {
  final myController = TextEditingController();

  var _recebeCaminho = '';
  var _conteudo = 'ftfdyegfde';
  var strarray, estacao, _estac, _array, teste, _nj;
  var nom;

  get ncwejfnc => _estac;

// abre o explorador e armazena o caminho do arquivo em uma variavel
  abreArquivo() async {
    _recebeCaminho = '';
    String? caminhoArquivo = r'/storage/';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      caminhoArquivo =
          result.files.single.path; // variavel que recebe o caminho do arquivo
    } else {
      // validar um erro
    }
    setState(
      () {
        _recebeCaminho =
            caminhoArquivo!; // espera a variavel ser inicializada para receber valor
      },
    );

// lê e decodifica o texto do arquivo;

    final File _meuArquivo = File(_recebeCaminho);
    final _dadosArquivo = await File(_recebeCaminho)
        .readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));

// variavel conteudo recebendo o texto decodificado
    setState(
      () {
        _conteudo = _dadosArquivo;
      },
    );
  }

  Future<void> _tabela() async {
    _nj = await _conteudo;
    final _teste = _nj.split('\r\n');

    for (int i = 0; i < _teste.length; i++) {
      var cont = i + 1;
      //var nome = _teste[cont].substring(0, 3);
      if (_teste[i++].substring(0, 3) == 'TIT') {
        List<String> strarray = _teste[i].split('|');
        setState(
          () {
            _array = strarray;
          },
        );
      } else if (_teste[i++].substring(0, 3) == 'CPO') {
        List<String> estacao = _teste[cont].split('^');

        setState(
          () {
            _estac = estacao;
          },
        );
      }
    }
  }

  Future<String> carrega() async {
    var tested = await _conteudo;
    return tested;
  }

  Future<String> testes() async {
    var nod = await _conteudo;

    return _conteudo;
  }

  get n => carrega();

  String get m {
    var yhsdhs = "mfeklmf";
    return yhsdhs;
  }

// scrollbar bidimencional
  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 160,
      left: 30,
      right: 0,
      bottom: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 238, 238, 238),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17.0),
                      topRight: Radius.circular(17.0),
                      bottomLeft: Radius.circular(17.0),
                      bottomRight: Radius.circular(17.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.blue,
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: abreArquivo,
                                child: const Text('Abrir'),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _tabela,
                          child: const Text('tabela'),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
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
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: tabelaDados(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabelaDados() {
    return DataTable(
      showCheckboxColumn: true,
      columns: [
        if (_array != null) ...{
          for (final nov in _array) ...{
            DataColumn(
              label: Text(
                '$nov',
              ),
            ),
          }
        } else ...{
          const DataColumn(
            label: Text(
              '',
            ),
          ),
        }
      ],
      rows: [
        if (_estac != null) ...{
          for (int i = 0; i < estacao.toString().length; i++) ...{
            DataRow(
              cells: [
                for (final teste in _estac) ...{
                  DataCell(Text('$teste')),
                }
              ],
            ),
          },
        } else ...{
          const DataRow(
            cells: [
              DataCell(Text("")),
            ],
          ),
        },
      ],
    );
  }
}
