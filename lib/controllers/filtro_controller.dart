// ignore_for_file: avoid_print

import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/models/keys_model.dart';
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

  //Filtro de pesquisa por estacao / foco na célula
  void focarCelulaFiltroEstacao(
    var position,
    var indexRow,
    bool? isDictionary,
  ) {
    int rowIdx = 0;
    int cellIdx = 0;

    List<String> colunasEstac = [];

    /* Mapa com o nome de todas as colunas da tabela estação */
    List<String> colunasArquivoEstac = objEstacaoModel.colunasFiltro;

    /* Mapa com o dicionário completo */
    List<Map<dynamic, dynamic>> recebeListaMapa = objSqlite.tabelasCompletas;

    Map mapasFiltro = {};

    //Verifica se o dropdown selecionado é da tabela dicionário ou do arquivo
    if (isDictionary == true) {
      /**
       * Percorre a lista de mapas da tabela dicionário
       * passando o indice da coluna escolhida
       */
      for (var i = 0; i < recebeListaMapa.length; i++) {
        mapasFiltro = recebeListaMapa[i];

        for (var element in mapasFiltro.entries) {
          if (element.key == 'estac') {
            colunasEstac.addAll([element.value['campo']]);
          }
        }
      }
    } else if (isDictionary == false) {
      colunasEstac = colunasArquivoEstac;
    }

    // Pega a posição da célula com o nome da coluna
    for (int i = 0; i < colunasEstac.length; i++) {
      if (position == colunasEstac[i]) {
        cellIdx = i;
      }
    }

    rowIdx = indexRow;

    PlutoCell cell =
        stateManager!.rows[rowIdx].cells.entries.elementAt(cellIdx).value;
    stateManager!.setCurrentCell(cell, rowIdx);
    stateManager!.moveScrollByRow(PlutoMoveDirection.up, rowIdx + 1);
    stateManager!.moveScrollByColumn(PlutoMoveDirection.left, cellIdx + 1);
    stateManager!.notifyListeners();
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
          if (element.key == 'estac') {
            listaMapaFiltro.addAll(
              [
                {
                  "tabela": element.key,
                  "coluna": element.value["campo"],
                  "titulo": element.value['titulo'],
                  "mensagem": element.value['mensagem'],
                  "posicao": i.toString(),
                  "dicionario": true,
                },
              ],
            );
          }
        }
      }

      return FilterModel.fromJsonList(listaMapaFiltro);
    } else {
      return [];
    }
  }

  //// originais

  // Mapa das estações para do dropdown
  Future<List<FilterModel>> mapaEstacao(var escolha) async {
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
                "dicionario": false,
              }
            ],
          );
        }
      }

      return FilterModel.fromJsonList(listaMapaFiltro);
    } else {
      return [];
    }
  }

  Future<List<FilterModel>> mapaColunasModel(var escolha) async {
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
                "dicionario": false,
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

  Future<List<FilterModel>> mapaDicionarioModel1(var escolha) async {
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
}
