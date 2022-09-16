//isso aqui da pra usar no filtro
import 'package:editorconfiguracao/projeto_completo/tabelas/corpo_tabela/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

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

// isso pega o valor da celula
void handleSelected(var context) async {
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
      });
}
