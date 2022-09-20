import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/projeto_completo/separa_arquivo/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/nome_tabelas.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/seleciona_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/box_container.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_borderRadius.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_fontes.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_pluto_grid.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_tabBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_textField.dart';
import 'package:editorconfiguracao/projeto_completo/tabelas/models/variaveis.dart';

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

  void expandeContainer() {
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
      caminhoArquivo = await arquivoTabela();
      setState(() {
        controleArquivo.text = caminhoArquivo!;
      });
      if (caminhoArquivo != null) {
        recebeCaminhoArquivo = caminhoArquivo!;

        conteudoArquivo = await converteArquivo(recebeCaminhoArquivo);

        setState(() {
          conteudoArquivo;
        });

        nomeTabelas = await nomeTabelasArquivo(conteudoArquivo);

        nomeTab(nomeTabelas.length);

        tabs = criaTab(nomeTabelas.length);

        setState(() {
          getWidgets();
          tabController = TabController(length: tabs.length, vsync: this);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Tab nomeTab(int widgetNumber) {
    setState(() {
      widgetNumber;
    });

    if (widgetNumber == nomeTabelas.length) {
      widgetNumber = widgetNumber - 1;
    }

    return Tab(text: nomeTabelas[widgetNumber]);
  }

  List<Tab> criaTab(int count) {
    tabs.clear();

    for (int i = 0; i < count; i++) {
      tabs.add(nomeTab(i));
    }

    return tabs;
  }

  List<Widget> getWidgets() {
    criarWidgets.clear();

    for (int i = 0; i < tabs.length; i++) {
      criarWidgets.add(carregarTela(i));
    }

    return criarWidgets;
  }

  carregarTela(var controle) {
    return FutureBuilder(
      future: delay(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return criaTabViewTabela(controle);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<String> delay() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Aguarde!\n Carregando tabelas!';
  }

  Future<String> delay2() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Aguarde!\n Carregando tabelas!';
  }

  Widget criaTabViewTabela(int widgetNumber) {
    rows.clear();
    columns.clear();
    listaTIT.clear();
    nomeColunas.clear();
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
                  for (contRow = 0; contRow < teste5.length; contRow++) ...{
                    contRow.toString(): PlutoCell(value: teste5[contRow]),
                  },
                },
              ),
            ]);
          }
          testeP = "";
        }
      }
      contCol = 0;
      contRow = 0;
    } catch (e) {
      debugPrint("$e");
    }
    return PlutoGrid(
      configuration: configuracaoPlutoGrid,
      columns: columns,
      rows: rows,
      onChanged: (PlutoGridOnChangedEvent event) {
        debugPrint("$event");
      },
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        sort(stateManager!);
        pri(stateManager!);
        // stateManager!.setSelectingMode(PlutoGridSelectingMode.none);
        stateManager!.setKeepFocus(false);
        // //stateManager = event.stateManager;
        // stateManager?.clearCurrentSelecting();
        // //stateManager?.updateVisibilityLayout();

        // stateManager?.clearCurrentCell();
        // stateManager?.notifyListeners();
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

  void sort(PlutoGridStateManager manager) {
    List<String> cont = [];
    cont.clear();
    for (int i = 0; i < teste5.length; i++) {
      cont = cont + [i.toString()];
    }

    var p = Map.fromEntries(
      cont.asMap().entries.map<MapEntry<String, int>>(
          (entry) => MapEntry(entry.value, entry.key)),
    );
    debugPrint("${cont.length}");
    manager.refColumns.sort((a, b) {
      if (p.containsKey(a.field) && p.containsKey(b.field)) {
        return p[a.field]!.compareTo(p[b.field]!);
      }
      return 0;
    });

    manager.updateVisibilityLayout();
    manager.clearCurrentCell();
    manager.notifyListeners();
  }

//isso aqui da pra usar no filtro
  void handleFocusToIndex() {
    int rowIdx = 2;

    int cellIdx = 0;

    PlutoCell cell =
        stateManager!.rows[rowIdx].cells.entries.elementAt(cellIdx).value;
    stateManager!.setCurrentCell(cell, rowIdx);
    stateManager!.moveScrollByRow(PlutoMoveDirection.up, rowIdx + 1);
    stateManager!.moveScrollByColumn(PlutoMoveDirection.left, cellIdx + 1);
    rowIdx = rowIdx + rowIdx;
  }

// isso pega o valor da celul
  void handleSelected() async {
    String value = '';

    for (var element in stateManager!.currentSelectingPositionList) {
      final cellValue = stateManager!
          .rows[element.rowIdx!].cells[element.field!]!.value
          .toString();

      value += ' field: ${stateManager!.columns}, value: $cellValue\n';
    }

    if (value.isEmpty) {
      value = 'No cells are selected.';
    }

    await showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          child: LayoutBuilder(
            builder: (ctx, size) {
              return Container(
                padding: const EdgeInsets.all(15),
                width: 400,
                height: 500,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(value),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void pri(var state) {
    String value = '';
    for (var element in state!.currentSelectingPositionList) {
      final cellValue =
          state!.rows[element.rowIdx!].cells[element.field!]!.value.toString();

      value += ' field: ${state!.columns}, value: $cellValue\n';
    }
    debugPrint(value);
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
          child: Container(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
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
          ),
        )
      ],
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
                    onPressed: () {
                      pri(stateManager!);
                      //andleFocusToIndex();
                      // handleSelected();
                    },
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
                      value: FiltroOpcao.descicaoDicionario.name,
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
}

enum FiltroOpcao {
  subTitulo,
  conteudo,
  tituloDicionario,
  estacao,
  descicaoDicionario;
}
