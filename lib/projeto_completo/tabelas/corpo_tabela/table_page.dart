// ignore_for_file: unused_import, prefer_const_constructors_in_immutables, unused_element, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, unused_field, unused_local_variable, await_only_futures, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:editorconfiguracao/projeto_completo/abre%20arquivo/abreExplorador.dart';

import 'package:editorconfiguracao/projeto_completo/componentes_telas/app_bar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_pesquisa.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sidebarx/sidebarx.dart';

class Arquivo extends StatelessWidget {
  const Arquivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ArquivoPagina(),
      ),
    );
  }
}

class ArquivoPagina extends StatefulWidget {
  ArquivoPagina({Key? key}) : super(key: key);

  @override
  State<ArquivoPagina> createState() => _ArquivoPaginaState();
}

class _ArquivoPaginaState extends State<ArquivoPagina> {
  var _recebeCaminhoArquivo, conteudoArquivo;

  List<String> listaTIT = [];
  List<String> nomeTabelas = [];
  List<String> listaMenu = [''];

  final _controller = SidebarXController(selectedIndex: 0);

  Future<void> arquivoAbrirSeparar() async {
    try {
      String? caminhoArquivo = r'/storage/';
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['cfg'],
        dialogTitle: 'Abrir',
        withData: true,
      );

      if (result != null) {
        caminhoArquivo = result.files.single.path;
        setState(() {
          _recebeCaminhoArquivo = caminhoArquivo!;
        });

        final dadosArquivo = await File(_recebeCaminhoArquivo).readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));

        setState(() {
          conteudoArquivo = dadosArquivo;
        });

        setState(() {
          colunasTabelasArquivo();
        });

