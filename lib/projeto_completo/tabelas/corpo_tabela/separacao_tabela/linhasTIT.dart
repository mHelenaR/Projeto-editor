_separarArquivo = await conteudoArquivo;

    separaTabelasArquivo = _separarArquivo.split('TIT ');
    List<String> _linhasTIT = separaTabelasArquivo[61].split('\r\n');

    //----------- TIT------------//

    int posCharacterArquivo = _linhasTIT[0].indexOf('#') + 1;
    nomeColSeparada = [_linhasTIT[0].substring(posCharacterArquivo)];

    // retira o separador
    nomeColunas = nomeColSeparada[0].split('|');

    setState(() {
      _arrayString = nomeColunas;
    });
    setState(
      () {
        stateManager.notifyListeners();
        columns = <PlutoColumn>[
          if (_controller.selectedIndex == 1) ...{
            PlutoColumn(
              title: 'teste carrega',
              field: 'teste',
              type: PlutoColumnType.text(),
            ),
          } else if (_controller.selectedIndex != 1) ...{
            for (int colTam = 0; colTam < _arrayString.length; colTam++) ...{
              //coluna
              PlutoColumn(
                title: '$colTam|${_arrayString[colTam]}',
                field: colTam.toString(),
                type: PlutoColumnType.text(),
              ),
            }
          }
        ];
      },
    );


    