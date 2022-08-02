// ignore_for_file: unused_import, prefer_const_constructors_in_immutables, unused_element, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, unused_field, unused_local_variable, await_only_futures, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:ffi';
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

enum Status {
  loading(message: 'Carregando!'),
  success(message: 'Sucesso'),
  error(message: 'Erro: ');

  const Status({required this.message});
  final String message;
}

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
  List<String> listaTIT = [];
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

  nomeTabelasArquivo() {
    try {
      //  limpaListas();

      conteudoArquivo =
          'TIT teste#tabela1-1|tabela1-2|tabela1-3|tabela1-4|\r\nCPO 001^002^003^004^\r\nCPO 005^006^007^008^\r\nCPO 009^010^011^012^\r\nTIT teste1#tabela2-1|tabela2-2|tabela2-3|tabela2-4|\r\nCPO 100^200^300^400^\r\nCPO 500^600^700^800^\r\nCPO 900^100^110^120^\r\nTIT teste2#tabela3-1|tabela3-2|tabela3-3|tabela3-4|\r\nCPO 101^102^103^104^\r\nCPO 105^106^107^108^\r\nCPO 109^110^111^112^\r\n';
      listaTIT = conteudoArquivo.split('TIT ');

      int posicaoSeparador = 0;

      for (int i = 0; i < listaTIT.length; i++) {
        posicaoSeparador = listaTIT[i].indexOf('#');
        if (posicaoSeparador != -1) {
          nomeTabelas = [listaTIT[i].substring(0, posicaoSeparador)];
        }
        setState(() {
          listaMenu = listaMenu + nomeTabelas;
        });
      }

      for (int i = 0; i < listaTIT.length; i++) {
        if (listaTIT[i] != '') {
          String linha = listaTIT[i];
          String? testeO = linha.split('\r\n').toString();
          teste1 = teste1 + [testeO];
          // print(teste1);

        } else {
          print("Primeiro IF");
        }
      }

      for (int j = 0; j < teste1.length; j++) {
        if (teste1[j] != "") {
          String nova = teste1[j];
          String? nova1 = nova.split("CPO ").toString();

          teste3 = teste3 + [nova1];
        } else {
          print("Segundo IF");
        }
      }
      print(teste3[4]);
    } catch (e) {
      print('${Status.error.message} $e');
    }
  }

  teste() {
    try {
      for (int i = 0; i < listaMenu.length; i++) {
        if ((_controller.selectedIndex == 0)) {
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
        }
      }
      return const Text("Fora do loop");
    } catch (e) {
      print('${Status.error}: $e');
    }
  }

  Future<String> getValue() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return 'Aguarde!\n Carregando tabelas!';
    } catch (e) {
      print('${Status.error}: $e');
      return "Erro";
    }
  }

  carregarTela() {
    try {
      return Container(
        child: FutureBuilder(
          future: getValue(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return nomeTabelasArquivo();
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
      print('${Status.error}: $e');
    }
  }

  int cor = 0;

  mudarCor(int numero) {
    try {
      if (_controller.selectedIndex == numero) {
        cor = _controller.selectedIndex;
        return cor;
      }
    } catch (e) {
      print('${Status.error}: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
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
                    if (_controller.selectedIndex == 0) {
                      return teste();
                    } else {
                      // mudarCor(menu(_controller.selectedIndex));
                      return Container(
                        child: Text(listaTIT[_controller.selectedIndex]),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      print('${Status.error}: $e');
      return Text('${Status.error}: $e');
    }
  }

  menu(int numero) {
    try {
      for (int i = 0; i < listaTIT.length; i++) {
        if (listaTIT[_controller.selectedIndex] == listaTIT[i]) {
          numero = i;
          print(numero);
          return numero;
        }
      }
      return 0;
    } catch (e) {
      print(e);
    }
  }

  Widget arquivoBusca() {
    try {
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
    } catch (e) {
      print('${Status.error.message} $e');
      return Text('${Status.error.message} $e');
    }
  }
}
// utilizar o  indexOf  para comparar o nome de item da lista
//https://pt.stackoverflow.com/questions/303497/como-encontrar-e-mostrar-a-posi%C3%A7%C3%A3o-de-um-item-na-lista-n%C3%A3o-definindo-o-valor-da
