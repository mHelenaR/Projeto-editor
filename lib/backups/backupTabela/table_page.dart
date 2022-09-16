// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, unused_local_variable, sized_box_for_whitespace, avoid_print, no_leading_underscores_for_local_identifiers, await_only_futures, must_be_immutable

import 'dart:io';

import 'package:editorconfiguracao/projeto_completo/separa_arquivo/nome_tabelas.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_plutoGrid.dart';
import 'package:editorconfiguracao/projeto_completo/tabelas/corpo_tabela/variaveis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:editorconfiguracao/projeto_completo/mensagens/snackbarWarning.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/seleciona_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_redimencionamento.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_textField.dart';
import 'package:editorconfiguracao/backups/backupTabela/componentes/barra_pesquisa.dart';



class Arquivo extends StatelessWidget {
  const Arquivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArquivoPagina(),
    );
  }
}

class ArquivoPagina extends StatefulWidget {
  ArquivoPagina({Key? key}) : super(key: key);

  @override
  State<ArquivoPagina> createState() => _ArquivoPaginaState();
}

class _ArquivoPaginaState extends State<ArquivoPagina> {
  var _recebeCaminhoArquivo = '';

  String conteudoArquivo = '';

  PlutoGridColumnSizeConfig columnSizeConfig =
      const PlutoGridColumnSizeConfig();

  late final void Function(PlutoGridColumnSizeConfig) setConfig;
  late PlutoGridStateManager gerenciador;
  late PlutoGridStateManager stateManager;

  var rot = ValueNotifier(0);

  bool clicked = false;

