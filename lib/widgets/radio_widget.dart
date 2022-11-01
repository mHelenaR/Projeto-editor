// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:editorconfiguracao/controllers/filtro_controller.dart';
import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/models/keys_model.dart';
import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';
import 'package:editorconfiguracao/widgets/drop_down_widget/drop_down_widget.dart';
import 'package:editorconfiguracao/widgets/sized_box_widget.dart';

bool isSelected = true;

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
  List<String> tabelasDicionario = objSqlite.nomeColunasDcn;

  final FiltroController _controllerFiltro = FiltroController();

  OpcaoFiltroModel escolha = OpcaoFiltroModel();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.centerLeft,
      height: height,
      duration: const Duration(milliseconds: 550),
      color: white,
      child: Row(
        children: [
          if (filtro == "estacao") ...{
            drop(),
          } else if (filtro == 'principal') ...{
            radioButton(),
          } else if (filtro == "Conteudo") ...{
            ElevatedButton(
              onPressed: () {
                setState(() {
                  filtro = 'principal';
                });
              },
              child: const Text('Voltar'),
            ),
            sizedDopDown('tabelaPrincipal', 'tabelaPrincipal'),
          } else if (filtro == "Dicionario") ...{
            ElevatedButton(
              onPressed: () {
                setState(() {
                  filtro = 'principal';
                });
              },
              child: const Text('Voltar'),
            ),
          }
        ],
      ),
    );
  }

  drop() {
    return Expanded(
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
                  setState(() {
                    filtro = 'principal';
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
                    FilterModel recebe = objEstacaoModel.estacaoNumero;
                    FilterModel coluna = objEstacaoModel.colunaNome;

                    _controllerFiltro.focarCelulaFiltro(
                      coluna.coluna,
                      int.parse(recebe.posicao!) - 1,
                      coluna.dicionario,
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

  radioButton() {
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
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            sizedDopDown('Focar Tabelas', 'tabelaPrincipal'),
            boxWidth10(),
            sizedDopDown('Dicio. Descrição', 'mensagemDicio'),
            boxWidth10(),
            sizedDopDown('Dicio. Subtítulo', 'tituloDicio'),
            boxWidth10(),
            boxWidth10(),
            ElevatedButton(
              onPressed: () {
                if (objEstacaoModel.verificaRow != []) {
                  FilterModel coluna = objEstacaoModel.colunaNome;

                  _controllerFiltro.focarColuna(coluna.coluna);
                }
              },
              child: const Text('Pesquisar'),
            ),
          ],
        ),
      ),
    );
  }
}
