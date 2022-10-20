import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/controllers/filtro_controller.dart';
import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';

class DropDownWidget extends StatefulWidget {
  final dynamic escolha;
  final dynamic tipoEscolha;

  const DropDownWidget({
    Key? key,
    required this.escolha,
    required this.tipoEscolha,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  List<String> tabelasDicionario = objSqlite.nomeColunasDcn;
  final FiltroController _controllerFiltro = FiltroController();

  opcaoDropDown() {
    if (widget.escolha == 'Estação') {
      return dropEstacao();
    } else if (widget.escolha == 'Conteúdo') {
      return dropEstacao();
    } else {
      return dropDicionario();
    }
  }

  dropEstacao() {
    return DropdownSearch<FilterEstacModel>(
      enabled: true,
      onChanged: (value) {
        objEstacaoModel.setEstacaoNumero = value;
        FilterModel recebe = objFiltro.tabelasConfig;
        for (var i = 0; i < tabelasDicionario.length; i++) {
          if (recebe.tabela == tabelasDicionario[i]) {
            tabController.index = i;
            _controllerFiltro.handleFocusToIndex(recebe.coluna);
          }
        }
      },
      asyncItems: (String? filter) =>
          _controllerFiltro.mapaEstacao(widget.escolha),
      itemAsString: (item) => item.estacao ?? "",
      popupProps: PopupPropsMultiSelection.menu(
        emptyBuilder: dropDownEmpty,
        showSelectedItems: true,
        itemBuilder: (context, item, isSelected) {
          return ListTile(
            title: Text(item.estacao ?? ''),
            subtitle: Text('Unidade: ${item.unidade}'),
          );
        },
        showSearchBox: true,
      ),
      compareFn: (item, selectedItem) => item.estacao == selectedItem.estacao,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Escolha um filtro",
          suffixIcon: const Icon(Icons.arrow_drop_down),
          labelText: widget.escolha,
        ),
      ),
    );
  }

  dropDicionario() {
    return DropdownSearch<FilterModel>(
      enabled: true,
      onChanged: (value) {
        objFiltro.setTabelasConfig = value;
        print(value);
      },
      asyncItems: (String? filter) =>
          _controllerFiltro.mapaDicionarioModel(widget.escolha),
      itemAsString: (item) => widget.tipoEscolha == 'mensagem'
          ? item.mensagem ?? ''
          : item.titulo ?? '',
      popupProps: PopupPropsMultiSelection.menu(
        emptyBuilder: dropDownEmpty,
        showSelectedItems: true,
        itemBuilder: (context, item, isSelected) {
          return ListTile(
            title: Text(
              widget.tipoEscolha == 'mensagem'
                  ? item.mensagem ?? ''
                  : item.titulo ?? '',
            ),
            subtitle: Text('${item.tabela} / ${item.coluna}'),
          );
        },
        showSearchBox: true,
      ),
      compareFn: (item, selectedItem) => item.coluna == selectedItem.coluna,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Escolha um filtro",
          suffixIcon: const Icon(Icons.arrow_drop_down),
          labelText: widget.escolha,
        ),
      ),
    );
  }

  Widget dropDownEmpty(context, searchEntry) {
    return Column(
      children: const [
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text("Nenhum dado encontrado!"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return opcaoDropDown();
  }
}