        setState(() {
          nomeTabelasArquivo();
        });
      } else {
        // dentro do metodo Scaffold ela nao executa
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            elevation: 50,
            content: Text("Operação cancelada! O arquivo não foi selecionado!"),
          ),
        );

        setState(() {
          _recebeCaminhoArquivo = '';
        });
        print('else');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exception: $e'),
        ),
      );
      setState(() {
        _recebeCaminhoArquivo = '';
      });
    }
  }

  linhasTabelasArquivo() async {
    // for(){
    //   for(){}
    // }
  }

  String _separarArquivo = '';
  List<String> separaTabelasArquivo = [];
  List<String> nomeColSeparada = [];
  List<String> nomeColunas = [];
  List<String> _arrayString = [''];
  List<String> linhaCPO = [];
  List<String> teste1 = [];
  List<String> teste2 = [];
  List<String> teste3 = [];

  colunasTabelasArquivo() async {
    // espera o carregamento da variavel
    _separarArquivo = await conteudoArquivo;

    // cria lista com cpo
    separaTabelasArquivo = _separarArquivo.split('TIT ');
    List<String> _linhasTIT = separaTabelasArquivo[1].split('\r\n');

    //encontra posição do caracter para extrair
    int posCharacterArquivo = _linhasTIT[0].indexOf('|') + 1;
    nomeColSeparada = [_linhasTIT[0].substring(posCharacterArquivo)];

    // retira o separador
    nomeColunas = nomeColSeparada[0].split('|');
    setState(() {
      _arrayString = nomeColunas;
      //print(_arrayString);
    });

    //----------- CPO------------
    for (int i = 0; i < _linhasTIT.length; i++) {
      int posCPO = _linhasTIT[i].indexOf('CPO ');
      if (posCPO == 0) {
        linhaCPO = [_linhasTIT[i].substring(posCPO)];

        setState(() {
          linhaCPO;
        });
      }
      teste1 = teste1 + linhaCPO;
    }
    for (int p = 0; p < teste1.length; p++) {
      //print(teste1[p]);
      teste2 = teste1[p].split('^');
      teste3 = teste3 + teste2;
    }

    print(teste3);
  }

  nomeTabelasArquivo() async {
    listaTIT = await conteudoArquivo.split('TIT ');
    int posicaoSeparador = 0;

    for (int i = 0; i < listaTIT.length; i++) {
      posicaoSeparador = listaTIT[i].indexOf('#');
      if (posicaoSeparador != -1) {
        nomeTabelas = [listaTIT[i].substring(0, posicaoSeparador)];
      } else {
        nomeTabelas = [];
      }
      setState(() {
        listaMenu = listaMenu + nomeTabelas;
      });
    }
  }

  carregarTela() {
    return Container(
      child: FutureBuilder(
        future: getValue(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return arquivoTabelas();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<String> getValue() async {
    await Future.delayed(const Duration(seconds: 10));
    return 'Aguarde!\n Carregando tabelas!';
  }

  Widget arquivoGridTabelas() {
    late final PlutoGridStateManager stateManager;

    print('teste 1');
    return Container(
        padding: const EdgeInsets.all(10),
        child: PlutoGrid(
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
          },
          columns: [
            for (int j = 0; j < _arrayString.length; j++) ...{
              PlutoColumn(
                title: _arrayString[j],
                field: j.toString(),
                type: PlutoColumnType.text(),
              ),
            }
          ],
          rows: [
            for (int i = 0; i < teste1.length; i++) ...{
              PlutoRow(
                cells: {
                  for (int j = 0; j < teste3.length; j++) ...{
                    j.toString(): PlutoCell(value: teste3[j]),
                  },
                },
              ),
            }
          ],
        ));
  }

  Widget arquivoGridTabelas2() {
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();
    return Container(
      padding: const EdgeInsets.all(10),
      child: AdaptiveScrollbar(
        controller: _verticalScrollController,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: [
              for (int i = 0; i < _arrayString.length; i++) ...{
                if (_controller.selectedIndex == i) ...{
                  if (_arrayString != null) ...{
                    for (final t in _arrayString) ...{
                      DataColumn(
                        label: Text(t),
                      )
                    },
                  } else ...{
                    const DataColumn(
                      label: Text(""),
                    ),
                  },
                }
              }
            ],
            rows: [
              for (int i = 0; i < _arrayString.length; i++) ...{
                if (_arrayString != null) ...{
                  DataRow(
                    cells: [
                      for (final name in _arrayString) ...{
                        DataCell(
                          Text(name),
                        ),
                      },
                    ],
                  ),
                } else ...{
                  const DataRow(
                    cells: [
                      DataCell(Text("")),
                    ],
                  ),
                }
              }
            ],
          ),
        ),
      ),
    );
  }

  Widget arquivoGridTabelas1() {
    List<String> teste = ['a', 'beee', 'c'];
    double cont = teste.length * 100000;
    double tam = cont;
    return Card(
      elevation: 5,
      color: white,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: DataTable2(
          minWidth: 75000,
          columns: [
            for (int i = 0; i < _arrayString.length; i++) ...{
              if (_controller.selectedIndex == i) ...{
                if (_arrayString != null) ...{
                  for (final t in _arrayString) ...{
                    DataColumn2(
                      label: Text(t),
                    )
                  },
                } else ...{
                  const DataColumn2(
                    label: Text(""),
                  ),
                },
              }
            }
          ],
          rows: [
            for (int i = 0; i < _arrayString.length; i++) ...{
              if (_arrayString != null) ...{
                DataRow2(
                  cells: [
                    for (final name in _arrayString) ...{
                      DataCell(
                        Text(name),
                      ),
                    },
                  ],
                ),
              } else ...{
                const DataRow2(
                  cells: [
                    DataCell(Text("")),
                  ],
                ),
              }
            }
          ],
        ),
      ),
    );
  }

  Widget arquivoTabelas() {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double screen = 0;
    if ((heightScreen < 960) && (heightScreen > 760)) {
      screen = MediaQuery.of(context).size.height * 0.75;
    } else if ((heightScreen > 961)) {
      screen = MediaQuery.of(context).size.height * 0.8;
    } else if (heightScreen < 760) {
      screen = MediaQuery.of(context).size.height * 0.7;
    }

    return Flexible(
      child: Container(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: screen,
                child: arquivoGridTabelas(),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget arquivoBusca() {
    var nomeArquivo;
    if (_recebeCaminhoArquivo == '') {
      nomeArquivo = 'Arquivo';
    } else {
      nomeArquivo = _recebeCaminhoArquivo;
    }

    return SizedBox(
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 70,
              //color: Colors.amber,
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 400,
                      height: 35,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.archive),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: nomeArquivo,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        arquivoAbrirSeparar();
                      },
                      style: estiloBotao,
                      child: const Text("Procurar"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget arquivoBarraPesquisa() {
    return TextFormField(
      decoration: styleBarraPesquisa,
    );
  }

  Widget arquivoBotaoPesquisa() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Pesquisar'),
      style: estiloBotao,
    );
  }

  Widget arquivoAppBarTable() {
    return SizedBox(
      height: 70,
      child: AppBar(
        backgroundColor: white,
        actions: [
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Tabelas",
                style: fontePreta,
              ),
            ),
          ),
          Flexible(
            child: Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 40,
                child: arquivoBarraPesquisa(),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              alignment: Alignment.centerLeft,
              child: arquivoBotaoPesquisa(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            SidebarX(
              controller: _controller,
              theme: StyleSideBar,
              extendedTheme: StyleExpandeSideBar,
              footerDivider: divider,
              headerBuilder: (context, extended) {
                return SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/icon_archive.png',
                    ),
                  ),
                );
              },
              items: [
                SidebarXItem(
                  iconWidget: Image.asset(
                    "assets/images/icon_setaEsquerda.png",
                    color: Colors.white,
                  ),
                  label: "Voltar",
                  onTap: () => Navigator.pop(context),
                ),
                for (final lista in listaMenu) ...{
                  SidebarXItem(
                    iconWidget: Image.asset(
                      "assets/images/icon_prancheta.png",
                      color: Colors.white,
                    ),
                    label: lista,
                  ),
                },
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  arquivoAppBarTable(),
                  const SizedBox(
                    height: 10,
                  ),
                  arquivoBusca(),
                  carregarTela(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenssagemErro {
  void showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text("Operação cancelada! O arquivo não foi selecionado!"),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
