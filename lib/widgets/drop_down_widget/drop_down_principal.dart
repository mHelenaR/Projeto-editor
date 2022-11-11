// ignore_for_file:  must_be_immutable
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/styles/box_container.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';

class DropDownPrincipal extends StatefulWidget {
  late String opcao;
  DropDownPrincipal({
    required this.opcao,
    Key? key,
  }) : super(key: key);
  @override
  State<DropDownPrincipal> createState() => _DropDownPrincipalState();
}

class _DropDownPrincipalState extends State<DropDownPrincipal> {
  List<String> tabelasDicionario = objSqlite.nomeColunasDcn;

  OpcaoFiltroModel escolha = OpcaoFiltroModel();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Container(
                width: 100,
                alignment: Alignment.centerLeft,
                child: ListView(
                  children: [
                    Center(
                      child: ElevatedButton(
                        style: estiloBotao,
                        child: const Text("Estação"),
                        onPressed: () {
                          setState(() {
                            filtro = "estacao";
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: estiloBotao,
                        child: const Text("Conteúdo"),
                        onPressed: () {
                          setState(() {
                            filtro = "Conteudo";
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: estiloBotao,
                        child: const Text("Dicionário"),
                        onPressed: () {
                          setState(() {
                            filtro = "Dicionario";
                          });
                        },
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     ElevatedButton(
                    //       style: estiloBotao,
                    //       child: const Text("Dicionário"),
                    //       onPressed: () {},
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     ElevatedButton(
                    //       style: estiloBotao,
                    //       child: const Text("Pesquisar"),
                    //       onPressed: () {
                    // FilterModel recebe = objFiltro.tabelasConfig;
                    // for (var i = 0;
                    //     i < tabelasDicionario.length;
                    //     i++) {
                    //   if (recebe.tabela == tabelasDicionario[i]) {
                    //     tabController.index = i;
                    //     _controllerFilter
                    //         .handleFocusToIndex(recebe.coluna);
                    //   }
                    // }
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Container(
                width: 200,
                alignment: Alignment.centerLeft,
                child: ListView(
                  children: [
                    // Radio Estação
                    Container(
                      decoration: boxSelecao1(widget.opcao),
                      child: RadioListTile(
                        tileColor: Colors.amber,
                        activeColor: purple,
                        groupValue: widget.opcao,
                        onChanged: (String? value) {
                          setState(() {
                            widget.opcao = value!;
                            escolha.setEscolha = '';
                            escolha.setEscolha = 'Estação';
                            escolha.settipoFiltro = 'estacao';
                            filtro = "estacao";

                            if (kDebugMode) {
                              print("Filtro escolhido: ${widget.opcao}");
                            }
                          });
                        },
                        value: FiltroOpcao.estacao.name,
                        title: const Text('Estação'),
                      ),
                    ),
                    // Radio Conteudo
                    Container(
                      decoration: boxSelecao2(widget.opcao),
                      child: RadioListTile(
                        activeColor: purple,
                        groupValue: widget.opcao,
                        onChanged: (String? value) {
                          setState(() {
                            widget.opcao = value!;
                            escolha.setEscolha = '';
                            escolha.setEscolha = 'Coluna';
                            if (kDebugMode) {
                              print("Filtro escolhido: ${widget.opcao}");
                            }
                          });
                        },
                        value: FiltroOpcao.conteudo.name,
                        title: const Text('Conteúdo'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: SizedBox(
                width: 280,
                child: ListView(
                  children: [
                    // Radio Descrição
                    Container(
                      decoration: boxSelecao4(widget.opcao),
                      child: RadioListTile(
                        activeColor: purple,
                        groupValue: widget.opcao,
                        onChanged: (String? value) {
                          setState(() {
                            widget.opcao = value!;

                            escolha.setEscolha = "Dicionario";
                            escolha.settipoFiltro = 'mensagem';
                            if (kDebugMode) {
                              print("Filtro escolhido: ${widget.opcao}");
                            }
                          });
                        },
                        value: FiltroOpcao.mensagem.name,
                        title: const Text('Descrição Tabela Dicionário'),
                      ),
                    ),
                    // Radio Subtítulo
                    Container(
                      decoration: boxSelecao3(widget.opcao),
                      child: RadioListTile(
                        activeColor: purple,
                        groupValue: widget.opcao,
                        onChanged: (String? value) {
                          setState(() {
                            widget.opcao = value!;

                            escolha.setEscolha = 'Dicionario';
                            escolha.settipoFiltro = 'titulo';
                            if (kDebugMode) {
                              print("Filtro escolhido: ${widget.opcao}");
                            }
                          });
                        },
                        value: FiltroOpcao.subTitulo.name,
                        title: const Text('SubTítulo'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
