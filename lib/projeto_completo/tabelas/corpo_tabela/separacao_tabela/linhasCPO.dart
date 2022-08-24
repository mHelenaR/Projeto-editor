 //----------- CPO-INICIO-----------//
    for (int i = 1; i < _linhasTIT.length; i++) {
      if (_linhasTIT[i] != '') {
        String testeP = _linhasTIT[i];
        String? testeO = testeP.split('CPO ').toString();
        teste1 = [testeO];
        teste3 = teste3 + teste1;

        for (int p = 0; p < teste3.length; p++) {
          teste2 = teste3[p].split('^');
        }

        setState(
          () {
            rows.addAll(
              [
                if (_controller.selectedIndex == 1) ...{
                  PlutoRow(
                    cells: {
                      'teste': PlutoCell(value: 'TesteValor'),
                    },
                  ),
                } else if (_controller.selectedIndex != 1) ...{
                  PlutoRow(
                    cells: {
                      for (int rColTam = 0;
                          rColTam < teste2.length;
                          rColTam++) ...{
                        rColTam.toString(): PlutoCell(
                          value: teste2[rColTam],
                        ),
                      },
                    },
                  ),
                },
              ],
            );
          },
        );
      }
    }

    //----------- CPO------------//

    