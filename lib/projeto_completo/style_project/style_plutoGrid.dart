import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

final configuracaoPlutoGrid = PlutoGridConfiguration(
  style: PlutoGridStyleConfig(
    gridPopupBorderRadius: BorderRadius.circular(8), //  Popup filtro
    //enableGridBorderShadow: true,
    //columnFilterHeight: 40, // altura barra filtro
    //columnContextIcon: Icons.abc, // icone coluna
    gridBorderRadius: BorderRadius.circular(8), // borda arredondada
    // cellColorInEditState: Colors.black, // cor edição celula
    // borderColor: Colors.pinkAccent, // cor de todas as bordas
    // activatedBorderColor: Colors.purpleAccent, // cor da borda da celula
    // enableCellBorderHorizontal: false, // desativa as bordas das celulas
    // activatedColor: Colors.amber, // cor da linha selecionada
  ),
  columnSize: const PlutoGridColumnSizeConfig(
    resizeMode: PlutoResizeMode.normal,
  ),
  localeText: const PlutoGridLocaleText(
    unfreezeColumn: 'Desfixar',
    freezeColumnToEnd: 'Fixar a esquerda',
    freezeColumnToStart: 'Fixar a direita',
    autoFitColumn: 'Auto ajustar',
    hideColumn: 'Esconder coluna',
    setColumns: 'Definir coluna',
    setFilter: 'Definir filtro',
    resetFilter: 'Ressetar filtro',
    setColumnsTitle: 'Nome da Coluna',
    filterColumn: 'Coluna',
    filterType: 'Tipo',
    filterValue: 'Valor',
    filterAllColumns: 'Todas as colunas',
    filterContains: 'Contém',
    filterEquals: 'Igual a',
    filterStartsWith: 'Iniciar com',
    filterEndsWith: 'Terminar com',
    filterGreaterThan: 'Maior que',
    filterGreaterThanOrEqualTo: 'Maior que ou igual a',
    filterLessThan: 'Menor que',
    filterLessThanOrEqualTo: 'Menor que ou igual a',
    sunday: 'Dom',
    monday: 'Seg',
    tuesday: 'Ter',
    wednesday: 'Qua',
    thursday: 'Qui',
    friday: 'Sex',
    saturday: 'Sáb',
    hour: 'Hora',
    minute: 'Minuto',
    loadingText: 'Carregando...',
  ),
);
