import 'package:editorconfiguracao/models/keys_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/controllers/filtro_controller.dart';
import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/box_container.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';
import 'package:editorconfiguracao/widgets/drop_down_widget.dart';
import 'package:editorconfiguracao/widgets/sized_box_widget.dart';

bool isSelected = true;
// class RadioWidget extends StatefulWidget {
//   late String opcao;
//   RadioWidget({
//     Key? key,
//     required this.opcao,
//   }) : super(key: key);
//   @override
//   State<RadioWidget> createState() => _RadioWidgetState();
// }

// class _RadioWidgetState extends State<RadioWidget> {
//   List<String> tabelasDicionario = objSqlite.nomeColunasDcn;
//   final FiltroController _controllerFilter = FiltroController();
//   OpcaoFiltroModel escolha = OpcaoFiltroModel();
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       alignment: Alignment.centerLeft,
//       height: height,
//       duration: const Duration(milliseconds: 550),
//       color: white,
//       child: Row(
//         children: [
//           const SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             child: Container(
//               alignment: Alignment.centerLeft,
//               child: ListView(
//                 children: [
//                   const SizedBox(
//                     height: 28,
//                   ),
//                   SizedBox(
//                     height: 60,
//                     width: 500,
//                     child: DropDownWidget(
//                       tituloFiltro: escolha.escolha,
//                       tipoFiltro: escolha.tipoFiltro,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           // Botão / Dropdown / TextField
//           Flexible(
//             child: Container(
//               width: 100,
//               alignment: Alignment.centerLeft,
//               child: ListView(
//                 children: [
//                   const SizedBox(
//                     height: 35,
//                   ),
//                   ElevatedButton(
//                     style: estiloBotao,
//                     child: const Text("Pesquisar"),
//                     onPressed: () {
//                       FilterModel recebe = objFiltro.tabelasConfig;
//                       for (var i = 0; i < tabelasDicionario.length; i++) {
//                         if (recebe.tabela == tabelasDicionario[i]) {
//                           tabController.index = i;
//                           _controllerFilter.handleFocusToIndex(recebe.coluna);
//                         }
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           Flexible(
//             child: Container(
//               width: 200,
//               alignment: Alignment.centerLeft,
//               child: ListView(
//                 children: [
//                   // Radio Estação
//                   Container(
//                     decoration: boxSelecao1(widget.opcao),
//                     child: RadioListTile(
//                       tileColor: Colors.amber,
//                       activeColor: purple,
//                       groupValue: widget.opcao,
//                       onChanged: (String? value) {
//                         setState(() {
//                           widget.opcao = value!;
//                           escolha.setEscolha = '';
//                           escolha.setEscolha = 'Estação';
//                           escolha.settipoFiltro = 'estacao';
//                           if (kDebugMode) {
//                             print("Filtro escolhido: ${widget.opcao}");
//                           }
//                         });
//                       },
//                       value: FiltroOpcao.estacao.name,
//                       title: const Text('Estação'),
//                     ),
//                   ),
//                   // Radio Conteudo
//                   Container(
//                     decoration: boxSelecao2(widget.opcao),
//                     child: RadioListTile(
//                       activeColor: purple,
//                       groupValue: widget.opcao,
//                       onChanged: (String? value) {
//                         setState(() {
//                           widget.opcao = value!;
//                           escolha.setEscolha = '';
//                           escolha.setEscolha = 'Conteúdo';
//                           if (kDebugMode) {
//                             print("Filtro escolhido: ${widget.opcao}");
//                           }
//                         });
//                       },
//                       value: FiltroOpcao.conteudo.name,
//                       title: const Text('Conteúdo'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Flexible(
//             child: SizedBox(
//               width: 280,
//               child: ListView(
//                 children: [
//                   // Radio Descrição
//                   Container(
//                     decoration: boxSelecao4(widget.opcao),
//                     child: RadioListTile(
//                       activeColor: purple,
//                       groupValue: widget.opcao,
//                       onChanged: (String? value) {
//                         setState(() {
//                           widget.opcao = value!;
//                           escolha.setEscolha = '';
//                           escolha.setEscolha = 'Descrição';
//                           escolha.settipoFiltro = 'mensagem';
//                           if (kDebugMode) {
//                             print("Filtro escolhido: ${widget.opcao}");
//                           }
//                         });
//                       },
//                       value: FiltroOpcao.mensagem.name,
//                       title: const Text('Descrição Tabela Dicionário'),
//                     ),
//                   ),
//                   // Radio Subtítulo
//                   Container(
//                     decoration: boxSelecao3(widget.opcao),
//                     child: RadioListTile(
//                       activeColor: purple,
//                       groupValue: widget.opcao,
//                       onChanged: (String? value) {
//                         setState(() {
//                           widget.opcao = value!;
//                           escolha.setEscolha = '';
//                           escolha.setEscolha = 'SubTitulo';
//                           escolha.settipoFiltro = 'titulo';
//                           if (kDebugMode) {
//                             print("Filtro escolhido: ${widget.opcao}");
//                           }
//                         });
//                       },
//                       value: FiltroOpcao.subTitulo.name,
//                       title: const Text('SubTítulo'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class RadioWidget extends StatefulWidget {
  late String opcao;
  RadioWidget({
    Key? key,
    required this.opcao,
  }) : super(key: key);
  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  OpcaoFiltroModel escolha = OpcaoFiltroModel();
  final FiltroController _controllerFiltro = FiltroController();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.centerLeft,
      height: height,
      duration: const Duration(milliseconds: 550),
      color: white,
      child: SizedBox(
        child: Row(
          children: [
            boxWidth10(),
            sizedDopDown('Estação', 'estacao'),
            boxWidth10(),
            sizedDopDown('Coluna', 'Coluna'),
            boxWidth10(),
            sizedDopDown('Descrição', 'mensagem'),
            boxWidth10(),
            sizedDopDown('Subtítulo', 'titulo'),
            boxWidth10(),
            buttonsFilter(),
          ],
        ),
      ),
    );
  }

  sizedDopDown(String titleDopDown, String tipoFiltro) {
    return Flexible(
      child: SizedBox(
        height: 60,
        width: 500,
        child: ListView(
          children: [
            DropDownWidget(
              tituloFiltro: titleDopDown,
              tipoFiltro: tipoFiltro,
            ),
          ],
        ),
      ),
    );
  }

  buttonsFilter() {
    return Flexible(
      child: Container(
        width: 100,
        alignment: Alignment.centerLeft,
        child: ListView(
          children: [
            boxHeight10(),
            Center(
              child: ElevatedButton(
                style: estiloBotao,
                onPressed: () {
                  DropKey.estacKeyCodigo.currentState!.clear();
                  DropKey.estacKeyColuna.currentState!.clear();
                  DropKey.estacKeyDescricao.currentState!.clear();
                  DropKey.estacKeySubtitulo.currentState!.clear();
                  objEstacaoModel.setTeste = false;

                  setState(() {
                    if (isSelected == true) {
                      isSelected = false;
                    } else {
                      isSelected = true;
                    }
                  });
                },
                child: const Text('Voltar'),
              ),
            ),
            boxHeight10(),
            Center(
              child: ElevatedButton(
                style: estiloBotao,
                onPressed: () {
                  if (objEstacaoModel.estacaoNumero != null &&
                      objEstacaoModel.colunaNome != null) {
                    FilterEstacModel recebe = objEstacaoModel.estacaoNumero;
                    FilterEstacModel coluna = objEstacaoModel.colunaNome;

                    _controllerFiltro.handleFocusTESTE1(
                      coluna.coluna,
                      int.parse(recebe.posicao!) - 1,
                    );
                  }
                },
                child: const Text('Pesquisar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
