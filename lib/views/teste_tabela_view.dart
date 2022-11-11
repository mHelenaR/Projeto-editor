// ignore_for_file: unused_local_variable, avoid_print

import 'dart:async';

import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/nome_tabelas.dart';
import 'package:editorconfiguracao/test/separa_arq.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_pluto_grid.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';

class TesteTabela extends StatefulWidget {
  const TesteTabela({super.key});

  @override
  State<TesteTabela> createState() => _TesteTabelaState();
}

class _TesteTabelaState extends State<TesteTabela>
    with TickerProviderStateMixin {
  List<Widget> tabTeste = [];
  List<String> chaves = [];

  TabController getTabController() {
    return TabController(length: tabTeste.length, vsync: this);
  }

  late TabController tabController;

  bool ativaTabela = false;

  @override
  void initState() {
    ativaTabela = false;
    tabController = getTabController();
    super.initState();
  }

  List<String> tabelasArquivo = [];

  criaTabViewTabela(int widgetNumber) async {
    try {
      String? recebeTabela;

      String conteudoArquivo = await converteArquivo('C:\\frente\\config.cfg');

      List<String> nomeTabelas = await nomeTabelasArquivo(conteudoArquivo);

      separarArquivo = conteudoArquivo;

      debugPrint("Numero da tab: $widgetNumber");

      for (int i = 0; i < nomeTabelas.length; i++) {
        int contador = widgetNumber + 1;

        String start = 'TIT ${nomeTabelas[widgetNumber]}#';

        tabelasArquivo.addAll([nomeTabelas[i]]);

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
          String recebeLinhas = linhasTIT[i];
          recebeCPO = recebeLinhas.split('CPO ');

          for (int p = 1; p < recebeCPO.length; p++) {
            celulaCPO = recebeCPO[p].split('^');

            objEstacaoModel.setVerificaRow = celulaCPO;

            rows.addAll([
              PlutoRow(cells: {
                for (int contRow = 0;
                    contRow < celulaCPO.length;
                    contRow++) ...{
                  contRow.toString(): PlutoCell(value: celulaCPO[contRow]),
                },
              }),
            ]);
          }
          recebeLinhas = "";
        }
      }
    } catch (e) {
      debugPrint("$e");
    }

    // return PlutoGrid(
    //   mode: PlutoGridMode.normal,
    //   configuration: configuracaoPlutoGrid,
    //   columns: columns,
    //   rows: rows,
    // );
  }

  String conteudoArquivo = '';
  List<String> nomeTabelas = [];

  List<Widget> tabelasConfig() {
    List<Map<dynamic, dynamic>> mapaConfig = [];
    List<Map<dynamic, dynamic>> mapaConfig1 = [];
    List<Map<dynamic, dynamic>> mapaConfig2 = [];
    List<dynamic> linhasTIT = [];
    List<dynamic> coluna1 = [];
    List<PlutoRow> linhas1 = [];

    List<Widget> criarWidgets = [];
    List<PlutoColumn> coluna = [];
    criarWidgets.clear();

    String? recebeTabela;

    separarArquivo = conteudoArquivo;

    //=====================================================================

    // for (int i = 0; i < coluna1.length; i++) {
    //   coluna.addAll([
    //     PlutoColumn(
    //         title: coluna1[i], field: '$i', type: PlutoColumnType.text())
    //   ]);
    // }
    //=====================================================================

    for (int i = 0; i < nomeTabelas.length; i++) {
      int contador = i + 1;

      String start = 'TIT ${nomeTabelas[i]}#';
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

      List<String> linhasTIT = [recebeTabela];

      for (var i = 0; i < linhasTIT.length; i++) {
        String tabela = linhasTIT[i];

        List<String> recebeTabelaw = tabela.split('\r\n');

        for (var j = 0; j < recebeTabelaw.length; j++) {
          if (j == 0) {
            List<String> nomes = recebeTabelaw[j].split('|');

            coluna = [
              for (int m = 0; m < nomes.length; m++) ...{
                PlutoColumn(
                  title: nomes[m],
                  field: '$m',
                  type: PlutoColumnType.text(),
                ),
              }
            ];
          } else {
            if (recebeTabelaw[j] != "") {
              List<String> re = recebeTabelaw[j].split('CPO ');

              for (var p = 1; p < re.length; p++) {
                if (re[p] != '') {
                  List<String> celula = re[p].split('^');

                  linhas1.addAll([
                    PlutoRow(
                      cells: {
                        for (int o = 0; o < celula.length; o++) ...{
                          '$o': PlutoCell(value: celula[o]),
                        }
                      },
                    )
                  ]);
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
                ),
              ),
            )
          ],
        ));
        linhas1 = [];
      }
    }

    setState(() {
      ativaTabela = true;
    });
    return criarWidgets;
  }

  int cont = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ElevatedButton(
          onPressed: () async {
            conteudoArquivo = await converteArquivo('C:\\frente\\config.cfg');
            nomeTabelas = await nomeTabelasArquivo(conteudoArquivo);

            setState(() {
              tabTeste.clear();

              for (var i = 0; i < nomeTabelas.length; i++) {
                tabTeste.add(Tab(
                  text: nomeTabelas[i],
                ));
              }
              cont = cont + 1;

              if (ativaTabela) {
                ativaTabela = false;
              }

              Timer(const Duration(seconds: 1), tabelasConfig);

              tabController =
                  TabController(length: tabTeste.length, vsync: this);
            });
          },
          child: const Text('tabela'),
        ),
        ElevatedButton(
            onPressed: () {
              tabController.index = 30;
            },
            child: const Text('Pular')),
        ElevatedButton(
            onPressed: () {
              setState(() {
                ativaTabela = false;
              });
            },
            child: const Text('Pular')),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Flexible(
                child: AppBar(
                  title: TabBar(
                    isScrollable: true,
                    controller: tabController,
                    tabs: tabTeste,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (ativaTabela == true) ...{
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: tabelasConfig(),
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
