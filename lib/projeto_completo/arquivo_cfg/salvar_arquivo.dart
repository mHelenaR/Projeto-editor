import 'dart:io';

import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';

gravarArquivo() {
  String arquivo = objArquivoGravacao.arquivoGR;
  //String caminho = objArquivoGravacao.caminhoArquivoGR;
  String caminho = "C:\\Users\\Maria\\Documents\\testeConfig.txt";
  String recebeTabela = '';
  List<String> colunaTit = [];
  List<String> col = [];
  List<String> linhacpo = [];
  var map = {};
  String recebe = '';
  String montaTabela = '';
  String finalArquivo = '';
  String inicioArquivo = '';

  for (int i = 0; i < recebeMapa.length; i++) {
    map = recebeMapa[i];

    String start = "TIT ${map['tabelaInicial']}#";
    String end = "TIT ${map['tabelaFinal']}#";
    final startIndex = arquivo.indexOf(start);
    final endIndex = arquivo.indexOf(end, startIndex + start.length);
    inicioArquivo = arquivo.substring(0, startIndex);

    // última tabela
    if (map['tabelaInicial'] == map['tabelaFinal']) {
      recebeTabela = arquivo.substring(
        startIndex + start.length,
        arquivo.length,
      );

      finalArquivo = end + arquivo.substring(arquivo.length);
    } else {
      recebeTabela = arquivo.substring(
        startIndex + start.length,
        endIndex,
      );

      finalArquivo = end +
          arquivo.substring(
            endIndex + end.length,
            arquivo.length,
          );
    }

    colunaTit = recebeTabela.split("\r\n");
    col = colunaTit[0].split('|');

    for (int k = 0; k < col.length; k++) {
      int contador = col.length - 2;
      if (k <= contador) {
        if (col[k] == map['coluna']) {
          linhacpo = colunaTit[map['linhaIndex']].split('CPO ');

          List<String> celulacpo = linhacpo[1].split("^");

          for (int m = 0; m < celulacpo.length; m++) {
            int tam = celulacpo.length - 1;
            if (map['colunaIndex'] == m) {
              recebe = '$recebe${map['novoValor']}^';
            } else if (m < tam) {
              recebe = '$recebe${celulacpo[m]}^';
            }
          }
        }
      }
    }
    for (int n = 0; n < colunaTit.length; n++) {
      int tam = colunaTit.length - 1;
      if (map['linhaIndex'] == n) {
        montaTabela = '${montaTabela}CPO $recebe\r\n';
      } else if (n < tam && n > 0) {
        montaTabela = '$montaTabela${colunaTit[n]}\r\n';
      } else if (n == 0) {
        montaTabela = 'TIT ${map['tabelaInicial']}#${colunaTit[n]}\r\n';
      }
    }

    if (map['tabelaInicial'] == map['tabelaFinal']) {
      arquivo = inicioArquivo + montaTabela;
    } else {
      arquivo = inicioArquivo + montaTabela + finalArquivo;
    }
    recebe = '';
  }

  if (map['tabelaInicial'] == map['tabelaFinal']) {
    gravarDados(inicioArquivo + montaTabela, caminho);
  } else {
    gravarDados(inicioArquivo + montaTabela + finalArquivo, caminho);
  }
}

Future<void> gravarDados(var arquivo, var caminho) async {
  var textoArquivo = arquivo;

  final myFile = File(caminho);

  await myFile.writeAsString(textoArquivo);

  myFile.writeAsString(
    textoArquivo,
  );
}

class RecebeValor {
  dynamic _tabelasConfigGR;
  dynamic _arquivoGR;
  dynamic _caminhoArquivoGR;
  dynamic _colunasTeste;
  dynamic _linhasTeste;
  dynamic _mapaGR;
  dynamic _listas;
  dynamic _linhasTIT;

  get tabelasConfigGR => _tabelasConfigGR;
  set setTabelasConfigGR(var tabelasConfig) {
    _tabelasConfigGR = tabelasConfig;
  }

  get arquivoGR => _arquivoGR;
  set setArquivoGR(var arquivo) {
    _arquivoGR = arquivo;
  }

  get caminhoArquivoGR => _caminhoArquivoGR;
  set setCaminhoArquivoGR(var caminhoArquivoGR) {
    _caminhoArquivoGR = caminhoArquivoGR;
  }

  get colunasTeste => _colunasTeste;
  set setColunasTeste(var colunasTeste) {
    _colunasTeste = colunasTeste;
  }

  get linhasTeste => _linhasTeste;
  set setLinhasTeste(var linhasTeste) {
    _linhasTeste = linhasTeste;
  }

  get mapaGR => _mapaGR;
  set setmapaGR(var mapaGR) {
    _mapaGR = mapaGR;
  }

  get listasGR => _listas;
  set setlistasGR(var listasGR) {
    _listas = listasGR;
  }

  get linhasTITs => _linhasTIT;
  set setlinhasTITs(var linhasTIT) {
    _linhasTIT = linhasTIT;
  }
}
