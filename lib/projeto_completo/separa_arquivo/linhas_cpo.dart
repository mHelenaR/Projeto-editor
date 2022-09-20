import 'dart:async';

import 'package:pluto_grid/pluto_grid.dart';
import 'package:sidebarx/sidebarx.dart';

@override
Future<List<PlutoRow>> linhasCpoArquivo(
    String conteudoArquivo, SidebarXController controller) async {
  List<String> teste1 = [];
  List<String> teste2 = [];
  List<String> teste3 = [];
  String separarArquivo = '';
  List<String> separaTabelasArquivo = [];

  final Completer<List<PlutoRow>> completer = Completer();

  int count = 0;

  const max = 100;

  const chunkSize = 100;

  const totalRows = chunkSize * max;

  List<PlutoRow> rows = [];

  separarArquivo = conteudoArquivo;

  separaTabelasArquivo = separarArquivo.split('TIT ');
  List<String> linhasTIT = separaTabelasArquivo[1].split('\r\n');

  for (int i = 1; i < linhasTIT.length; i++) {
    if (linhasTIT[i] != '') {
      String testeP = linhasTIT[i];
      String? testeO = testeP.split('CPO ').toString();
      teste1 = [testeO];
      teste3 = teste3 + teste1;

      for (int p = 0; p < teste3.length; p++) {
        teste2 = teste3[p].split('^');
      }

      Timer.periodic(const Duration(milliseconds: 1), (timer) {
        if (count == max) {
          return;
        }

        ++count;
        Future(() {
          return rows.addAll(
            [
              PlutoRow(
                cells: {
                  for (int rColTam = 0; rColTam < teste2.length; rColTam++) ...{
                    rColTam.toString(): PlutoCell(
                      value: teste2[rColTam],
                    ),
                  },
                },
              ),
            ],
          );
        });

        if (rows.length == totalRows) {
          completer.complete(rows);

          timer.cancel();
        }
      });
    }
  }
  return rows;
}
