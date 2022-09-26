// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/criacao_tabs/tabs_create.dart';
import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_pluto_grid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class TesteTabela extends StatefulWidget {
  var contador;
  var caminho;

  TesteTabela({
    Key? key,
    this.contador,
    this.caminho,
  }) : super(key: key);

  @override
  State<TesteTabela> createState() => _TesteTabelaState();
}

class _TesteTabelaState extends State<TesteTabela> {
  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      configuration: configuracaoPlutoGrid,
      columns: [
        PlutoColumn(
          textAlign: PlutoColumnTextAlign.center,
          title: 'teste',
          field: 'teste',
          type: PlutoColumnType.text(),
        ),
      ],
      rows: [
        PlutoRow(
          cells: {
            'teste': PlutoCell(value: 'Teste ${widget.contador}'),
          },
        )
      ],
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
}
