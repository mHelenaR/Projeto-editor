import 'package:editorconfiguracao/controllers/filtro_controller.dart';
import 'package:editorconfiguracao/controllers/map_estac_controller.dart';
import 'package:editorconfiguracao/utils/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class EdicaoController {
  FiltroController objFiltroController = FiltroController();
  List<dynamic> recebeMapaAlteracoes = [];

  // Cria a lista de Childrens para o tabview
  List<Widget> tabelasConfig(var listaTabs) {
    List<Widget> criarWidgets = [];

    List<Widget> listaWidgets = objEstacaoModel.listaWidget;

    for (int i = 0; i < listaTabs.length; i++) {
      criarWidgets.add(listaWidgets[i]);
    }

    return criarWidgets;
  }

  //Cria uma lista com todas as tabelas e passa para o objeto de edição
  List<Widget> carregarTela() {
    List<Map<dynamic, dynamic>> criaListMapaNomeColunas = [];
    List<PlutoRow> rowsPlutogrid = [];
    List<PlutoColumn> columnsPlutoGrid = [];
    List<Widget> criarWidgets = [];

    Map mapaRecebeAlteracao = {};

    rowsPlutogrid.clear();
    columnsPlutoGrid.clear();
    criarWidgets.clear();

    separarArquivo = conteudoArquivo;

    for (int c = 0; c < nomeTabelas.length; c++) {
      int contador = c + 1;

      String start = 'TIT ${nomeTabelas[c]}#';
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

      List<String> blocosTabelas = [recebeTabela];

      for (var i = 0; i < blocosTabelas.length; i++) {
        String tabela = blocosTabelas[i];

        List<String> linhasTabela = tabela.split('\r\n');

        for (var j = 0; j < linhasTabela.length; j++) {
          if (j == 0) {
            nomeColunas = linhasTabela[j].split('|');

            // MAPA ESTACAO NOME-COLUNAS/POSIÇÃO
            if (nomeTabelas[c] == 'estac') {
              mapaEstacColuna(nomeTabelas, nomeColunas);
            }

            //MAPA completo DICIONARIO
            objFiltroController.mapaCompletoDicionario(linhasTabela);

            columnsPlutoGrid = [
              for (int m = 0; m < nomeColunas.length; m++) ...{
                PlutoColumn(
                  title: nomeColunas[m],
                  field: '$m',
                  type: PlutoColumnType.text(),
                ),
              }
            ];

            //Mapa com nome de todas as colunas e suas posições
            criaListMapaNomeColunas.addAll([
              {
                nomeTabelas[c]: {
                  for (int h = 0; h < nomeColunas.length; h++)
                    {
                      'nomeColuna': nomeColunas[h],
                      'posicao': h.toString(),
                    }
                }
              }
            ]);
          } else {
            if (linhasTabela[j] != "") {
              List<String> splitLinhasCPO = linhasTabela[j].split('CPO ');

              for (var p = 1; p < splitLinhasCPO.length; p++) {
                if (splitLinhasCPO[p] != '') {
                  List<String> celula = splitLinhasCPO[p].split('^');

                  objEstacaoModel.setVerificaRow = celula;

                  rowsPlutogrid.addAll([
                    PlutoRow(
                      cells: {
                        for (int o = 0; o < celula.length; o++) ...{
                          '$o': PlutoCell(value: celula[o]),
                        }
                      },
                    )
                  ]);

                  //MAPA ESTACAO NUMERO/POSICAO DA LINHA
                  if (nomeTabelas[c] == 'estac') {
                    mapaEstacRowPosicao(p, celula);
                  }
                }
              }
            }
          }
        }

        criarWidgets.add(
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: PlutoGrid(
                    columns: columnsPlutoGrid,
                    rows: rowsPlutogrid,
                    onChanged: (PlutoGridOnChangedEvent event) {
                      int rowIndex = event.rowIdx + 1;
                      String nomeColunaEditada = '';

                      //Recebe o mapa que a tab esta focada
                      var mapa = criaListMapaNomeColunas[tabController.index];

                      for (var element in mapa.entries) {
                        var separaMapa = element.value;
                        for (var listaMap in separaMapa) {
                          if (listaMap['posicao'] == '${event.columnIdx}') {
                            //Passa para a variável o nome da coluna editada
                            nomeColunaEditada = listaMap['nomeColuna'];
                          }
                        }
                      }

                      //mapa que recebe as alterações feitas na tabela
                      mapaRecebeAlteracao = {
                        'tabelaInicial': nomeTabelas[tabController.index],
                        'tabelaFinal': nomeTabelas[metodoContador(
                          tabController.index,
                          nomeTabelas,
                        )],
                        'coluna': nomeColunaEditada,
                        'colunaIndex': event.columnIdx,
                        'linhaIndex': rowIndex,
                        'novoValor': event.value,
                      };

                      //Lista de mapas que recebe as alterações
                      recebeMapaAlteracoes.addAll([mapaRecebeAlteracao]);

                      objEdicaoModel.setListaMapasAlteracao =
                          recebeMapaAlteracoes;
                    },
                    onLoaded: (PlutoGridOnLoadedEvent event) {
                      stateManager = event.stateManager;
                      stateManager!.setAutoEditing(true);

                      event.stateManager
                          .setSelectingMode(PlutoGridSelectingMode.cell);

                      stateManager!.clearCurrentCell();
                      stateManager!.notifyListeners();
                    },
                  ),
                ),
              ),
            ],
          ),
        );

        rowsPlutogrid = [];
      }
    }

    objEstacaoModel.setMapaEstacao = listaMapaEstac;
    listaMapaEstac = [];

    objEstacaoModel.setTabelasNome = nomeTabelas;
    objEstacaoModel.setListaWidget = criarWidgets;

    //Avisa para mudar o widget de exibicao
    objEdicaoModel.setAtivaTabelas = true;

    return criarWidgets;
  }
}
