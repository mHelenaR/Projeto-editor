import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

Future<String> converteArquivo(String arquivo) async {
  /** =========== Leitura do texto do arquivo ===============
   * 
   * Até a versão 3.3.5 do flutter, o pluggin [FILE],
   * lia os arquivos codificados em UTF-8 sem apresentar erros
   * no encoding, a função {readStringSync} condificava 
   * automaticamente o texto para UTF-8, quando um tentava ler um
   * arquivo [ANSI], apresentava um erro de codificação, essa
   * foi a forma encontrada no momento para resolver a situação
   * 
   * =========================================================
   */

  try {
    final dadosArquivo =
        File(arquivo).readAsStringSync(encoding: const Utf8Codec());

    return dadosArquivo;
  } catch (e) {
    if (kDebugMode) {
      print('Erro: $e');
    }

    final dadosArquivo =
        File(arquivo).readAsStringSync(encoding: const Latin1Codec());

    return dadosArquivo;
  }
}
