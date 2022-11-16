import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/controllers/edicao_controller.dart';
import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/nome_tabelas.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/salvar_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/seleciona_arquivo.dart';
import 'package:editorconfiguracao/utils/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_borderRadius.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_fontes.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_tabBar.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_textField.dart';
import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';
import 'package:editorconfiguracao/widgets/radio_widget.dart';

class TelaEdicao extends StatefulWidget {
  const TelaEdicao({super.key});

  @override
  State<TelaEdicao> createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> with TickerProviderStateMixin {
  final EdicaoController _edicaoController = EdicaoController();
  final TextEditingController controleArquivo = TextEditingController();
  OpcaoFiltroModel escolha = OpcaoFiltroModel();

  List<String> tabelasDicionario = objSqlite.nomeColunasDcn;

  TabController getTabController() {
    return TabController(length: tabs.length, vsync: this);
  }

  @override
  void initState() {
    tabController = getTabController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  expandeContainer() {
    if (height == 100) {
      setState(() {
        cor = white;
        height = 0.0;
      });
    } else {
      setState(() {
        cor = grey.shade500;
        height = 100;
      });
    }
  }

  Future<void> arquivoAbrirSeparar() async {
    try {
      caminhoArq = await arquivoTabela();
      setState(() {
        controleArquivo.text = caminhoArq!;
      });

      if (caminhoArq != null) {
        setState(() {
          recebeCaminhoArquivo = caminhoArq!;
        });

        conteudoArquivo = await converteArquivo(recebeCaminhoArquivo);

        // Passando o arquivo para o objeto de gravação
        objArquivoGravacao.setArquivoGR = conteudoArquivo;

        nomeTabelas = await nomeTabelasArquivo(conteudoArquivo);

        nomeTab(nomeTabelas.length);

        tabs = criaTab(nomeTabelas.length);

        setState(() {
          tabelasConfig();
          tabController = TabController(length: tabs.length, vsync: this);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Tab nomeTab(int widgetNumber) {
    setState(() {
      widgetNumber;
    });

    if (widgetNumber == nomeTabelas.length) {
      widgetNumber = widgetNumber - 1;
    }

    return Tab(text: nomeTabelas[widgetNumber]);
  }

  List<Tab> criaTab(int count) {
    tabs.clear();

    for (int i = 0; i < count; i++) {
      tabs.add(nomeTab(i));
    }

    return tabs;
  }

  List<Widget> tabelasConfig() {
    List<Widget> criarWidgets = [];
    criarWidgets.clear();

    for (int i = 0; i < tabs.length; i++) {
      criarWidgets.add(_edicaoController.carregarTela(i));
    }

    return criarWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          child: Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 70,
                  child: AppBar(
                    elevation: 2,
                    backgroundColor: white,
                    actions: [
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Edição de Tabelas",
                            style: fontePreta,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              readOnly: true,
                              controller: controleArquivo,
                              decoration: styleBarraArquivo,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  arquivoAbrirSeparar();
                                },
                                style: estiloBotao,
                                child: const Text("Abrir"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () => gravarArquivo(),
                                style: estiloBotao,
                                child: const Text("Salvar"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  expandeContainer();
                                  setState(() {
                                    filtro = 'principal';
                                  });
                                },
                                style: estiloBotao,
                                child: const Text("Filtrar"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        RadioWidget(),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Flexible(
                child: AppBar(
                  backgroundColor: white,
                  title: TabBar(
                    indicator: boxTopLR,
                    unselectedLabelColor: grey,
                    labelColor: white,
                    splashBorderRadius: border40,
                    isScrollable: true,
                    tabs: tabs,
                    controller: tabController,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: _edicaoController.delay2(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return TabBarView(
                    controller: tabController,
                    children: tabelasConfig(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
