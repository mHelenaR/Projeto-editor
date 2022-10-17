// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_search/dropdown_search.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/controllers/filtro_controller.dart';

class DropDownWidget extends StatefulWidget {
  late dynamic escolha;
  late dynamic tipoEscolha;

  DropDownWidget({
    Key? key,
    required this.escolha,
    required this.tipoEscolha,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final FiltroController _controllerFiltro = FiltroController();
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<String, dynamic>>(
      onChanged: (value) => objFiltro.setTabelasConfig = value,
      asyncItems: (String? filter) =>
          _controllerFiltro.mapaDicionario(widget.escolha),
      itemAsString: (item) => item['${widget.tipoEscolha}'] ?? '',
      popupProps: PopupPropsMultiSelection.menu(
        emptyBuilder: (context, searchEntry) {
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
        },
        showSelectedItems: true,
        itemBuilder: (context, item, isSelected) {
          String? subTitulo;

          if (widget.tipoEscolha != null) {
            if (widget.tipoEscolha == 'mensagem') {
              subTitulo = 'titulo';
            } else {
              subTitulo = 'mensagem';
            }
          }

          return ListTile(
            title: Text(item['${widget.tipoEscolha}'] ?? ""),
            subtitle: Text('${item['tabela']} / ${item['mensagem']}'),
          );
        },
        showSearchBox: true,
      ),
      compareFn: (item, selectedItem) =>
          item['coluna'] == selectedItem['coluna'],
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
}
