import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/models/keys_model.dart';
import 'package:editorconfiguracao/widgets/radio_widget.dart';
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

// teste
  void handleFocusTESTE(var position, var row) {
    int rowIdx = 0;

    int cellIdx = 0;
    for (int i = 0; i < nomeColunasDicionario.length; i++) {
      if (position == nomeColunasDicionario[i]) {
        cellIdx = i;
      }
    }
    rowIdx = row;
    PlutoCell cell =
        stateManager!.rows[rowIdx].cells.entries.elementAt(cellIdx).value;
    stateManager!.setCurrentCell(cell, rowIdx);
    stateManager!.moveScrollByRow(PlutoMoveDirection.up, rowIdx + 1);
    stateManager!.moveScrollByColumn(PlutoMoveDirection.left, cellIdx + 1);
    stateManager!.notifyListeners();
  }

  void handleFocusTESTE1(var position, var row) {
    int rowIdx = 0;

    int cellIdx = 0;
    var colunasEstac = objEstacaoModel.colunasFiltro;

    for (int i = 0; i < colunasEstac.length; i++) {
      if (position == colunasEstac[i]) {
        cellIdx = i;
      }
    }
    rowIdx = row;
    PlutoCell cell =
        stateManager!.rows[rowIdx].cells.entries.elementAt(cellIdx).value;
    stateManager!.setCurrentCell(cell, rowIdx);
    stateManager!.moveScrollByRow(PlutoMoveDirection.up, rowIdx + 1);
    stateManager!.moveScrollByColumn(PlutoMoveDirection.left, cellIdx + 1);
    stateManager!.notifyListeners();
  }

  // Mapa das estações para do dropdown
  Future<List<FilterEstacModel>> mapaEstacao(var escolha) async {
    List<Map<String, dynamic>> listaMapaFiltro = [];

    Map mapasFiltro = {};

    List<Map<String, dynamic>> recebeListaMapa =
        await objEstacaoModel.mapaEstacao;

    if (escolha != null) {
      for (var i = 0; i < recebeListaMapa.length; i++) {
        mapasFiltro = recebeListaMapa[i];

        for (var element in mapasFiltro.entries) {
          listaMapaFiltro.addAll(
            [
              {
                "unidade": element.value["unidade"],
                "estacao": element.value['estacao'],
                "posicao": element.value["posicao"],
              }
            ],
          );
        }
      }

      return FilterEstacModel.fromJsonList(listaMapaFiltro);
    } else {
      return [];
    }
  }

  Future<List<FilterModel>> mapaDicionarioModel(var escolha) async {
    if (escolha == 'Descrição') {
      DropKey.estacKeyColuna.currentState!.clear();
      DropKey.estacKeySubtitulo.currentState!.clear();
    } else if (escolha == 'Subtítulo') {
      DropKey.estacKeyColuna.currentState!.clear();
      DropKey.estacKeyDescricao.currentState!.clear();
    }

    List<Map<String, dynamic>> listaMapaFiltro = [];
    Map mapasFiltro = {};
    List<Map<dynamic, dynamic>> recebeListaMapa =
        await objSqlite.tabelasCompletas;

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

  Future<List<FilterEstacModel>> mapaColunasModel(var escolha) async {
    if (DropKey.estacKeyDescricao.currentState != null ||
        DropKey.estacKeySubtitulo.currentState != null) {
      DropKey.estacKeyDescricao.currentState!.clear();
      DropKey.estacKeySubtitulo.currentState!.clear();
    }

    List<Map<String, dynamic>> listaMapaFiltro = [];
    Map mapasFiltro = {};
    List<Map<dynamic, dynamic>> recebeListaMapa =
        await objEstacaoModel.colunasMapa;

    if (escolha != null) {
      for (var i = 0; i < recebeListaMapa.length; i++) {
        mapasFiltro = recebeListaMapa[i];

        for (var element in mapasFiltro.entries) {
          listaMapaFiltro.addAll(
            [
              {
                "posicao": element.value["posicao"],
                "coluna": element.value['nomeColuna'],
              },
            ],
          );
        }
      }
      return FilterEstacModel.fromJsonList(listaMapaFiltro);
    } else {
      return [];
    }
  }
}
