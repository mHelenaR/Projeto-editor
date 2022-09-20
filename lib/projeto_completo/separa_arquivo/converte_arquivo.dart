import 'dart:convert';
import 'dart:io';

Future<String> converteArquivo(String teste) async {
  final dadosArquivo = File(teste)
      .readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));

  return dadosArquivo;
}
