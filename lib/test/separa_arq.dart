// ignore_for_file: avoid_print, unused_local_variable

import 'dart:collection';

import 'package:editorconfiguracao/models/edicao_model.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/nome_tabelas.dart';
import 'package:pluto_grid/pluto_grid.dart';

testeClass objeto = testeClass();

class SeparaTest {
  ler() async {
    String conteudoArquivo = await converteArquivo('C:\\frente\\config1.cfg');

    List<String> chavePrincipal = await nomeTabelasArquivo(conteudoArquivo);

    List<Map<dynamic, dynamic>> mapaConfig = [];
    List<Map<dynamic, dynamic>> mapaConfig1 = [];
    List<Map<dynamic, dynamic>> mapaConfig2 = [];
    List<Map<dynamic, dynamic>> linhasTIT = [];

    for (int i = 0; i < chavePrincipal.length; i++) {
      int contador = i + 1;

      String start = 'TIT ${chavePrincipal[i]}#';
      String recebeTabela = '';

      if (contador == chavePrincipal.length) {
        contador = contador - 1;

        final startIndex = conteudoArquivo.indexOf(start);

        recebeTabela = conteudoArquivo.substring(
            startIndex + start.length, conteudoArquivo.length);
      } else {
        String end = 'TIT ${chavePrincipal[contador]}#';

        final startIndex = conteudoArquivo.indexOf(start);

        final endIndex =
            conteudoArquivo.indexOf(end, startIndex + start.length);

        recebeTabela =
            conteudoArquivo.substring(startIndex + start.length, endIndex);
      }

      linhasTIT.addAll([
        {chavePrincipal[i]: recebeTabela}
      ]);
    }

    objeto.setTabelas = linhasTIT;
  }

  separa() {
    List<Map<dynamic, dynamic>> tabelas = objeto.tabelas;

    List<String> novo = [];
    Map<dynamic, dynamic> teste1 = {};
    for (var i = 0; i < tabelas.length; i++) {
      teste1.addAll(tabelas[i]);
    }
    objeto.setSeparadasEnter = teste1;

    criaTabelas();
  }

  criaTabelas() {
    Map<dynamic, dynamic> recebe = objeto.separadasEnter;
    List<dynamic> columns = [];
    List<dynamic> test = [];
    List<dynamic> testeMapa = [];
    Map mapa = {};
    List<dynamic> rows = [];
    Map ma = {};
    Map ma1 = {};
    int cont = 0;
    String nome = '';
    List<dynamic> tester = [];
    var receves = [];

    List<Map<dynamic, dynamic>> lista = [];
    for (var element in recebe.entries) {
      String teste = element.value;
      cont = cont + 1;
      var n = teste.split('\r\n');

      for (var i = 0; i < n.length; i++) {
        int valor = n.length - 1;

        if (i == 0) {
          var m = n[i].split('|');

          columns = [
            for (int k = 0; k < m.length; k++) ...{
              {
                'nomeColuna': m[k],
                'posicaoColuna': k.toString(),
              },
            }
          ];
        } else {
          if (n[i] != "") {
            List<String> re = n[i].split('CPO ');

            for (var p = 0; p < re.length; p++) {
              if (re[p] != '') {
                List<String> celula = re[p].split('^');

                //rows.addAll([celula]);

                rows.addAll([
                  for (var l = 0; l < celula.length; l++)
                    {
                      'celula': celula[l],
                      'posicaoCelula': l.toString(),
                    }
                ]);
                tester.addAll([rows]);

                // esvazia a linha antes de adicionar a proxima na lista
                rows = [];
              }
            }
          }
        }

        receves = rows;
      }
      mapa.addAll({
        element.key: {
          'colunas': columns,
          'linhas': tester,
        }
      });
      // esvazia a linha antes de trocar a tabela

      tester = [];
      int contador;

      nome = element.key;
    }
    List<dynamic> testw = [];
    List<dynamic> colTeste = [];

    for (var element in mapa.entries) {
      // if (element.key == 'estac') {
      Map recebe = element.value;
      for (var recElement in recebe.entries) {
        //print(recElement.key); // colunas / linhas

        if (recElement.key == 'linhas') {
          testw = recElement.value;
        } else if (recElement.key == 'colunas') {
          colTeste = recElement.value;
        }
        testew(colTeste, testw);
        // }
      }
    }
  }

  testew(var coluna, var linha) {
    for (var i = 0; i < coluna.length; i++) {
      print(coluna[i]);
    }

    // linhas
    for (var i = 0; i < linha.length; i++) {
      List<dynamic> novo = linha[i];

      for (var l = 0; l < novo.length; l++) {
        // Map novomapa = novo[0];
        print(novo[l]);
        // for (var element in novomapa.entries) {

        //     print(element.value);

      }
      //}
    }
  }
}
