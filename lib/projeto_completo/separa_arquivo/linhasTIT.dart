// ignore_for_file: unused_local_variable, file_names

import 'package:pluto_grid/pluto_grid.dart';
import 'package:sidebarx/sidebarx.dart';

Future<List<PlutoColumn>> colunasNome(
    String conteudoArquivo, SidebarXController controller) async {
  String separarArquivo = '';
  List<String> separaTabelasArquivo = [];
  List<String> nomeColSeparada = [];
  List<String> nomeColunas = [];
  List<String> arrayString = [''];
  List<PlutoColumn> columns = [];

  separarArquivo = conteudoArquivo;

  separaTabelasArquivo = separarArquivo.split('TIT ');
  List<String> linhasTIT = separaTabelasArquivo[5].split('\r\n');

  int posCharacterArquivo = linhasTIT[0].indexOf('#') + 1;
  nomeColSeparada = [linhasTIT[0].substring(posCharacterArquivo)];

  nomeColunas = nomeColSeparada[0].split('|');

  arrayString = nomeColunas;

  return columns = <PlutoColumn>[
    for (int colTam = 0; colTam < arrayString.length; colTam++) ...{
      PlutoColumn(
        title: '$colTam|${arrayString[colTam]}',
        field: colTam.toString(),
        type: PlutoColumnType.text(),
      ),
    }
  ];
}
