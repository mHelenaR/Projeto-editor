import 'package:dropdown_search/dropdown_search.dart';
import 'package:editorconfiguracao/models/keys_model.dart';
import 'package:editorconfiguracao/widgets/radio_widget.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/controllers/filtro_controller.dart';
import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';

class DropDownWidget extends StatefulWidget {
  final dynamic tituloFiltro;
  final dynamic tipoFiltro;

  const DropDownWidget({
    Key? key,
    required this.tituloFiltro,
    required this.tipoFiltro,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  GlobalKey<DropdownSearchState> _key = GlobalKey<DropdownSearchState>();
  List<String> tabelasDicionario = objSqlite.nomeColunasDcn;
  final FiltroController _controllerFiltro = FiltroController();

  dropEstacao() {
    return DropdownSearch<FilterModel>(
      enabled: isSelected,
      key: DropKey.estacKeyCodigo,
      onChanged: (value) {
        objEstacaoModel.setEstacaoNumero = value;
      },
      asyncItems: (String? filter) =>
          _controllerFiltro.mapaEstacao(widget.tituloFiltro),
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
          labelText: widget.tituloFiltro,
        ),
      ),
    );
  }

  dropConteudo() {
    return DropdownSearch<FilterModel>(
      onChanged: (value) {
        objEstacaoModel.setColunaNome = value;
      },
      key: DropKey.estacKeyColuna,
      asyncItems: (String? filter) =>
          _controllerFiltro.mapaColunasModel(widget.tituloFiltro),
      itemAsString: (item) => item.coluna ?? "",
      popupProps: PopupPropsMultiSelection.menu(
        emptyBuilder: dropDownEmpty,
        showSelectedItems: true,
        itemBuilder: (context, item, isSelecte) {
          return ListTile(
            title: Text(item.coluna ?? ''),
            // subtitle: Text('Unidade: ${'item.unidade'}'),
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
          labelText: widget.tituloFiltro,
        ),
      ),
    );
  }

  dropDicionario() {
    if (widget.tipoFiltro == 'mensagem') {
      _key = DropKey.estacKeyDescricao;
    } else if (widget.tipoFiltro == 'titulo') {
      _key = DropKey.estacKeySubtitulo;
    }
    return DropdownSearch<FilterModel>(
      key: _key,
      onChanged: (value) {
        objEstacaoModel.setColunaNome = value;
        objFiltro.setTabelasConfig = value;
      },
      asyncItems: (String? filter) =>
          _controllerFiltro.mapaDicionarioModel(widget.tituloFiltro),
      itemAsString: (item) => widget.tipoFiltro == 'mensagem'
          ? item.mensagem ?? ''
          : item.titulo ?? '',
      popupProps: PopupPropsMultiSelection.menu(
        emptyBuilder: dropDownEmpty,
        showSelectedItems: true,
        itemBuilder: (context, item, isSelected) {
          return ListTile(
            title: Text(
              widget.tipoFiltro == 'mensagem'
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
          labelText: widget.tituloFiltro,
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
    if (widget.tituloFiltro == 'Estação') {
      return dropEstacao();
    } else if (widget.tituloFiltro == 'Coluna') {
      return dropConteudo();
    } else {
      return dropDicionario();
    }
  }
}
