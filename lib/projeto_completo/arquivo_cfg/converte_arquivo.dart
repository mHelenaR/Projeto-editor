import 'dart:io';

Future<String> converteArquivo(String arquivo) async {
  // Esta sem o encoding pois codificando, o flutter não lê os acentos corretamente
  final dadosArquivo = File(arquivo).readAsStringSync();

  return dadosArquivo;
}
