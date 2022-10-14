import 'dart:async';

import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/criacao_tabs/tabs_create.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_pluto_grid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/filtro/filtro_principal.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/nome_tabelas.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/salvar_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/seleciona_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/box_container.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_borderRadius.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_fontes.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_tabBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_textField.dart';
import 'package:pluto_grid/pluto_grid.dart';

class TelaEdicao extends StatefulWidget {
  const TelaEdicao({super.key});

  @override
  State<TelaEdicao> createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> with TickerProviderStateMixin {
  TabController getTabController() {
    return TabController(length: tabs.length, vsync: this);
  }

  @override
  void initState() {
    tabController = getTabController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

  Future<void> arquivoAbrirSeparar() async {
    try {
      caminhoArq = await arquivoTabela();

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

        nomeTab(nomeTabelas.length);

        tabs = criaTab(nomeTabelas.length);

        setState(() {
          getWidgets();
          tabController =
              TabController(length: tabs.length, vsync: this, initialIndex: 0);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String> delay() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Aguarde!\n Carregando tabelas!';
  }

  Future<String> delay2() async {
    await Future.delayed(const Duration(seconds: 5));
    return 'Aguarde!\n Carregando tabelas!';
  }

  List<Widget> getWidgets() {
    criarWidgets.clear();

    for (int i = 0; i < tabs.length; i++) {
      criarWidgets.add(criaTabViewTabela(0));
    }

    return criarWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        barraPrincipal(),
        barraFiltro(),
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
                    tabs: tabs,
                    controller: tabController,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:

                // TabBarView(
                //   controller: tabController,
                //   children: [
                FutureBuilder(
              future: delay2(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return TabBarView(
                    controller: tabController,
                    children: getWidgets(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),

            // for (int i = 0; i < tabs.length; i++) ...{
            //   PlutoGrid(
            //     columns: columnss,
            //     rows: rowss,
            //     onLoaded: (PlutoGridOnLoadedEvent event) {
            //       stateManager = event.stateManager;
            //       stateManager!.setAutoEditing(true);
            //     },
            //   )
            // }
            //],
          ),

          //     FutureBuilder(
          //   future: delay2(),
          //   builder: (BuildContext context, snapshot) {
          //     if (snapshot.hasData) {
          //       return TabBarView(
          //         controller: tabController,
          //         children: getWidgets(),
          //       );
          //     } else {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // ),
        ),
        // )
      ],
    );
  }

  List<PlutoColumn> columnss = [
    /// Text Column definition
    PlutoColumn(
      title: 'text column',
      field: 'text_field',
      type: PlutoColumnType.text(),
    ),

    /// Number Column definition
    PlutoColumn(
      title: 'number column',
      field: 'number_field',
      type: PlutoColumnType.number(),
    ),

    /// Select Column definition
    PlutoColumn(
      title: 'select column',
      field: 'select_field',
      type: PlutoColumnType.select(['item1', 'item2', 'item3']),
    ),

    /// Datetime Column definition
    PlutoColumn(
      title: 'date column',
      field: 'date_field',
      type: PlutoColumnType.date(),
    ),

    /// Time Column definition
    PlutoColumn(
      title: 'time column',
      field: 'time_field',
      type: PlutoColumnType.time(),
    ),
  ];

  List<PlutoRow> rowss = [
    PlutoRow(
      cells: {
        'text_field': PlutoCell(value: 'Text cell value1'),
        'number_field': PlutoCell(value: 2020),
        'select_field': PlutoCell(value: 'item1'),
        'date_field': PlutoCell(value: '2020-08-06'),
        'time_field': PlutoCell(value: '12:30'),
      },
    ),
    PlutoRow(
      cells: {
        'text_field': PlutoCell(value: 'Text cell value2'),
        'number_field': PlutoCell(value: 2021),
        'select_field': PlutoCell(value: 'item2'),
        'date_field': PlutoCell(value: '2020-08-07'),
        'time_field': PlutoCell(value: '18:45'),
      },
    ),
    PlutoRow(
      cells: {
        'text_field': PlutoCell(value: 'Text cell value3'),
        'number_field': PlutoCell(value: 2022),
        'select_field': PlutoCell(value: 'item3'),
        'date_field': PlutoCell(value: '2020-08-08'),
        'time_field': PlutoCell(value: '23:59'),
      },
    ),
  ];

  criaTabViewTabela(int widgetNumber) {
    rows.clear();
    columns.clear();
    listaTIT.clear();
    teste4.clear();
    teste5.clear();

    separarArquivo = "";
    try {
      String? recebeTabela;

      separarArquivo = conteudoArquivo;

      debugPrint("Numero da tab: $widgetNumber");

      for (int i = 0; i < nomeTabelas.length; i++) {
        int contador = widgetNumber + 1;
        String start = 'TIT ${nomeTabelas[widgetNumber]}#';

        if (contador == nomeTabelas.length) {
          contador = contador - 1;

          final startIndex = separarArquivo.indexOf(start);

          recebeTabela = separarArquivo.substring(
              startIndex + start.length, separarArquivo.length);
        } else {
          String end = 'TIT ${nomeTabelas[contador]}#';

          final startIndex = separarArquivo.indexOf(start);

          final endIndex =
              separarArquivo.indexOf(end, startIndex + start.length);

          recebeTabela =
              separarArquivo.substring(startIndex + start.length, endIndex);
        }
      }

      List<String> linhasTIT = recebeTabela!.split("\r\n");
      nomeColunas = linhasTIT[0].split('|');

      columns = <PlutoColumn>[
        for (int contCol = 0; contCol < nomeColunas.length; contCol++) ...{
          PlutoColumn(
            textAlign: PlutoColumnTextAlign.center,
            title: nomeColunas[contCol],
            field: contCol.toString(),
            type: PlutoColumnType.text(),
          ),
        }
      ];

      for (int i = 1; i < linhasTIT.length; i++) {
        if (linhasTIT[i] != "") {
          String testeP = linhasTIT[i];
          teste4 = [testeP.split('CPO ').toString()];

          for (int p = 0; p < teste4.length; p++) {
            teste5 = teste4[p].split('^');

            rows.addAll([
              PlutoRow(
                cells: {
                  for (int contRow = 0; contRow < teste5.length; contRow++) ...{
                    contRow.toString(): PlutoCell(value: teste5[contRow]),
                  },
                },
              ),
            ]);
          }
          testeP = "";
        }
      }

      linhasTIT.clear();
    } catch (e) {
      debugPrint("$e");
    }

    return PlutoGrid(
      configuration: configuracaoPlutoGrid,
      columns: columns,
      rows: rows,
      onChanged: (PlutoGridOnChangedEvent event) {
        if (kDebugMode) {
          print("Valor célula editada: ${event.value}");
          print("Valor célula anterior: ${event.oldValue}");
          print("Nome Coluna: ${event.column!.title}");
          print("Posição célula editada: ${event.rowIdx}");
          print("\n=======================================\n");
        }
      },
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager!.setAutoEditing(true);
      },
      createFooter: (stateManager) {
        return Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 30,
                child: const Text("Dicionário"),
              ),
            ),
          ],
        );
      },
    );
  }

  AnimatedContainer barraFiltro() {
    return AnimatedContainer(
      alignment: Alignment.centerLeft,
      height: height,
      duration: const Duration(milliseconds: 550),
      color: white,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  SizedBox(
                    height: 40,
                    width: 500,
                    child: TextFormField(
                      controller: controlePesquisa,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(40),
                      ],
                      decoration: styleBarraPesquisa(cor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              width: 100,
              alignment: Alignment.centerLeft,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    style: estiloBotao,
                    child: const Text("Pesquisar"),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Container(
              width: 200,
              alignment: Alignment.centerLeft,
              child: ListView(
                children: [
                  Container(
                    decoration: boxSelecao1(opcaoEscolhida),
                    child: RadioListTile(
                      activeColor: purple,
                      groupValue: opcaoEscolhida,
                      onChanged: (String? value) {
                        setState(() {
                          opcaoEscolhida = value;

                          if (kDebugMode) {
                            print("Filtro escolhido: $opcaoEscolhida");
                          }
                        });
                      },
                      value: FiltroOpcao.estacao.name,
                      title: const Text('Estação'),
                    ),
                  ),
                  Container(
                    decoration: boxSelecao2(opcaoEscolhida),
                    child: RadioListTile(
                      activeColor: purple,
                      groupValue: opcaoEscolhida,
                      onChanged: (String? value) {
                        setState(() {
                          opcaoEscolhida = value;

                          if (kDebugMode) {
                            print("Filtro escolhido: $opcaoEscolhida");
                          }
                        });
                      },
                      value: FiltroOpcao.conteudo.name,
                      title: const Text('Conteúdo'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: SizedBox(
              width: 280,
              child: ListView(
                children: [
                  Container(
                    decoration: boxSelecao4(opcaoEscolhida),
                    child: RadioListTile(
                      activeColor: purple,
                      groupValue: opcaoEscolhida,
                      onChanged: (String? value) {
                        setState(() {
                          opcaoEscolhida = value;

                          if (kDebugMode) {
                            print("Filtro escolhido: $opcaoEscolhida");
                          }
                        });
                      },
                      value: FiltroOpcao.mensagem.name,
                      title: const Text('Descrição Tabela Dicionário'),
                    ),
                  ),
                  Container(
                    decoration: boxSelecao3(opcaoEscolhida),
                    child: RadioListTile(
                      activeColor: purple,
                      groupValue: opcaoEscolhida,
                      onChanged: (String? value) {
                        setState(() {
                          opcaoEscolhida = value;

                          if (kDebugMode) {
                            print("Filtro escolhido: $opcaoEscolhida");
                          }
                        });
                      },
                      value: FiltroOpcao.subTitulo.name,
                      title: const Text('SubTítulo'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox barraPrincipal() {
    return SizedBox(
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
                            onPressed: () {
                              arquivoAbrirSeparar();
                            },
                            style: estiloBotao,
                            child: const Text("Abrir"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              gravarArquivo();
                            },
                            style: estiloBotao,
                            child: const Text("Salvar"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              expandeContainer();
                            },
                            style: estiloBotao,
                            child: const Text("Pesquisar"),
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
    );
  }
}
