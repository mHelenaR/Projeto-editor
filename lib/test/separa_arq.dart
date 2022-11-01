// ignore_for_file: avoid_print, unused_local_variable

import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/nome_tabelas.dart';

class SeparaTest {
  ler() async {
    String conteudoArquivo =
        await converteArquivo('C:\\frente\\config (11).cfg');

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

    for (var i = 0; i < linhasTIT.length; i++) {
      var teste = linhasTIT[i];
      for (var element in teste.entries) {
        String tes = element.value;
        print(tes.split('|'));
      }
    }

    // print(mapaConfig);
    print('\n\n\n');
  }
}
