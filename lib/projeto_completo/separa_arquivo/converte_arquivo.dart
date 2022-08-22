import 'dart:convert';
import 'dart:io';

Future<String> converteArquivo(String caminho) async {
  final dadosArquivo = File(caminho)
      .readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));

  return dadosArquivo;
}
