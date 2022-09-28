// ignore_for_file: avoid_print, unused_local_variable

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

  List<String> listaComparar = [
    'tributacao',
    'estac',
    'finalizadora',
  ];

  for (int i = 0; i < tabelas.length; i++) {
    int contador = i + 1;
    String start = "TIT ${tabelas[i]}#";

    if (contador == tabelas.length) {
      contador = contador - 1;

      final startIndex = arquivo.indexOf(start);

      recebeTabela = arquivo.substring(
        startIndex + start.length,
        arquivo.length,
      );

      gravaLinhasTIT = [recebeTabela];
    } else {
      String end = "TIT ${tabelas[contador]}#";

      final startIndex = arquivo.indexOf(start);
      final endIndex = arquivo.indexOf(end, startIndex + start.length);

      recebeTabela = arquivo.substring(
        startIndex + start.length,
        endIndex,
      );
      gravaLinhasTIT = [recebeTabela];
    }

    colunaTit = gravaLinhasTIT[0].split("\r\n");
    col = colunaTit[0].split('|');

    for (int k = 0; k < col.length; k++) {
      if (col[k] == 'tdo_teclado01') {
        print(col[k]);
      }
    }
    // print(testeG);
  }

  final myFile = File(caminho);
  //print(col);
  //myFile.writeAsString(col.toString());
  // myFile.writeAsString(testeG);

  // print(gravaLinhasTIT);
}

Future<void> writeData(var arquivo, var caminho) async {
  var textoArquivo = arquivo;

  final myFile = File(caminho);

  await myFile.writeAsString(textoArquivo);

  myFile.writeAsString(
    mode: FileMode.write,
    encoding: const Latin1Codec(allowInvalid: false),
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
}
