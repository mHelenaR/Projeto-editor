import 'dart:convert';
import 'dart:io';

Future<String> converteArquivo(String arquivo) async {
  final dadosArquivo =
      File(arquivo).readAsStringSync(encoding: const Utf8Codec());

  return dadosArquivo;
}
