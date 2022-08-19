import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:sqflite/sqflite.dart';

criaTabelas(DatabaseFactory dataBase, var caminho) async {
  // FilePickerResult? caminhoArquivo = await FilePicker.platform.pickFiles(
  //   type: FileType.custom,
  //   allowMultiple: false,
  //   initialDirectory: 'C:\\frente',
  //   allowedExtensions: ['cfg'],
  //   dialogTitle: 'Escolha o arquivo para gerar o banco',
  //   withData: true,
  // );
  //if (caminhoArquivo != null) {
  List<String> listaTabelas = [""];

  Database criar = dataBase.openDatabase(caminho);
  for (final tabelas in listaTabelas) {
    criar.execute(
      "CREATE TABLE IF NOT EXISTS unidades ("
      "id_unidades INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "campo CHARACTER(30) NOT NULL,"
      "tipo CHARACTER(1) NOT NULL,  "
      "titulo CHARACTER(50) NOT NULL, "
      "mensagem CHARACTER(255) NOT NULL, "
      "mascara CHARACTER(50)"
      ");",
    );
    //}
  }
}

converteArquivo(var caminho) async {
  var recebe = caminho.files.single.path;

  final dadosArquivo = await File(recebe!)
      .readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));

  return dadosArquivo;
}

Future<List<String>> nomeTabelasArquivo(String caminhoArquivo) async {
  List<String> erro = [];
  try {
    List<String> nomeTabelas = [];
    List<String> listaMenu = [];
    List<String> lista = [];

    String diretorio = converteArquivo(caminhoArquivo);
    var listaTIT = diretorio.split('TIT ');
    int posicaoSeparador = 0;

    for (int i = 0; i < listaTIT.length; i++) {
      posicaoSeparador = listaTIT[i].indexOf('#');
      if (posicaoSeparador != -1) {
        nomeTabelas = [listaTIT[i].substring(0, posicaoSeparador)];
      } else {
        nomeTabelas = [];
      }

      listaMenu = listaMenu + nomeTabelas;
    }

    lista = listaMenu;

    return lista;
  } catch (e) {
    return erro;
  }
}
