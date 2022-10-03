// ignore_for_file: avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';

import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';

gravarArquivo() {
  String arquivo = objArquivoGravacao.arquivoGR;
  //String caminho = objArquivoGravacao.caminhoArquivoGR;
  String caminho = "C:\\Users\\Maria\\Documents\\testeConfig.txt";
  List<String> tabelas = objArquivoGravacao.tabelasConfigGR;
  String recebeTabela = '';
  List<String> listaChave = [];
  String gravaArquivoCFG = "";
  String montaArquivo = '';
  List<String> linhasTIT = [];
  List<String> gravaLinhasTIT = [];
  Map<String, String> mapConfig = {};
  String testew = '';
  List<String> colunaTit = [];
  List<String> col = [];
  List<String> linhacpo = [];
  var map = {};
  String recebe = '';
  List<List<String>> matrix = [];
  for (int i = 0; i < recebeMapa.length; i++) {
    map = recebeMapa[i];

    String start = "TIT ${map['tabelaInicial']}#";
    String end = "TIT ${map['tabelaFinal']}#";
    final startIndex = arquivo.indexOf(start);
    final endIndex = arquivo.indexOf(end, startIndex + start.length);

    // última tabela
    if (map['tabelaInicial'] == map['tabelaFinal']) {
      recebeTabela = arquivo.substring(
        startIndex + start.length,
        arquivo.length,
      );
    } else {
      recebeTabela = arquivo.substring(
        startIndex + start.length,
        endIndex,
      );
    }
    colunaTit = recebeTabela.split("\r\n");
    col = colunaTit[0].split('|');

    for (int k = 0; k < col.length; k++) {
      int contador = col.length - 2;
      if (k <= contador) {
        if (col[k] == map['coluna']) {
          linhacpo = colunaTit[map['linha']].split('CPO ');

          List<String> celulacpo = linhacpo[1].split("^");

          for (int m = 0; m < celulacpo.length; m++) {
            int tam = celulacpo.length - 1;
            if (map['colunaIndex'] == m) {
              recebe = recebe + map['novoValor'] + '^';
            } else if (m < tam) {
              recebe = recebe + celulacpo[m] + '^';
            } else {
              recebe = recebe + '\r\n';
            }
          }
          print(recebe);
        }
      }
    }

    print(
        '===============================  //  =====================================');
    //  print(colunaTit);
  }
  //writeData(recebe, caminho);
  final myFile = File(caminho);
}

Future<void> writeData(var arquivo, var caminho) async {
  var textoArquivo = arquivo;

  final myFile = File(caminho);

  await myFile.writeAsString(textoArquivo);

  myFile.writeAsString(
    //mode: FileMode.write,
    // encoding: latin1,
    textoArquivo,
  );
}

conteudowArquivo(var teste) {
  return teste;
}

class RecebeValor {
  dynamic _tabelasConfigGR;
  dynamic _arquivoGR;
  dynamic _caminhoArquivoGR;
  dynamic _colunasTeste;
  dynamic _linhasTeste;
  dynamic _mapaGR;

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
}
