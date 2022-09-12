// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, unused_local_variable, sized_box_for_whitespace, avoid_print, no_leading_underscores_for_local_identifiers, await_only_futures, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:editorconfiguracao/projeto_completo/mensagens/snackbarWarning.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/linhasCPO.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/linhasTIT.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/nome_tabelas.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/seleciona_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_redimencionamento.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_textField.dart';
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
  final controla = StreamController();

  Future<void> arquivoAbrirSeparar() async {
    try {
      if (clicked == true) {
        _recebeCaminhoArquivo = await arquivoTabela();

        setState(() {
          _recebeCaminhoArquivo;
        });

        conteudoArquivo = await converteArquivo(_recebeCaminhoArquivo);

        setState(() {
          colunasTabelasArquivo();
        });

        setState(() {
          nomeTabelasArquivos();
        });
      } else {
        erroCarregarArquivo(context);

        setState(() {
          conteudoArquivo = '';
        });
      }
    } catch (e) {
      print(e);
      erroTryCatch(context, e);
      setState(() {
        _recebeCaminhoArquivo = '';
      });
    } finally {
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

  colunasTabelasArquivo() async {
    try {
      columns = await colunasNome(conteudoArquivo, _controller);
      controla.add(arquivoGridTabelas());
      rows = await linhasCpoArquivo(conteudoArquivo, _controller);
    } catch (e) {
      erroTryCatch(context, e);
    }
  }

  nomeTabelasArquivos() async {
    try {
      listaMenu = await nomeTabelasArquivo(_recebeCaminhoArquivo);
    } catch (e) {
      erroTryCatch(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SidebarX(
          separatorBuilder: (context, index) {
            return Text("data");
          },
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
                onTap: () {
                  setState(() {
                    arquivoTabelas();
                  });
                },
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
                  if (_controller.selectedIndex != 0) ...{
                    arquivoTabelas(),
                  }
                ],
              );
            },
          ),
        )
      ],
    );
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

  var databaseFactory = databaseFactoryFfi;

  Future<String> teste() async {
    var novo = await databaseFactory
        .openDatabase('C:\\baseDados flutter\\Dicionario.db');
    var batch = await novo.batch();

    List<Map> nomew = await novo.query('aliquota',
        columns: ['titulo'], where: 'campo = ?', whereArgs: ['ALQ_CODTRIB']);
    String? teste;
    setState(() {
      for (var row in nomew) {
        teste = row.values.toString();
      }
    });

    print(teste);
    return teste!;
  }

  String nomes = 'teste';
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
                      onPressed: () {},
                      style: estiloBotao,
                      child: const Text("Salvar"),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () async {
                        nomes = await teste();
                      },
                      style: estiloBotao,
                      child: const Text("Carrega"),
                    ),
                  ),
                  Flexible(
                    child: Text(nomes),
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
}
