import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/controllers/edicao_controller1.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/nome_tabelas.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/salvar_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/seleciona_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_borderRadius.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_fontes.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_tabBar.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_textField.dart';
import 'package:editorconfiguracao/utils/variaveis.dart';
import 'package:editorconfiguracao/widgets/radio_widget.dart';

class TelaEdicao extends StatefulWidget {
  const TelaEdicao({super.key});

  @override
  State<TelaEdicao> createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> with TickerProviderStateMixin {
  //Listas
  List<Widget> listaTabs = [];

  //Objetos
  EdicaoController objEdicaoController = EdicaoController();

  //Controllers
  TabController getTabController() =>
      TabController(length: listaTabs.length, vsync: this);
  final TextEditingController controleArquivo = TextEditingController();

  @override
  void initState() {
    objEdicaoModel.setAtivaTabelas = false;
    tabController = getTabController();
    super.initState();
  }

  @override
  void dispose() {
    controleArquivo.dispose();
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

        listaTabs.clear();

        for (var i = 0; i < nomeTabelas.length; i++) {
          listaTabs.add(
            Tab(
              text: nomeTabelas[i],
            ),
          );
        }

        setState(() {
          objEdicaoController.carregarTela();

          tabController = TabController(length: listaTabs.length, vsync: this);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
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
                            "Editar Configurações",
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
                                  setState(() {
                                    objEdicaoModel.setAtivaTabelas = false;
                                  });
                                },
                                style: estiloBotao,
                                child: const Text("Abrir"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  gravarArquivo();
                                },
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
                    tabs: listaTabs,
                    controller: tabController,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (objEdicaoModel.ativaTabelas == true) ...{
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: objEdicaoController.tabelasConfig(listaTabs),
            ),
          ),
        } else if (objEdicaoModel.ativaTabelas == false) ...{
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        }
      ],
    );
  }
}
