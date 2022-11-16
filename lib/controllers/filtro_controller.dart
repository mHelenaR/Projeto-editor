import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/models/keys_model.dart';
import 'package:editorconfiguracao/utils/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';

class FiltroController {
  // Busca o indice da celula na tabela
  void focarColuna(var position) {
    int rowIdx = 0;

    int cellIdx = 0;
    for (int i = 0; i < nomeColunasDicionario.length; i++) {
      var recebeLista = nomeColunasDicionario[i];
      for (var j = 0; j < recebeLista.length; j++) {
        if (position == recebeLista[j]) {
          cellIdx = j;
        }
      }
    }
    if (stateManager!.rows.isNotEmpty) {
      stateManager!.clearCurrentCell();
      PlutoCell cell =
          stateManager!.rows[rowIdx].cells.entries.elementAt(cellIdx).value;
      stateManager!.setCurrentCell(cell, rowIdx);
      stateManager!.moveScrollByRow(PlutoMoveDirection.up, rowIdx + 1);
      stateManager!.moveScrollByColumn(PlutoMoveDirection.left, cellIdx + 1);
      stateManager!.notifyListeners();
    }
  }

  //Cria uma lista com o nome dos campos do dicionário baseado no arquivo
  void mapaCompletoDicionario(List<String> linhasTabela) {
    List<Map<dynamic, dynamic>> map = objSqlite.tabelasCompletas;
    nomeSubtituloDicionario = toUpperRow(linhasTabela);

    List<String> nomeColDicio = toUpperRow(linhasTabela);

    for (var i = 0; i < map.length; i++) {
      Map mapas = map[i];

      for (var element in mapas.entries) {
        for (var j = 0; j < nomeColDicio.length; j++) {
          if (element.value['campo'] == nomeColDicio[j]) {
            nomeColDicio[j] = element.value['campo'];
            nomeSubtituloDicionario[j] = element.value['titulo'];
          }
        }
      }
    }

    nomeColunasDicionario.addAll([nomeColDicio]);
  }

  //Retorna uma lista no padrão dos campos da tabela dicionario
  List<String> toUpperRow(List<String> listaColunasARQ) {
    List<String> lista = [];
    List<String> cols = listaColunasARQ[0].split('|');

    //retira o espaço em branco no final da lista
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

  //Método criador dos mapas para o DropDown da estação
  Future<List<FilterModel>> mapaFiltro(var escolha) async {
    List<Map<String, dynamic>> listaMapaFiltro = [];

    Map mapasFiltro = {};

    List<Map<dynamic, dynamic>> recebeListaMapa = [];

    List<String> tabelaNome = [];

    if (escolha != null) {
      if (escolha == "Descrição" || escolha == 'Subtítulo') {
        // Limpa as chaves do dropDown não selecionado
        if (escolha == 'Descrição') {
          DropKey.estacKeyColuna.currentState!.clear();
          DropKey.estacKeySubtitulo.currentState!.clear();
        } else if (escolha == 'Subtítulo') {
          DropKey.estacKeyColuna.currentState!.clear();
          DropKey.estacKeyDescricao.currentState!.clear();
        }

        recebeListaMapa = await objSqlite.tabelasCompletas;

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
      } else if (escolha == 'Coluna') {
        //Limpa as chaves do dropDown não selecionado
        if (DropKey.estacKeyDescricao.currentState != null ||
            DropKey.estacKeySubtitulo.currentState != null) {
          DropKey.estacKeyDescricao.currentState!.clear();
          DropKey.estacKeySubtitulo.currentState!.clear();
        }
        recebeListaMapa = await objEstacaoModel.colunasMapa;

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
      } else if (escolha == 'Estação') {
        recebeListaMapa = await objEstacaoModel.mapaEstacao;

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
      } else if (escolha == "Dicionario") {
        recebeListaMapa = await objSqlite.tabelasCompletas;

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
                  "posicao": i.toString(),
                  "dicionario": true,
                },
              ],
            );
          }
        }
      } else if (escolha == "Focar Tabelas") {
        tabelaNome = await objEstacaoModel.tabelasNome;

        for (var i = 0; i < tabelaNome.length; i++) {
          listaMapaFiltro.addAll(
            [
              {
                'tabela': tabelaNome[i],
                'posicao': i.toString(),
              },
            ],
          );
        }
      } else if (escolha == "Dicio. Descrição" ||
          escolha == "Dicio. Subtítulo") {
        if (escolha == 'Dicio. Descrição') {
          DropKey.dicioSubtitulo.currentState!.clear();
        } else if (escolha == 'Dicio. Subtítulo') {
          DropKey.dicioDescricao.currentState!.clear();
        }

        recebeListaMapa = await objSqlite.tabelasCompletas;

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

  List<String> transformaString(List<String> listaColunasARQ) {
    List<String> lista = [];
    List<String> colunas = listaColunasARQ;

    try {
      //retira o espaço em branco no final da linha
      int cont = colunas.length - 2;

      for (var i = 0; i < colunas.length; i++) {
        if (i <= cont) {
          String celula = colunas[i];

          //Retira o número no final de cada item
          String valor = celula.substring(0, celula.length - 2);

          String upper = valor.toUpperCase();
          lista = lista + [upper];
        }
      }
    } on Exception catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }

    return lista;
  }

  //Filtro de pesquisa por estacao / foco na célula
  void focarCelulaFiltro(var position, var indexRow, bool? isDictionary) {
    try {
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
        /** Percorre a lista de mapas da tabela dicionário
          * passando o indice da coluna escolhida
          */
        for (int i = 0; i < recebeListaMapa.length; i++) {
          mapasFiltro = recebeListaMapa[i];

          for (var element in mapasFiltro.entries) {
            if (element.key == 'estac') {
              colunasEstac.addAll([element.value['campo']]);
            }
          }
        }

        //Formata a lista de colunas do arquivo, para comparar com o dicionário
        List<String> col = transformaString(colunasArquivoEstac);

        // Compara as colunas do arquivo com o dicionário para passar a posição
        for (int j = 0; j < col.length; j++) {
          if (position == col[j]) {
            for (int i = 0; i < colunasEstac.length; i++) {
              if (col[j] == colunasEstac[i]) {
                cellIdx = j;
              }
            }
          }
        }
      } else if (isDictionary == false) {
        colunasEstac = colunasArquivoEstac;

        // Pega a posição da célula com o nome da coluna
        for (int i = 0; i < colunasEstac.length; i++) {
          if (position == colunasEstac[i]) {
            cellIdx = i;
          }
        }
      }

      rowIdx = indexRow;

      PlutoCell cell =
          stateManager!.rows[rowIdx].cells.entries.elementAt(cellIdx).value;
      stateManager!.setCurrentCell(cell, rowIdx);
      stateManager!.moveScrollByRow(PlutoMoveDirection.up, rowIdx + 1);
      stateManager!.moveScrollByColumn(PlutoMoveDirection.left, cellIdx + 1);
      stateManager!.notifyListeners();
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
