import 'dart:io';

import 'package:editorconfiguracao/busca_arquivo/explorador_arq.dart';
import 'package:editorconfiguracao/main.dart';

import 'package:flutter/material.dart';
/*
class CriaTabela extends StatefulWidget {
  const CriaTabela({Key? key}) : super(key: key);

  @override
  State<CriaTabela> createState() => _CriaTabelaState();
}

final _teste = '';
final start = '#';
final end = 'CPO ';
final startIndex = _teste.indexOf(start);
final endIndex = _teste.indexOf(end);
final _result = _teste.substring(startIndex + start.length, endIndex).trim();

final inicio = 'CPO ';
final fim = ' TIT ';
final inicioInd = _teste.indexOf(inicio);
final fimInd = _teste.indexOf(fim);
final _novo = _teste.substring(inicioInd + inicio.length, fimInd);

List<String> strarray = _result.split('|');

List<String> estacao = _novo.split('^');

class _CriaTabelaState extends State<CriaTabela> {
  @override
  Widget build(context) {
    return DataTable(horizontalMargin: 10, columns: [
      for (var i = 0; i < strarray.length; i++) ...{
        DataColumn(
            label: Text(
          '${strarray[i]}',
          style: TextStyle(fontSize: 20),
        )),
      }
    ], rows: [
      for (var i = 0; i < 1; i++) ...{
        DataRow(cells: [
          for (var i = 0; i < estacao.length; i++) ...{
            DataCell(Text('${estacao[i]}'.toString())),
          }
        ]),
      }
    ]);
  }
}
*/