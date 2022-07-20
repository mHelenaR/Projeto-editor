 //backup
/* for (int i = 1; i < _linhasTIT.length; i++) {
      if (_linhasTIT[i] != '') {
        String testeP = _linhasTIT[i];
        String? testeO = testeP.split('CPO ').toString();
        teste1 = [testeO];
        teste3 = teste3 + teste1;
        for (int p = 0; p < teste3.length; p++) {
          teste2 = teste3[p].split('^');
        }
      for (int m = 0; m < teste3.length; m++) {
      for (int n = 0; n < teste2.length; n++) {
        //coluna
        teste4[m] = teste2[n];
        // print(teste2[rColTam]);
      }
    }
        rows = [
          for (int rowTam = 0; rowTam < teste3.length; rowTam++) ...{
            //linha

            PlutoRow(
              cells: {
                //for (int rowTam = 0; rowTam < teste2.length; rowTam++) ...{
                for (int rColTam = 0; rColTam < teste2.length; rColTam++) ...{
                  //coluna

                  rColTam.toString(): PlutoCell(value: /*'$rColTam|$rowTam'*/ ' ${teste2[rColTam]}'),
                },
                //}
              },
            ),
          }
        ];
      }
    } */


        //columns: columns,
    // [
    //   for (int j = 0; j < _arrayString.length; j++) ...{
    //     PlutoColumn(
    //       title: _arrayString[j],
    //       field: j.toString(),
    //       type: PlutoColumnType.text(),
    //     ),
    //   }
    // ],
    // rows: rows,
    // [
    //   for (int i = 0; i < teste3.length; i++) ...{
    //     PlutoRow(
    //       cells: {
    //         for (int j = 0; j < teste2.length; j++) ...{
    //           j.toString(): PlutoCell(value: j.toString() + '  ' + i.toString() + '  ' + teste2[j]),
    //         },
    //       },
    //     ),
    //   }
    // ],
    //print(teste4);
    // print(teste4);
    //   if (posCPO == 0) {
    //     linhaCPO = [_linhasTIT[i].substring(0, 3)];
    //   }
    //   teste1 = teste1 + linhaCPO;
    // }
    // print(teste1);

/*colunasTabelasArquivo() async {
    // espera o carregamento da variavel
    _separarArquivo = await conteudoArquivo;

    // cria lista com cpo
    separaTabelasArquivo = _separarArquivo.split('TIT ');
    List<String> _linhasTIT = separaTabelasArquivo[1].split('\r\n');

    //----------- TIT-INICIO-----------//

    //encontra posição do caracter para extrair
    int posCharacterArquivo = _linhasTIT[0].indexOf('#') + 1;
    nomeColSeparada = [_linhasTIT[0].substring(posCharacterArquivo)];

    // retira o separador
    nomeColunas = nomeColSeparada[0].split('|');

    setState(() {
      _arrayString = nomeColunas;
    });

    //----------- TIT-FIM-----------//

    //----------- CPO-INICIO-----------//
    for (int i = 1; i < _linhasTIT.length; i++) {
      if (_linhasTIT[i] != '') {
        String testeP = _linhasTIT[i];
        String? testeO = testeP.split('CPO ').toString();
        teste1 = [testeO];
        teste3 = teste3 + teste1;

        for (int p = 0; p < teste3.length; p++) {
          teste2 = teste3[p].split('^');
          // teste4[p] = teste3[p];
          for (int n = 0; n < teste2.length; n++) {
            teste4[n] = teste2[n];
            //teste5 = teste4[n];
            // teste7 = [
            //   [p.toString()],
            //   [teste2[n]]
            // ];
            // print(teste7);

            // rows = [P
            //   for (int rowTam = 0; rowTam < teste3.length; rowTam++) ...{
            //     //linha
            //     PlutoRow(
            //       cells: {
            //         //for (int rowTam = 0; rowTam < teste2.length; rowTam++) ...{
            //         for (int rColTam = 0; rColTam < teste4.length; rColTam++) ...{
            //           //coluna
            //           rColTam.toString(): PlutoCell(
            //               value: Container(
            //             child: Center(
            //               child: Text('{$teste4[rColTam]}'),
            //             ),
            //           )),
            //         },
            //         //}
            //       },
            //     ),
            //   }
            // ];
          }
        }

        rows.addAll([
          PlutoRow(
            cells: {
              for (int rColTam = 0; rColTam < teste4.length; rColTam++) ...{
                rColTam.toString(): PlutoCell(value: teste2[rColTam]),
              },
            },
          ),
        ]);
      }
    }

    //arrumar colunas com tamanhos iguais
    columns = <PlutoColumn>[
      for (int colTam = 0; colTam < _arrayString.length; colTam++) ...{
        //coluna
        PlutoColumn(
          title: '$colTam|${_arrayString[colTam]}',
          field: colTam.toString(),
          type: PlutoColumnType.text(),
        ),
      }
    ];

    //----------- CPO-FIM-----------//
  }*/
  
// listar row
  /*  for (var item in parsedJson) {
      final Map<String, PlutoCell> cells = {
        for (var e in item.entries) e.key: PlutoCell(value: e.value)
      }; */

      