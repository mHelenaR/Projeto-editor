// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, unused_local_variable, sized_box_for_whitespace, avoid_print, no_leading_underscores_for_local_identifiers, await_only_futures, must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:editorconfiguracao/projeto_completo/mensagens/snackbarWarning.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_pesquisa.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_redimencionamento.dart';
import 'package:editorconfiguracao/projeto_completo/tabelas/componentes/barra_pesquisa.dart';

import '../../style_project/style_plutoGrid.dart';

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
  var _recebeCaminhoArquivo = '', conteudoArquivo;
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
  }

  final _controller = SidebarXController(selectedIndex: 0);

  Future<void> arquivoAbrirSeparar() async {
    try {
      if (clicked == true) {
        String? caminhoArquivo = r'/storage/';

        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          initialDirectory: 'C:/frente',
          allowedExtensions: ['cfg'],
          dialogTitle: 'Abrir',
          withData: true,
        );

        if (result != null) {
          caminhoArquivo = result.files.single.path;
          setState(() {
            _recebeCaminhoArquivo = caminhoArquivo!;
          });

          final dadosArquivo = await File(_recebeCaminhoArquivo)
              .readAsStringSync(
                  encoding: const Latin1Codec(allowInvalid: true));

          setState(() {
            conteudoArquivo = dadosArquivo;
          });

          setState(() {
            colunasTabelasArquivo();
          });

          setState(() {
            nomeTabelasArquivo();
          });
        }
      } else {
        erroCarregarArquivo(context);

        setState(() {
          _recebeCaminhoArquivo = '';
        });
      }
    } catch (e) {
      print(e);
      erroTryCatch(context, e);
      setState(() {
        _recebeCaminhoArquivo = '';
      });
    } finally {
      limpaListas();
      clicked = false;
    }
  }

  String _separarArquivo = '';
  List<String> separaTabelasArquivo = [];
  List<String> nomeColSeparada = [];
  List<String> nomeColunas = [];
  List<String> _arrayString = [''];
  List<String> linhaCPO = [];
  List<String> teste1 = [];
  List<String> teste2 = [];
  List<String> teste3 = [];
  List<String> teste4 = [];
  List<String> teste5 = [];
  List<String> gravaArquivo = ['inicio'];
  List<PlutoRow> rows = [];
  List<PlutoColumn> columns = [];

  limpaListas() {
    nomeTabelas.clear();
    listaMenu.clear();
    separaTabelasArquivo.clear();
    nomeColSeparada.clear();
    nomeColunas.clear();
    _arrayString.clear();
    linhaCPO.clear();
    teste1.clear();
    teste2.clear();
    teste3.clear();
    teste4.clear();
    teste5.clear();
    rows.clear();
    columns.clear();
  }

  colunasTabelasArquivo() async {
    try {
      _separarArquivo = await conteudoArquivo;

      separaTabelasArquivo = _separarArquivo.split('TIT ');
      List<String> _linhasTIT = separaTabelasArquivo[1].split('\r\n');

      //----------- TIT------------//

      int posCharacterArquivo = _linhasTIT[0].indexOf('#') + 1;
      nomeColSeparada = [_linhasTIT[0].substring(posCharacterArquivo)];

      // retira o separador
      nomeColunas = nomeColSeparada[0].split('|');

      setState(() {
        _arrayString = nomeColunas;
      });
      setState(
        () {
          //stateManager.notifyListeners();
          columns = <PlutoColumn>[
            if (_controller.selectedIndex == 1) ...{
              PlutoColumn(
                title: 'teste carrega',
                field: 'teste',
                type: PlutoColumnType.text(),
              ),
            } else if (_controller.selectedIndex != 1) ...{
              for (int colTam = 0; colTam < _arrayString.length; colTam++) ...{
                //coluna
                PlutoColumn(
                  title: '$colTam|${_arrayString[colTam]}',
                  field: colTam.toString(),
                  type: PlutoColumnType.text(),
                ),
              }
            }
          ];
        },
      );

      //----------- TIT-FIM-----------//

      //----------- CPO-INICIO-----------//
      for (int i = 1; i < _linhasTIT.length; i++) {
        if (_linhasTIT[i] != '') {
          String testeP = _linhasTIT[i];
          String? testeO = testeP.split('CPO ').toString();
          teste1 = [testeO];
          teste3 = teste3 + teste1;

          for (int p = 0; p < teste3.length; p++) {
            teste2 = teste3[p].split('^');
          }

          setState(
            () {
              rows.addAll(
                [
                  if (_controller.selectedIndex == 1) ...{
                    PlutoRow(
                      cells: {
                        'teste': PlutoCell(value: 'TesteValor'),
                      },
                    ),
                  } else if (_controller.selectedIndex != 1) ...{
                    PlutoRow(
                      cells: {
                        for (int rColTam = 0;
                            rColTam < teste2.length;
                            rColTam++) ...{
                          rColTam.toString(): PlutoCell(
                            value: teste2[rColTam],
                          ),
                        },
                      },
                    ),
                  },
                ],
              );
            },
          );
        }
      }

      //----------- CPO------------//
    } catch (e) {
      erroTryCatch(context, e);
    }
  }

  nomeTabelasArquivo() async {
    try {
      listaTIT = await conteudoArquivo.split('TIT ');
      int posicaoSeparador = 0;

      for (int i = 0; i < listaTIT.length; i++) {
        posicaoSeparador = listaTIT[i].indexOf('#');
        if (posicaoSeparador != -1) {
          nomeTabelas = [listaTIT[i].substring(0, posicaoSeparador)];
        } else {
          nomeTabelas = [];
        }
        setState(() {
          listaMenu = listaMenu + nomeTabelas;
        });
      }
    } catch (e) {
      erroTryCatch(context, e);
    }
  }

  carregarTela() {
    try {
      return Container(
        child: FutureBuilder(
          future: getValue(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return arquivoTabelas();
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.purple.shade300,
                  backgroundColor: canvaCores,
                ),
              );
            }
          },
        ),
      );
    } catch (e) {
      erroTryCatch(context, e);
    }
  }

  Future<String> getValue() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      return 'Aguarde!\n Carregando tabelas!';
    } catch (e) {
      erroTryCatch(context, e);
      return 'Error Delay';
    }
  }

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
            for (int i = 0; i < listaMenu.length; i++) ...{
              SidebarXItem(
                iconWidget: Image.asset(
                  "assets/images/icon_prancheta.png",
                  color: Colors.white,
                ),
                label: listaMenu[i],
              ),
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
                  if (_controller.selectedIndex == 0) arquivoTabelas(),
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
      decoration: styleBarraPesquisa,
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
        createHeader: (stateManager) => headerPlutoGrid(),

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
        primary:
            columnSizeConfig.autoSizeMode.isEqual ? Colors.blue : Colors.grey,
      ),
      onPressed: _handleAutoSizeEqual,
      child: const Text('AutoSize equal'),
    );
  }
}
