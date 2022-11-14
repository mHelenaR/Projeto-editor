// ignore_for_file: unused_local_variable, avoid_print

import 'dart:async';

import 'package:editorconfiguracao/controllers/map_estac_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/nome_tabelas.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/salvar_arquivo.dart';
import 'package:editorconfiguracao/utils/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_borderRadius.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_fontes.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_textField.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';
import 'package:editorconfiguracao/widgets/radio_widget.dart';

import '../projeto_completo/styles/style_tabBar.dart';

class TesteTabela extends StatefulWidget {
  const TesteTabela({super.key});

  @override
  State<TesteTabela> createState() => _TesteTabelaState();
}

class _TesteTabelaState extends State<TesteTabela>
    with TickerProviderStateMixin {
  OpcaoFiltroModel escolha = OpcaoFiltroModel();

  List<Map<dynamic, dynamic>> map = objSqlite.tabelasCompletas;
  List<String> tabelasDicionario = objSqlite.nomeColunasDcn;

  Map mapa = {};

  List<Widget> tabTeste = [];
  List<String> chaves = [];
  List<String> numerosEstacao = [];
  List<dynamic> lista2 = [];

  List<String> tabelasArquivo = [];

  String estacCodigo = '';
  String estacConfig = '';
  String estacTrib = '';
  String estacEvento = '';
  String estacTeclado = '';
  String estacUnidade = '';
  String conteudoArquivo = '';

  bool ativaTabela = false;
  String num = 'vazio';
  TabController getTabController() {
    return TabController(length: tabTeste.length, vsync: this);
  }

  @override
  void initState() {
    ativaTabela = false;
    tabController = getTabController();
    super.initState();
  }

  expandeContainer() {
    if (height == 100) {
      setState(() {
        cor = white;
        height = 0.0;
      });
    } else {
      setState(() {
        cor = grey.shade500;
        height = 100;
      });
    }
  }

  List<dynamic> coluna1 = [];
  List<PlutoRow> linhas1 = [];
  //List<Widget> criarWidgets = [];
  List<PlutoColumn> coluna = [];

  Future<void> arquivoAbrirSeparar() async {
    try {
      caminhoArq = 'C:\\frente\\config (11).cfg';
      setState(() {
        controleArquivo.text = caminhoArq!;
      });

      if (caminhoArq != null) {
        setState(() {
          recebeCaminhoArquivo = caminhoArq!;
        });

        conteudoArquivo = await converteArquivo(recebeCaminhoArquivo);

        // Passando o arquivo para o objeto de gravação
        objArquivoGravacao.setArquivoGR = conteudoArquivo;

        nomeTabelas = await nomeTabelasArquivo(conteudoArquivo);

        tabTeste.clear();

        for (var i = 0; i < nomeTabelas.length; i++) {
          tabTeste.add(Tab(
            text: nomeTabelas[i],
          ));
        }

        setState(() {
          carregarTela();

          tabController = TabController(length: tabTeste.length, vsync: this);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  List<Widget> tabelasConfig() {
    coluna1.clear();
    linhas1.clear();

    coluna.clear();

    print('aqui');
    criarWidgets.clear();

    String? recebeTabela;

    separarArquivo = conteudoArquivo;

    for (int c = 0; c < nomeTabelas.length; c++) {
      int contador = c + 1;
      tabelasArquivo.addAll([nomeTabelas[c]]);

      String start = 'TIT ${nomeTabelas[c]}#';
      String recebeTabela = '';

      if (contador == nomeTabelas.length) {
        contador = contador - 1;

        final startIndex = separarArquivo.indexOf(start);

        recebeTabela = conteudoArquivo.substring(
            startIndex + start.length, conteudoArquivo.length);
      } else {
        String end = 'TIT ${nomeTabelas[contador]}#';

        final startIndex = separarArquivo.indexOf(start);

        final endIndex = separarArquivo.indexOf(end, startIndex + start.length);

        recebeTabela =
            separarArquivo.substring(startIndex + start.length, endIndex);
      }

      List<String> tabelasSeparadas = [recebeTabela];

      for (var i = 0; i < tabelasSeparadas.length; i++) {
        String tabela = tabelasSeparadas[i];

        List<String> linhasTabela = tabela.split('\r\n');

        for (var j = 0; j < linhasTabela.length; j++) {
          if (j == 0) {
            nomeColunas = linhasTabela[j].split('|');

            //================== MAPA ESTACAO NOME-COLUNAS/POSIÇÃO ======================= //
            if (nomeTabelas[c] == 'estac') {
              mapaEstacColuna(nomeTabelas, nomeColunas);
            }
            //============================================================================ //

            //================== MAPA completo DICIONARIO =============================
            // nomeColunasDicionario = transformaString(linhasTabela);
            nomeSubtituloDicionario = transformaString(linhasTabela);

            List<String> nomeColDicio = transformaString(linhasTabela);

            for (var i = 0; i < map.length; i++) {
              Map mapas = map[i];

              for (var element in mapas.entries) {
                for (var j = 0; j < nomeColDicio.length; j++) {
                  if (element.value['campo'] == nomeColDicio[j]) {
                    nomeColDicio[j] = element.value['campo'];
                    nomeSubtituloDicionario[j] = element.value['titulo'];
                  }
                }
              }
            }

            nomeColunasDicionario.addAll([nomeColDicio]);

            //===============================================

            coluna = [
              for (int m = 0; m < nomeColunas.length; m++) ...{
                PlutoColumn(
                  title: nomeColunas[m],
                  field: '$m',
                  type: PlutoColumnType.text(),
                ),
              }
            ];
          } else {
            if (linhasTabela[j] != "") {
              List<String> re = linhasTabela[j].split('CPO ');

              for (var p = 1; p < re.length; p++) {
                if (re[p] != '') {
                  List<String> celula = re[p].split('^');

                  objEstacaoModel.setVerificaRow = celula;

                  linhas1.addAll([
                    PlutoRow(
                      cells: {
                        for (int o = 0; o < celula.length; o++) ...{
                          '$o': PlutoCell(value: celula[o]),
                        }
                      },
                    )
                  ]);

                  //================== MAPA ESTACAO NUMERO/POSICAO DA LINHA ======================= //

                  if (nomeTabelas[c] == 'estac') {
                    mapaEstacRowPosicao(p, celula);
                  }

                  //============================================================================== //

                }
              }
            }
          }
        }

        criarWidgets.add(Column(
          children: [
            Text('$i'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: PlutoGrid(
                  columns: coluna,
                  rows: linhas1,
                  onChanged: (PlutoGridOnChangedEvent event) {
                    int rowIndex = event.rowIdx + 1;
                    mapa = {
                      'tabelaInicial': nomeTabelas[tabController.index],
                      'tabelaFinal': nomeTabelas[metodoContador(
                        tabController.index,
                        nomeTabelas,
                      )],
                      'coluna': nomeColunas[event.columnIdx],
                      'colunaIndex': event.columnIdx,
                      'linhaIndex': rowIndex,
                      'novoValor': event.value,
                    };

                    recebeMapa.addAll([mapa]);
                  },
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                    stateManager!.setAutoEditing(true);

                    event.stateManager
                        .setSelectingMode(PlutoGridSelectingMode.cell);

                    stateManager!.clearCurrentCell();
                    stateManager!.notifyListeners();
                  },
                ),
              ),
            )
          ],
        ));

        linhas1 = [];
      }
    }
    objEstacaoModel.setMapaEstacao = listaMapaEstac;
    objEstacaoModel.setTabelasNome = nomeTabelas;
    tabelasArquivo = [];
    listaMapaEstac = [];

    // setState(() {
    //   ativaTabela = true;
    //   num = 'vazio';
    // });
    return criarWidgets;
  }

  List<Widget> tabelasConfig1() {
    criarWidgets.clear();
    List<Widget> testeLista = objEstacaoModel.listaWidget;

    for (int i = 0; i < tabTeste.length; i++) {
      criarWidgets.add(testeLista[i]);
    }

    return criarWidgets;
  }

  List<Widget> carregarTela() {
    print('aqui');
    List<Widget> criarWidgets1 = [];

    coluna1.clear();
    linhas1.clear();

    coluna.clear();

    print('aqui');
    criarWidgets1.clear();

    String? recebeTabela;

    separarArquivo = conteudoArquivo;

    for (int c = 0; c < nomeTabelas.length; c++) {
      int contador = c + 1;
      tabelasArquivo.addAll([nomeTabelas[c]]);

      String start = 'TIT ${nomeTabelas[c]}#';
      String recebeTabela = '';

      if (contador == nomeTabelas.length) {
        contador = contador - 1;

        final startIndex = separarArquivo.indexOf(start);

        recebeTabela = conteudoArquivo.substring(
            startIndex + start.length, conteudoArquivo.length);
      } else {
        String end = 'TIT ${nomeTabelas[contador]}#';

        final startIndex = separarArquivo.indexOf(start);

        final endIndex = separarArquivo.indexOf(end, startIndex + start.length);

        recebeTabela =
            separarArquivo.substring(startIndex + start.length, endIndex);
      }

      List<String> tabelasSeparadas = [recebeTabela];

      for (var i = 0; i < tabelasSeparadas.length; i++) {
        String tabela = tabelasSeparadas[i];

        List<String> linhasTabela = tabela.split('\r\n');

        for (var j = 0; j < linhasTabela.length; j++) {
          if (j == 0) {
            nomeColunas = linhasTabela[j].split('|');

            //================== MAPA ESTACAO NOME-COLUNAS/POSIÇÃO ======================= //
            if (nomeTabelas[c] == 'estac') {
              mapaEstacColuna(nomeTabelas, nomeColunas);
            }
            //============================================================================ //

            //================== MAPA completo DICIONARIO =============================
            // nomeColunasDicionario = transformaString(linhasTabela);
            nomeSubtituloDicionario = transformaString(linhasTabela);

            List<String> nomeColDicio = transformaString(linhasTabela);

            for (var i = 0; i < map.length; i++) {
              Map mapas = map[i];

              for (var element in mapas.entries) {
                for (var j = 0; j < nomeColDicio.length; j++) {
                  if (element.value['campo'] == nomeColDicio[j]) {
                    nomeColDicio[j] = element.value['campo'];
                    nomeSubtituloDicionario[j] = element.value['titulo'];
                  }
                }
              }
            }

            nomeColunasDicionario.addAll([nomeColDicio]);

            //===============================================

            coluna = [
              for (int m = 0; m < nomeColunas.length; m++) ...{
                PlutoColumn(
                  title: nomeColunas[m],
                  field: '$m',
                  type: PlutoColumnType.text(),
                ),
              }
            ];
          } else {
            if (linhasTabela[j] != "") {
              List<String> re = linhasTabela[j].split('CPO ');

              for (var p = 1; p < re.length; p++) {
                if (re[p] != '') {
                  List<String> celula = re[p].split('^');

                  objEstacaoModel.setVerificaRow = celula;

                  linhas1.addAll([
                    PlutoRow(
                      cells: {
                        for (int o = 0; o < celula.length; o++) ...{
                          '$o': PlutoCell(value: celula[o]),
                        }
                      },
                    )
                  ]);

                  //================== MAPA ESTACAO NUMERO/POSICAO DA LINHA ======================= //

                  if (nomeTabelas[c] == 'estac') {
                    mapaEstacRowPosicao(p, celula);
                  }

                  //============================================================================== //

                }
              }
            }
          }
        }

        criarWidgets1.add(Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: PlutoGrid(
                  columns: coluna,
                  rows: linhas1,
                  onChanged: (PlutoGridOnChangedEvent event) {
                    int rowIndex = event.rowIdx + 1;
                    mapa = {
                      'tabelaInicial': nomeTabelas[tabController.index],
                      'tabelaFinal': nomeTabelas[metodoContador(
                        tabController.index,
                        nomeTabelas,
                      )],
                      'coluna': nomeColunas[event.columnIdx],
                      'colunaIndex': event.columnIdx,
                      'linhaIndex': rowIndex,
                      'novoValor': event.value,
                    };

                    recebeMapa.addAll([mapa]);
                  },
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                    stateManager!.setAutoEditing(true);

                    event.stateManager
                        .setSelectingMode(PlutoGridSelectingMode.cell);

                    stateManager!.clearCurrentCell();
                    stateManager!.notifyListeners();
                  },
                ),
              ),
            ),
          ],
        ));

        linhas1 = [];
      }
    }
    objEstacaoModel.setMapaEstacao = listaMapaEstac;
    objEstacaoModel.setTabelasNome = nomeTabelas;
    tabelasArquivo = [];
    listaMapaEstac = [];
    objEstacaoModel.setListaWidget = criarWidgets1;

    ativaTabela = true;
    num = 'vazio';

    return criarWidgets1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          child: Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 70,
                  child: AppBar(
                    elevation: 2,
                    backgroundColor: white,
                    actions: [
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Edição de Tabelas",
                            style: fontePreta,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              readOnly: true,
                              controller: controleArquivo,
                              decoration: styleBarraArquivo,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  arquivoAbrirSeparar();
                                  // setState(() {
                                  //   ativaTabela = true;
                                  //   // if (ativaTabela) {
                                  //   //   ativaTabela = false;
                                  //   // }
                                  //   // Timer(const Duration(seconds: 1),
                                  //   //     tabelasConfig);

                                  // });
                                },
                                style: estiloBotao,
                                child: const Text("Abrir"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () => gravarArquivo(),
                                style: estiloBotao,
                                child: const Text("Salvar"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  expandeContainer();
                                  setState(() {
                                    filtro = 'principal';
                                  });
                                },
                                style: estiloBotao,
                                child: const Text("Filtrar"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        RadioWidget(
          opcao: opcaoEscolhida ?? "",
        ),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Flexible(
                child: AppBar(
                  backgroundColor: white,
                  title: TabBar(
                    indicator: boxTopLR,
                    unselectedLabelColor: grey,
                    labelColor: white,
                    splashBorderRadius: border40,
                    isScrollable: true,
                    tabs: tabTeste,
                    controller: tabController,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: Container(
        //     padding: const EdgeInsets.all(10),
        //     child: FutureBuilder(
        //       future: delay2(),
        //       builder: (BuildContext context, snapshot) {
        //         if (snapshot.hasData) {
        //           return TabBarView(
        //             controller: tabController,
        //             children: tabelasConfig1(),
        //           );
        //         } else {
        //           return const Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         }
        //       },
        //     ),
        //   ),
        // )
        if (ativaTabela == true) ...{
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: tabelasConfig1(),
            ),
          ),
        } else if (ativaTabela == false) ...{
          const Expanded(
              child: Center(
            child: CircularProgressIndicator(),
          ))
        }
      ],
    );
  }
}

// // Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         ElevatedButton(
//           onPressed: () async {
//             conteudoArquivo = await converteArquivo('C:\\frente\\config.cfg');
//             nomeTabelas = await nomeTabelasArquivo(conteudoArquivo);
//             setState(() {
//               tabTeste.clear();
//               for (var i = 0; i < nomeTabelas.length; i++) {
//                 tabTeste.add(Tab(
//                   text: nomeTabelas[i],
//                 ));
//               }
//               cont = cont + 1;
//               if (ativaTabela) {
//                 ativaTabela = false;
//               }
//               Timer(const Duration(seconds: 1), tabelasConfig);
//               tabController =
//                   TabController(length: tabTeste.length, vsync: this);
//             });
//           },
//           child: const Text('tabela'),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         SizedBox(
//           height: 50,
//           child: Row(
//             children: [
//               Flexible(
//                 child: AppBar(
//                   title: TabBar(
//                     isScrollable: true,
//                     controller: tabController,
//                     tabs: tabTeste,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (ativaTabela == true) ...{
//           Expanded(
//             child: TabBarView(
//               controller: tabController,
//               children: tabelasConfig(),
//             ),
//           ),
//         } else if (ativaTabela == false) ...{
//           const Expanded(
//               child: Center(
//             child: CircularProgressIndicator(),
//           ))
//         }
//       ],
//     );
//   }
