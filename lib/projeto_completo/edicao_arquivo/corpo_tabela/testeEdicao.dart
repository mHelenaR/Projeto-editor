// ignore_for_file: avoid_print

import 'package:dropdown_search/dropdown_search.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/nome_tabelas.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/salvar_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/seleciona_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/filtro/filtro_principal.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/box_container.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_borderRadius.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_fontes.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_pluto_grid.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_tabBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_textField.dart';

class TelaEdicao1 extends StatefulWidget {
  const TelaEdicao1({super.key});

  @override
  State<TelaEdicao1> createState() => _TelaEdicao1State();
}

class _TelaEdicao1State extends State<TelaEdicao1>
    with TickerProviderStateMixin {
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
    await Future.delayed(const Duration(milliseconds: 200));
    return 'Aguarde!\n Carregando tabelas!';
  }

  metodoContador(int valor, var tabela) {
    int contador = valor + 1;
    if (contador == tabela.length) {
      return contador = contador - 1;
    } else {
      return contador;
    }
  }

  leitura(var lista, var contador) {
    int col = lista.length - 1;
    if (contador == col) {
      return true;
    } else {
      return false;
    }
  }

  List<String> transformaString(List<String> listaColunasARQ) {
    List<String> lista = [];
    List<String> cols = listaColunasARQ[0].split('|');

    int cont = cols.length - 2;

    for (var i = 0; i < cols.length; i++) {
      if (i <= cont) {
        String neww = cols[i];
        String valor = neww.substring(0, neww.length - 2);

        String upper = valor.toUpperCase();
        lista = lista + [upper];
      }
    }

    return lista;
  }

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
      nomeColunasDicionario = transformaString(linhasTIT);
      nomeSubtituloDicionario = transformaString(linhasTIT);
      List<Map<dynamic, dynamic>> map = objSqlite.tabelasCompletas;
      for (var i = 0; i < map.length; i++) {
        Map mapas = map[i];
        for (var element in mapas.entries) {
          for (var j = 0; j < nomeColunasDicionario.length; j++) {
            if (element.value['campo'] == nomeColunasDicionario[j]) {
              nomeColunasDicionario[j] = element.value['mensagem'];
              nomeSubtituloDicionario[j] = element.value['titulo'];
            }
          }
        }
      }
      //print(nomeColunas);
      columns = <PlutoColumn>[
        for (int contCol = 0; contCol < nomeColunas.length; contCol++) ...{
          PlutoColumn(
            titleSpan: TextSpan(
              text: nomeColunas[contCol],
              recognizer: TapGestureRecognizer()..onTap = () => print(contCol),
            ),
            titleTextAlign: PlutoColumnTextAlign.center,
            readOnly: leitura(nomeColunas, contCol),
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
          teste4 = testeP.split('CPO ');

          for (int p = 1; p < teste4.length; p++) {
            teste5 = teste4[p].split('^');

            rows.addAll([
              PlutoRow(cells: {
                for (int contRow = 0; contRow < teste5.length; contRow++) ...{
                  contRow.toString(): PlutoCell(value: teste5[contRow]),
                },
              }),
            ]);
          }
          testeP = "";
        }
      }
    } catch (e) {
      debugPrint("$e");
    }

    var mapa = {};
    return PlutoGrid(
      mode: PlutoGridMode.normal,
      configuration: configuracaoPlutoGrid,
      columns: columns,
      rows: rows,
      createHeader: (stateManager) {
        return Row(
          children: [
            SizedBox(
              height: 60,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                    showSearchBox: true,
                  ),
                  items: nomeSubtituloDicionario,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Subtítulo",
                      hintText: "Subtítulo do campo",
                    ),
                  ),
                  onChanged: print,
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                    showSearchBox: true,
                  ),
                  items: nomeColunasDicionario,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Descrição",
                      hintText: "Descrição do campo",
                    ),
                  ),
                  onChanged: print,
                ),
              ),
            ),
          ],
        );
      },
      onChanged: (PlutoGridOnChangedEvent event) {
        int rowIndex = event.rowIdx! + 1;
        mapa = {
          'tabelaInicial': nomeTabelas[tabController.index],
          'tabelaFinal':
              nomeTabelas[metodoContador(tabController.index, nomeTabelas)],
          'coluna': nomeColunas[event.columnIdx!],
          'colunaIndex': event.columnIdx,
          'linhaIndex': rowIndex,
          'novoValor': event.value,
        };

        recebeMapa.addAll([mapa]);
      },
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager!.setAutoEditing(true);

        event.stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
        // setState(() {
        //   print(event.stateManager.currentCell);
        //   print(event.stateManager.currentRow);
        //   print(event.stateManager.currentSelectingRows);
        //   print(event.stateManager.currentCellPosition);

        // });

        stateManager!.notifyListeners();
        // stateManager!.keyManager!.subject.listen((PlutoKeyManagerEvent value) {
        //   // if (value.isKeyDownEvent && value.isEnter) {
        //   print(stateManager!.currentColumn!.field);
        //   // }
        // });
      },
    );
  }

  Future<String> delay2() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Aguarde!\n Carregando tabelas!';
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