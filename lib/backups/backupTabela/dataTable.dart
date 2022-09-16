// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/projeto_completo/tabelas/corpo_tabela/variaveis.dart';

Widget criaTabViewTabela(int widgetNumber) {
  rows.clear();
  columns.clear();
  listaTIT.clear();
  nomeColunas.clear();
  teste4.clear();
  teste5.clear();
  colunaData.clear();
  rowData.clear();

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
    colunaData = [
      for (int contCol = 0; contCol < nomeColunas.length; contCol++) ...{
        DataColumn(label: Text(nomeColunas[contCol]))
      }
    ];
    rowData.addAll([
      DataRow(cells: [
        for (contRow = 0; contRow < nomeColunas.length; contRow++) ...{
          DataCell(onTap: () {}, Text(nomeColunas[contRow]))
        },
      ])
    ]);
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
          // rowData.addAll([
          //   DataRow(cells: [
          //     for (contRow = 0; contRow < teste5.length; contRow++) ...{
          //       DataCell(Text(teste5[contRow]))
          //     },
          //   ])
          // ]);
        }
      }
    }
    contCol = 0;
    contRow = 0;
    linhasTIT.clear();
  } catch (e) {
    debugPrint("$e");
  }
  return DataTable(columns: colunaData, rows: rowData);
}