  List<String> listaTIT = [];
  List<String> nomeTabelas = [];
  List<String> listaMenu = [''];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    rot.dispose();
  }

  final _controller = SidebarXController(selectedIndex: 0);
  PageController controlaPagina = PageController(initialPage: 0);

  Future<void> arquivoAbrirSeparar() async {
    try {
      caminhoArquivo = await arquivoTabela();
      setState(() {
        controleArquivo.text = caminhoArquivo!;
      });
      if (caminhoArquivo != null) {
        recebeCaminhoArquivo = caminhoArquivo!;

        conteudoArquivo = await converteArquivo(recebeCaminhoArquivo);

        setState(() {
          conteudoArquivo;
        });

        nomeTabelas = await nomeTabelasArquivo(conteudoArquivo);

        setState(() {
          getWidgets();
          controlaPagina;
          // tabController = TabController(length: tabs.length, vsync: this);
        });
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  List<Widget> getWidgets() {
    criarWidgets.clear();

    for (int i = 0; i < 5; i++) {
      criarWidgets.add(carregarTela(i));
    }

    return criarWidgets;
  }

  carregarTela(var controle) {
    return FutureBuilder(
      future: delay(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return criaTabViewTabela(controle);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<String> delay() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Aguarde!\n Carregando tabelas!';
  }

  Widget criaTabViewTabela(int widgetNumber) {
    rows.clear();
    columns.clear();
    listaTIT.clear();
    nomeColunas.clear();
    teste4.clear();
    teste5.clear();

    separarArquivo = "";

    String? recebeTabela;
    if (conteudoArquivo != "" && conteudoArquivo != null) {
      separarArquivo = conteudoArquivo;

      debugPrint("Numero da tab: $widgetNumber");

      for (int i = 0; i < nomeTabelas.length; i++) {
        int contador = widgetNumber + 1;
        String start = 'TIT ${nomeTabelas[widgetNumber]}#';

        if (contador == nomeTabelas.length) {
          contador = contador - 1;

          final startIndex = separarArquivo.indexOf(start);

          recebeTabela = separarArquivo.substring(
              startIndex + start.length, separarArquivo.length);
        } else {
          String end = 'TIT ${nomeTabelas[contador]}#';

          final startIndex = separarArquivo.indexOf(start);

          final endIndex =
              separarArquivo.indexOf(end, startIndex + start.length);

          recebeTabela =
              separarArquivo.substring(startIndex + start.length, endIndex);
        }
      }

      List<String> linhasTIT = recebeTabela!.split("\r\n");
      nomeColunas = linhasTIT[0].split('|');

      columns = <PlutoColumn>[
        for (int contCol = 0; contCol < nomeColunas.length; contCol++) ...{
          PlutoColumn(
            textAlign: PlutoColumnTextAlign.center,
            title: nomeColunas[contCol],
            field: contCol.toString(),
            type: PlutoColumnType.text(),
          ),
        }
      ];

      for (int i = 1; i < linhasTIT.length; i++) {
        if (linhasTIT[i] != "") {
          String testeP = linhasTIT[i];
          teste4 = [testeP.split('CPO ').toString()];

          for (int p = 0; p < teste4.length; p++) {
            teste5 = teste4[p].split('^');

            rows.addAll([
              PlutoRow(
                cells: {
                  for (contRow = 0; contRow < teste5.length; contRow++) ...{
                    contRow.toString(): PlutoCell(value: teste5[contRow]),
                  },
                },
              ),
            ]);
          }
          testeP = "";
        }
      }
      contCol = 0;
      contRow = 0;
      linhasTIT.clear();
    }
    return PlutoGrid(
      configuration: configuracaoPlutoGrid,
      columns: columns,
      rows: rows,
      onChanged: (PlutoGridOnChangedEvent event) {
        debugPrint("$event");
      },
      onLoaded: (PlutoGridOnLoadedEvent event) {
        event.stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
        stateManager = event.stateManager;
      },
      createFooter: (stateManager) {
        return Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 30,
                child: Text("Dicionario"),
              ),
            ),
          ],
        );
      },
    );
  }

  navigateToPage(int index) {}
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SidebarX(
          controller: _controller,
          theme: StyleSideBar,
          extendedTheme: StyleExpandeSideBar,
          footerDivider: dividerWhite,
          headerDivider: dividerPurple,
          headerBuilder: (context, extended) {
            return SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/icon_archive.png',
                ),
              ),
            );
          },
          items: [
            for (int i = 0; i < nomeTabelas.length; i++) ...{
              SidebarXItem(
                  iconWidget: Image.asset(
                    "assets/images/icon_prancheta.png",
                    color: Colors.white,
                  ),
                  label: nomeTabelas[i],
                  onTap: () {
                    setState(() {
                      navigateToPage(_controller.selectedIndex);
                    });
                  }),
            },
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                children: [
                  arquivoAppBarTable(
                    context,
                    arquivoBarraPesquisa(),
                    arquivoBotaoPesquisa(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  arquivoBusca(),
                  if (_controller.selectedIndex < 5) ...{
                    Expanded(
                      child: PageView(
                        onPageChanged: (value) {
                          navigateToPage(value);
                        },
                        controller: controlaPagina,
                        children: getWidgets(),
                      ),
                    )
                  }
                ],
              );
            },
          ),
        )
      ],
    );
  }

  Widget arquivoBarraPesquisa() {
    return TextFormField(
      decoration: styleBarraPesquisa(white),
    );
  }

  Widget arquivoBotaoPesquisa() {
    return ElevatedButton(
      onPressed: () {},
      style: estiloBotao,
      child: const Text('Pesquisar'),
    );
  }

  Future<void> _writeData() async {
    if (clicked == false) {
      final _dirPath = await _recebeCaminhoArquivo;
      if (_recebeCaminhoArquivo != '') {
        final _myFile = File(_dirPath);

        for (int i = 0; i < gravaArquivo.length; i++) {
          if (gravaArquivo[i] != 'inicio') {
            await _myFile.writeAsString(gravaArquivo.toString());
          } else {
            Builder(
              builder: (context) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("erro"),
                  ),
                );
                return const Text('');
              },
            );
          }
        }
      } else {
        erroSalvarArquivo(context);
      }
    } else {
      // gerar o erro correto
      erroSalvarArquivo(context);
    }
  }

  Widget arquivoTabelas() {
    return Flexible(
      child: Container(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: arquivoGridTabelas(),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget arquivoBusca() {
    var nomeArquivo;
    if (_recebeCaminhoArquivo == '') {
      nomeArquivo = 'Arquivo';
    } else {
      nomeArquivo = _recebeCaminhoArquivo;
    }

    return SizedBox(
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 70,
              //color: Colors.amber,
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 400,
                      height: 35,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.archive),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: nomeArquivo,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        rot.value++;
                        print(rot.value);
                        clicked = true;
                        arquivoAbrirSeparar();
                      },
                      style: estiloBotao,
                      child: const Text("Procurar"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        print(gravaArquivo);
                        _writeData();
                      },
                      style: estiloBotao,
                      child: const Text("Salvar"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget arquivoGridTabelas() {
    return Container(
      height: tamanho(context),
      child: PlutoGrid(
        createFooter: (stateManager) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  child: const Text("Dicionário"),
                ),
              ),
            ],
          );
        },
        //createHeader: (stateManager) => headerPlutoGrid(),

        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          // stateManager.setShowLoading(true);
        },
        //pega o valor das celulas
        onChanged: (PlutoGridOnChangedEvent event) {
          print(event.value);
          if (event.oldValue != event.value) {
            gravaArquivo.add(event.value);
            print(event.oldValue);
          } else {
            gravaArquivo.add(event.oldValue);
          }
        },

        configuration: configuracaoPlutoGrid,

        columns: columns,
        rows: rows,
      ),
    );
  }

  Widget headerPlutoGrid() {
    return SizedBox(
      height: 37,
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          ElevatedButton(
            style: estiloBotao,
            onPressed: () {
              stateManager.setShowColumnFilter(!stateManager.showColumnFilter);
            },
            child: const Text('Filtro'),
          ),
          ElevatedButton(
            onPressed: _handleAutoSizeEqual,
            child: const Text("Tamanhos Iguais"),
          ),
        ],
      ),
    );
  }

  void _setAutoSize(PlutoAutoSizeMode mode) {
    columnSizeConfig = columnSizeConfig.copyWith(
      autoSizeMode: mode,
    );
    setState(() {
      setConfig(columnSizeConfig);
    });
  }

  void _handleAutoSizeEqual() {
    _setAutoSize(PlutoAutoSizeMode.equal);
  }
}

class _Header extends StatefulWidget {
  const _Header({
    required this.setConfig,
    Key? key,
  }) : super(key: key);

  final void Function(PlutoGridColumnSizeConfig) setConfig;

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  PlutoGridColumnSizeConfig columnSizeConfig =
      const PlutoGridColumnSizeConfig();

  void _setAutoSize(PlutoAutoSizeMode mode) {
    setState(() {
      columnSizeConfig = columnSizeConfig.copyWith(
        autoSizeMode: mode,
      );
      widget.setConfig(columnSizeConfig);
    });
  }

  void _handleAutoSizeEqual() {
    _setAutoSize(PlutoAutoSizeMode.equal);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: columnSizeConfig.autoSizeMode.isEqual ? Colors.blue : grey,
      ),
      onPressed: _handleAutoSizeEqual,
      child: const Text('AutoSize equal'),
    );
  }
}
