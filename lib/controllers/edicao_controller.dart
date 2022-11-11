import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_pluto_grid.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';

class EdicaoController {
  List<Map<dynamic, dynamic>> map = objSqlite.tabelasCompletas;
  List<String> numerosEstacao = [];
  Map testem = {};
  List<dynamic> listaTeste = [];
  List<Map<String, dynamic>> lista1 = [];
  List<dynamic> lista2 = [];
  String estacCodigo = '';
  String estacConfig = '';
  String estacTrib = '';
  String estacEvento = '';
  String estacTeclado = '';
  String estacUnidade = '';
  List<Map<String, dynamic>> mapaColEstacao = [];
  List<String> listaColunasEstac = [];
  List<String> tabelasArquivo = [];
  var mapa = {};

  // Método que monta o grid

  criaTabViewTabela(int widgetNumber) {
    rows.clear();
    columns.clear();
    listaTIT.clear();
    recebeCPO.clear();
    celulaCPO.clear();

    //Limpa o nome das tabelas que sera passado para o objeto
    tabelasArquivo.clear();
    separarArquivo = "";

    try {
      String? recebeTabela;

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

      //================== MAPA ESTACAO NOME-COLUNAS/POSIÇÃO ======================= //
      if (nomeTabelas[widgetNumber] == 'estac') {
        mapaEstacColuna(nomeTabelas, nomeColunas);
      }

      //============================================================================ //

      //=============================================== MAPA completo DICIONARIO
      nomeColunasDicionario = transformaString(linhasTIT);
      nomeSubtituloDicionario = transformaString(linhasTIT);

      for (var i = 0; i < map.length; i++) {
        Map mapas = map[i];
        for (var element in mapas.entries) {
          for (var j = 0; j < nomeColunasDicionario.length; j++) {
            if (element.value['campo'] == nomeColunasDicionario[j]) {
              nomeColunasDicionario[j] = element.value['campo'];
              nomeSubtituloDicionario[j] = element.value['titulo'];
            }
          }
        }
      }

      //===============================================

      columns = <PlutoColumn>[
        for (int contCol = 0; contCol < nomeColunas.length; contCol++) ...{
          PlutoColumn(
            // titleSpan: TextSpan(
            //   text: nomeColunas[contCol],
            //   recognizer: TapGestureRecognizer()..onTap = () => print(contCol),
            // ),
            //enableContextMenu: false,
            titleTextAlign: PlutoColumnTextAlign.center,
            readOnly: leitura(nomeColunas, contCol),
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

            //================== MAPA ESTACAO NUMERO/POSICAO DA LINHA ======================= //

            mapaEstacRowPosicao(i);

            //============================================================================== //

          }
          recebeLinhas = "";
        }
      }
    } catch (e) {
      debugPrint("$e");
    }
    //=============================================== ojetos teste
    objEstacaoModel.setMapaEstacao = lista1;

    lista1 = [];
    objEstacaoModel.setEstacaoOpcao = numerosEstacao;

    objEstacaoModel.setTabelasNome = tabelasArquivo;

    //===============================================

    return PlutoGrid(
      mode: PlutoGridMode.normal,
      configuration: configuracaoPlutoGrid,
      columns: columns,
      rows: rows,
      onChanged: (PlutoGridOnChangedEvent event) {
        int rowIndex = event.rowIdx + 1;
        mapa = {
          'tabelaInicial': nomeTabelas[tabController.index],
          'tabelaFinal': nomeTabelas[metodoContador(
            tabController.index,
            nomeTabelas,
          )],
          'coluna': nomeColunas[event.columnIdx],
          'colunaIndex': event.columnIdx,
          'linhaIndex': rowIndex,
          'novoValor': event.value,
        };

        recebeMapa.addAll([mapa]);
      },
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
        stateManager!.setAutoEditing(true);

        event.stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
        // setState(() {
        //   print(event.stateManager.currentCell);
        //   print(event.stateManager.currentRow);
        //   print(event.stateManager.currentSelectingRows);
        //   print(event.stateManager.currentCellPosition);

        // });
        stateManager!.clearCurrentCell();
        stateManager!.notifyListeners();
        // stateManager!.keyManager!.subject.listen((PlutoKeyManagerEvent value) {
        //   // if (value.isKeyDownEvent && value.isEnter) {
        //   print(stateManager!.currentColumn!.field);
        //   // }
        // });
      },
    );
  }

  // Futurebuilder que constrói as telas

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

//************ Transforma a String para comparar com o dicionario ************

  List<String> transformaString(List<String> listaColunasARQ) {
    List<String> lista = [];
    List<String> cols = listaColunasARQ[0].split('|');

    //retira o espaço em branco no final da linha
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

/* Diminui o length da celula para o  mapa de alteração de celula no grid */

  metodoContador(int valor, var tabela) {
    int contador = valor + 1;
    if (contador == tabela.length) {
      return contador = contador - 1;
    } else {
      return contador;
    }
  }

// Retorna um boleano para as celulas ativas e desativas

  leitura(var lista, var contador) {
    int col = lista.length - 1;
    if (contador == col) {
      return true;
    } else {
      return false;
    }
  }

//*********************** Delay ***********************

  Future<String> delay2() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Aguarde!\n Carregando tabelas!';
  }

  Future<String> delay() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return 'Aguarde!\n Carregando tabelas!';
  }

// retorna uma lista de dados da tabela dicionario

  retornaCombo(String opcao) {
    List<String> retorno = [];
    Map listaa = {};
    List<Map<dynamic, dynamic>> lista = objSqlite.tabelasCompletas;
    for (var i = 0; i < lista.length; i++) {
      listaa = lista[i];
      for (var element in listaa.entries) {
        retorno.addAll([element.value[opcao]]);
      }
    }
    return retorno;
  }

// passa para o objeto um mapa com o número das estações, sua posição e unidade
  void mapaEstacRowPosicao(int i) {
    //Ex:
    /** 001/009:
         *      unidade : 001
         *      estacao : 009
         *      posicao : 8
        */

    for (int k = 0; k < celulaCPO.length; k++) {
      if (nomeColunas[k] == 'est_unidade01') {
        estacUnidade = celulaCPO[k];

        numerosEstacao.addAll([celulaCPO[k]]);
      } else if (nomeColunas[k] == 'est_codigo01') {
        estacCodigo = celulaCPO[k];

        lista1.addAll([
          {
            "$estacUnidade/$estacCodigo": {
              'unidade': estacUnidade,
              'estacao': estacCodigo,
              'posicao': i.toString(),
            }
          }
        ]);
      }
    }
  }

// passa para o objeto  um mapa com a posicao e o nome da coluna da tabela estac
  void mapaEstacColuna(var nomeTabelas, var nomeColunas) {
    for (var i = 0; i < nomeTabelas.length; i++) {
      if (nomeTabelas[i] == 'estac') {
        for (var j = 0; j < nomeColunas.length; j++) {
          mapaColEstacao.addAll([
            {
              'estac/${nomeColunas[j]}': {
                'posicao': j.toString(),
                'nomeColuna': nomeColunas[j],
              }
            }
          ]);

          listaColunasEstac.addAll([nomeColunas[j]]);
        }
      }
    }

    // mapa com o nome e a posição das colunas do config
    objEstacaoModel.setColunasMapa = mapaColEstacao;

    // lista com o nome das colunas do config
    objEstacaoModel.setColunasFiltro = listaColunasEstac;
  }
}
