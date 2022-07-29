// ignore_for_file: unused_import, prefer_const_constructors_in_immutables, unused_element, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, unused_field, unused_local_variable, await_only_futures, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:editorconfiguracao/projeto_completo/abre%20arquivo/abreExplorador.dart';

import 'package:editorconfiguracao/projeto_completo/componentes_telas/app_bar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_pesquisa.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../style_project/style_plutoGrid.dart';

class Arquivo extends StatelessWidget {
  const Arquivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ArquivoPagina(),
      ),
    );
  }
}

class ArquivoPagina extends StatefulWidget {
  ArquivoPagina({Key? key}) : super(key: key);

  @override
  State<ArquivoPagina> createState() => _ArquivoPaginaState();
}

class _ArquivoPaginaState extends State<ArquivoPagina> {
  var _recebeCaminhoArquivo, conteudoArquivo;

  List<String> nomeTabelas = [];
  List<String> listaMenu = ['teste'];

  final _controller = SidebarXController(selectedIndex: 0);

  final String _separarArquivo = '';
  List<String> separaTabelasArquivo = [];
  List<String> nomeColSeparada = [];
  List<String> nomeColunas = [];
  final List<String> _arrayString = [''];
  List<String> linhaCPO = [];
  List<String> teste1 = [];
  List<String> teste2 = [];
  List<String> teste3 = [];
  List<String> teste4 = [];
  List<String> teste5 = [];
  // List<String> _linhasTIT = [];

  List<PlutoRow> rows = [];
  List<PlutoColumn> columns = [];

// função para limpar as listas
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

  nomeTabelasArquivo() {
    limpaListas();

    conteudoArquivo = 'TIT teste#tabela1-1|tabela1-2|tabela1-3|tabela1-4|\r\nCPO 001^002^003^004^\r\nCPO 005^006^007^008^\r\nCPO 009^010^011^012^\r\nTIT teste1#tabela2-1|tabela2-2|tabela2-3|tabela2-4|\r\nCPO 100^200^300^400^\r\nCPO 500^600^700^800^\r\nCPO 900^100^110^120^\r\n';
    List<String> listaTIT = conteudoArquivo.split('TIT ');
    int posicaoSeparador = 0;

    for (int i = 0; i < listaTIT.length; i++) {
      posicaoSeparador = listaTIT[i].indexOf('#');
      if (posicaoSeparador != -1) {
        nomeTabelas = [listaTIT[i].substring(0, posicaoSeparador)];
      }
      setState(() {
        listaMenu = listaMenu + nomeTabelas;
        //testeMapa[i] = listaMenu.toString();
      });
    }
  }

  //Map<int, String> testeMapa = {0: 'teste', 1: 'teste1'};
  //var cont = 0;
  teste() {
    for (int i = 0; i < listaMenu.length; i++) {
      //  print(i);

      if (_controller.selectedIndex == i) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            arquivoBusca(),
            const SizedBox(
              height: 10,
            ),
            Text("Dentro do IF = ${listaMenu[i]}"),
          ],
        );
      } else {
        return Text("Else  do if ${listaMenu}");
      }
    }
    return Text("Fora do loop");
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
                        nomeTabelasArquivo();
                      },
                      style: estiloBotao,
                      child: const Text("Procurar"),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            SidebarX(
              controller: _controller,
              theme: StyleSideBar,
              extendedTheme: StyleExpandeSideBar,
              footerDivider: divider,
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
                const SidebarXItem(
                  iconWidget: Icon(Icons.home, color: Colors.white),
                  label: "Página Principal",
                  //  onTap: () => Navigator.pop(context),
                ),
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
                    return teste();
                    // switch (listaMenu.toString()) {
                    //   case 't':
                    //     return Column(
                    //       children: [
                    //         const SizedBox(
                    //           height: 10,
                    //         ),
                    //         arquivoBusca(),
                    //         const SizedBox(
                    //           height: 10,
                    //         ),
                    //         const Text("Teste"),
                    //       ],
                    //     );
                    //   case "teste2":
                    //     return teste();

                    //   case "teste3":
                    //     return const Text("Case 2");

                    //   default:
                    //     return Text("$listaMenu");
                    //   //}
                  }
                  // return const Text("Else fora do loop");

                  ),
            ),
          ],
        ),
      ),
    );
  }
}
