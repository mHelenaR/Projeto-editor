// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_pluto_grid.dart';

Tab nomeTab(int widgetNumber) {
  // setState(() {
  //   widgetNumber;
  // });

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

retornaColuna(int widgetNumber) {
  rows.clear();
  columns.clear();
  listaTIT.clear();
  teste4.clear();
  teste5.clear();

  separarArquivo = "";

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

      final endIndex = separarArquivo.indexOf(end, startIndex + start.length);

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

  return columns;
}

retornaLinha(int widgetNumber) {
  rows.clear();
  columns.clear();
  listaTIT.clear();
  teste4.clear();
  teste5.clear();

  separarArquivo = "";

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

      final endIndex = separarArquivo.indexOf(end, startIndex + start.length);

      recebeTabela =
          separarArquivo.substring(startIndex + start.length, endIndex);
    }
  }

  List<String> linhasTIT = recebeTabela!.split("\r\n");
  nomeColunas = linhasTIT[0].split('|');

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
  return rows;
}

Widget criaTabViewTabela(int widgetNumber) {
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

        final endIndex = separarArquivo.indexOf(end, startIndex + start.length);

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
  var mapa = Map();
  return PlutoGrid(
    configuration: configuracaoPlutoGrid,
    columns: columns,
    rows: rows,
    onChanged: (PlutoGridOnChangedEvent event) {
      mapa = {
        nomeTabelas[tabController.index]: {
          event.column!.title: {event.rowIdx: event.value}
        }
      };

      print(mapa);
      // if (kDebugMode) {
      //   print("Valor célula editada: ${event.value}");
      //   print("Valor célula anterior: ${event.oldValue}");
      //   print("Nome Coluna: ${event.column!.title}");
      //   print("Posição célula editada: ${event.rowIdx}");
      //   print("\n=======================================\n");
      // }
    },
    onLoaded: (PlutoGridOnLoadedEvent event) {
      stateManager = event.stateManager;
      stateManager!.setAutoEditing(true);
      // event.stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
      // sort(stateManager!);
      // pri(stateManager!);
      // stateManager!.setSelectingMode(PlutoGridSelectingMode.none);

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
