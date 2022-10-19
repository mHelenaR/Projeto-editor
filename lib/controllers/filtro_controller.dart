import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';

class FiltroController {
  // Busca o indice da celula na tabela
  void handleFocusToIndex(var position) {
    int rowIdx = 0;

    int cellIdx = 0;
    for (int i = 0; i < nomeColunasDicionario.length; i++) {
      if (position == nomeColunasDicionario[i]) {
        cellIdx = i;
      }
    }
    PlutoCell cell =
        stateManager!.rows[rowIdx].cells.entries.elementAt(cellIdx).value;
    stateManager!.setCurrentCell(cell, rowIdx);
    stateManager!.moveScrollByRow(PlutoMoveDirection.up, rowIdx + 1);
    stateManager!.moveScrollByColumn(PlutoMoveDirection.left, cellIdx + 1);
    stateManager!.notifyListeners();
  }

  // Mapa do dicionario para o dropDown
  Future<List<Map<String, dynamic>>> mapaDicionario(var escolha) async {
    List<Map<String, dynamic>> listaMapaFiltro = [];
    Map mapasFiltro = {};
    List<Map<dynamic, dynamic>> recebeListaMapa = objSqlite.tabelasCompletas;
    if (escolha != null) {
      for (var i = 0; i < recebeListaMapa.length; i++) {
        mapasFiltro = recebeListaMapa[i];

        for (var element in mapasFiltro.entries) {
          listaMapaFiltro.addAll(
            [
              {
                "tabela": element.key,
                "coluna": element.value["campo"],
                "titulo": element.value['titulo'],
                "mensagem": element.value['mensagem'],
              },
            ],
          );
        }
      }

      return listaMapaFiltro;
    } else {
      return [];
    }
  }

  Future<List<FilterModel>> mapaDicionario1(var escolha) async {
    List<Map<String, dynamic>> listaMapaFiltro = [];
    Map mapasFiltro = {};
    List<Map<dynamic, dynamic>> recebeListaMapa = objSqlite.tabelasCompletas;
    if (escolha != null) {
      for (var i = 0; i < recebeListaMapa.length; i++) {
        mapasFiltro = recebeListaMapa[i];

        for (var element in mapasFiltro.entries) {
          listaMapaFiltro.addAll(
            [
              {
                "tabela": element.key,
                "coluna": element.value["campo"],
                "titulo": element.value['titulo'],
                "mensagem": element.value['mensagem'],
              },
            ],
          );
        }
      }

      return FilterModel.fromJsonList(listaMapaFiltro);
    } else {
      return [];
    }
  }
}
