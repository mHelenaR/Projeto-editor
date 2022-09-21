import 'package:flutter/foundation.dart';

import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';

gravarArquivo() {
  String arquivo = objArquivoGravacao.arquivoGR;
  //String caminho = objArquivoGravacao.caminhoArquivoGR;
  List<String> tabelas = objArquivoGravacao.tabelasConfigGR;
  String recebeTabela = '';
  List<String> colunasBanco = [];
  List<String> teste1 = [];
  Map<String, String> mapConfig = {};

  for (int i = 0; i < tabelas.length; i++) {
    int contador = i + 1;
    String start = "TIT ${tabelas[i]}#";

    if (contador == tabelas.length) {
      contador = contador - 1;

      final startIndex = arquivo.indexOf(start);

      recebeTabela =
          arquivo.substring(startIndex + start.length, arquivo.length);
      mapConfig.addAll({tabelas[contador]: recebeTabela});
    } else {
      String end = "TIT ${tabelas[contador]}#";

      final startIndex = arquivo.indexOf(start);
      final endIndex = arquivo.indexOf(end, startIndex + start.length);

      recebeTabela = arquivo.substring(startIndex + start.length, endIndex);
      mapConfig.addAll({tabelas[i]: recebeTabela});
    }
    colunasBanco = colunasBanco + [recebeTabela];
  }
  for (final teste in mapConfig.entries) {
    teste1 = teste1 + [teste.key];

    if (kDebugMode) {
      print(teste.key);
    }
  }
  if (kDebugMode) {
    print(teste1);
  }
}

conteudowArquivo(var teste) {
  return teste;
}

class RecebeValor {
  dynamic _tabelasConfigGR;
  dynamic _arquivoGR;
  dynamic _caminhoArquivoGR;

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
}
