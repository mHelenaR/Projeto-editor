// ignore_for_file: avoid_print, unused_local_variable

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

      // linhasTIT = recebeTabela!.split("\r\n");
      // var nomeColunas = linhasTIT[0].split('|');

      //print(nomeColunas);
      // for (var l = 0; l < linhasTIT.length; l++) {
      //   int contador = l + 1;

      //   if (contador == linhasTIT.length) {
      //     contador = contador - 1;
      //   }
      //   //if (l == 0) {
      //   //tit
      //   var nomeColunas = linhasTIT[0].split('|');

      //   //cpo
      //   if (linhasTIT[l] != "") {
      //     String recebeLinhas = linhasTIT[contador];
      //     var recebeCPO = recebeLinhas.split('CPO ');
      //     recebeCPO.removeAt(0);
      //     for (var m = 0; m < recebeCPO.length; m++) {
      //       var celulaCPO = recebeCPO[m].split('^');
      //       for (var element in celulaCPO) {
      //         print(element);
      //       }
      //       //print(recebeCPO[m]);
      //       for (var j = 0; j < nomeColunas.length; j++) {

      //         // print('CPO : ${celulaCPO.length}');
      //         // print(celulaCPO[j]);
      //         // mapaConfig.addAll(
      //         //   [
      //         //     {
      //         //       chavePrincipal[i]: {
      //         //         'tabelaPosicao': i.toString(),
      //         //         'colunaArq': nomeColunas[j],
      //         //         'posicaoArq': j.toString(),
      //         //         'celulaArq': celulaCPO[j],
      //         //       }
      //         //     },
      //         //   ],
      //         // );
      //         // print('TIT : ${nomeColunas.length}');
      //       }
      //     }
      //   }
      // }
    }

    // for (var i = 0; i < linhasTIT.length; i++) {
    //   var teste = linhasTIT[i];
    //   for (var element in teste.entries) {
    //     String tes = element.value;
    //     print(tes.split('|'));
    //   }
    // }

    objeto.setTabelas = linhasTIT;

    //print(linhasTIT);
    //print('\n\n\n');
  }

  separa() {
    List<Map<dynamic, dynamic>> tabelas = objeto.tabelas;

    List<String> novo = [];
    Map<dynamic, dynamic> teste1 = {};
    for (var i = 0; i < tabelas.length; i++) {
      teste1.addAll(tabelas[i]);

      // for (var element in teste1.entries) {
      //   String teste2 = element.value;
      //   // List<String> n = teste2;
      //   novo.addAll([teste2]);
      //   //List<String> novo2 = novo[0].split('|');

      //   // colunas para a tabela
      //   // columns = [
      //   //   for (int k = 0; k < novo2.length; k++) ...{
      //   //     novo2[k],
      //   //   }
      //   // ];

      //   // for (var l = 1; l < novo.length; l++) {
      //   //   String teste3 = novo[l];
      //   //   List<String> cpo = teste3.split('CPO ');
      //   //   print(teste3);
      //   // }

      //   // print(novo[0].split('|'));
      //   //print(columns);
      // }
    }
    objeto.setSeparadasEnter = teste1;
    // print(novo);
    criaTabelas();
  }

  criaTabelas() {
    Map<dynamic, dynamic> recebe = objeto.separadasEnter;
    List<String> columns = [];
    List<dynamic> test = [];
    Map mapa = {};
    List<dynamic> rows = [];
    Map ma = {};
    Map ma1 = {};
    int cont = 0;
    // List<Map<dynamic, dynamic>> rows = [];
    List<Map<dynamic, dynamic>> lista = [];
    for (var element in recebe.entries) {
      String teste = element.value;

      var n = teste.split('\r\n');
      //test.clear();
      for (var i = 0; i < n.length; i++) {
        if (i == 0) {
          var m = n[i].split('|');
          columns = [
            for (int k = 0; k < m.length; k++) ...{
              m[k],
            }
          ];
        } else {
          var re = n[i].split('CPO ');

          for (var p = 0; p < re.length; p++) {
            if (re[p] != '') {
              var celula = re[p].split('^');

              //  for (var j = 0; j < r.length; j++) {
              // rows.addAll(r);
              // rows.addAll([
              //   {columns[j]: r[j]}
              // ]);

              for (var j = 0; j < celula.length; j++) {
                // var rew = {columns[j]: r[j]};
                // rows = [rew];
                //rows.addAll(['${celula[j]}/wndkanwd']);
                // print(rows);
                // rows.addAll([r]);
                //rows.addAll([r]);
                // String teste = 'a / $celula';
                rows = celula;
                print(rows);
                ma1.addAll({'$j/${element.key}': rows});
              }

              // test.add([
              //   {'linhas': rows}
              // ]);
              //test.addAll([rows]);

              //  }
            }
          }
        }
        //ma = {'colunas': columns};

        // mapa.addAll({
        //   element.key: {
        //     ma,
        //     test,
        //   }
        // });
        // mapa.addAll({
        //   element.key: {
        //     'linhas': rows,
        //   }
        // });
      }
      // mapa.addAll({
      //   element.key: {
      //     ma,
      //     test,
      //   }
      // });

      //lista.addAll([mapa]);
    }
    //print(test);
    //print(rows);
    // print(mapa);
    // print(lista);

    print(ma1);
  }
}
