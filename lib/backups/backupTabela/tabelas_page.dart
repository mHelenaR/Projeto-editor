// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, unused_field, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, await_only_futures, no_leading_underscores_for_local_identifiers, avoid_print, deprecated_member_use, unused_import, unused_local_variable, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:editorconfiguracao/backups/abre%20arquivo/abreExplorador.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_container.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/backups/backupTabela/table_page.dart';

class TableMenu extends StatefulWidget {
  TableMenu({Key? key}) : super(key: key);

  @override
  State<TableMenu> createState() => _TableMenuState();
}

class _TableMenuState extends State<TableMenu> {
  // Declaração de listas e variáveis da classe
  var estacao, strarray, tes, caminhoArq;
  String _recebeCaminhoArquivo = "";
  String conteudoArquivo = "";
  String dadosArquivo = "";
  String _separaArquivo = "";
  List<String> nomeTabelas = [];
  List<String> carrega = [''];
  List<String> linhaTIT = [];
  List<String> _linhasArquivo = [""];
  List<String> _arrayString = [""];
  List<String> nomeColunas = [];
  List<String> nomeColSeparada = [];
  List<String> listaCpo = [];
  List<String> criaLista = [];
  List<String> carregarLista = [];
  List<String> listaTIT = [];
  List<String> listaConct = [""];

  final _controller = SidebarXController(selectedIndex: 0);

  final List<String> menuIconTabela = ["icon_prancheta"];

//Abre o explorador e pega o caminho do arquivo
  Future<void> abreArquivo() async {
    try {
      String? caminhoArquivo = r'/storage/';
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['cfg', 'txt'],
        dialogTitle: 'Abrir',
      );
      if (result != null) {
        caminhoArquivo = result.files.single.path;

        // caso aconteça mudanças no estado da variavel
        setState(
          () {
            _recebeCaminhoArquivo = caminhoArquivo!;
          },
        );

        //recebe o arquivo e decodifica para preservar os caracteres especiais
        final dadosArquivo = await File(_recebeCaminhoArquivo)
            .readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));
        setState(
          () {
            conteudoArquivo = dadosArquivo;
          },
        );

        setState(
          () {
            colunaTabelas();
          },
        );

        setState(
          () {
            separador();
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Operação cancelada! O arquivo não foi selecionado!"),
          ),
        );
        setState(
          () {
            _recebeCaminhoArquivo = '';
          },
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exeption: $e'),
        ),
      );
      setState(
        () {
          _recebeCaminhoArquivo = '';
        },
      );
    }
  }

// separa as colunas TIT  e CPO
  colunaTabelas() async {
    // espera o carregamento da variavel
    _separaArquivo = await conteudoArquivo;

    // cria lista com cpo
    listaConct = _separaArquivo.split('TIT ');
    List<String> linhaTIT = _separaArquivo.split("\r\n");

    //print(tit[50]); -- cria lista com a cpo junto

    nomeColunas = listaConct[1].split('\r\n');
    int posCharacter = nomeColunas[0].indexOf('#') + 1;
    nomeColSeparada = [nomeColunas[0].substring(posCharacter)];
    nomeColunas = nomeColSeparada[0].split('|');
    setState(() {
      _arrayString = nomeColunas;
    });
    carregarLista = listaConct[1].split('\r\n');
    for (int i = 0; i < carregarLista.length; i++) {
      criaLista = carregarLista[3].split('CPO ');
      listaCpo = criaLista[i].split('^');
      setState(() {
        _linhasArquivo = listaCpo;
      });
    }

    /* for (int i = 0; i < linhaTIT.length; i++) {
      // pega a string a partir do caracter
      int posCharacter = linhaTIT[i].indexOf('#') + 1;
      int posChar = linhaTIT[3].indexOf('CPO ') + 1;

      if (linhaTIT[1].substring(0, 3) == 'TIT') {
        // remove o # do nome das colunas
        nomeColSeparada = [linhaTIT[1].substring(posCharacter)];
        for (int j = 0; j < nomeColSeparada.length; j++) {
          nomeColunas = nomeColSeparada[j].split('|');
          setState(() {
            _arrayString = nomeColunas;
          });
        }
        print(_arrayString);
      } else if (linhaTIT[3].substring(0, 3) == 'CPO') {
        nomeColunas = linhaTIT[3].split('^');

        for (int j = 0; j < nomeColunas.length; j++) {
          setState(() {
            _linhasArquivo = nomeColunas;
          });
        }

        print(_linhasArquivo);
      }
    }*/

    //cria lista completa
    /* rec = tit.toString().split("\r\n"); 
      print(rec[i]);
      */
  }

  /* Future<void> carregaArquivo() async {
    _separaArquivo = await conteudoArquivo;
    final _teste = _separaArquivo.split('\r\n');

    for (int i = 0; i < _teste.length; i++) {
      var cont = i + 1;
      //var nome = _teste[cont].substring(0, 3);
      if (_teste[i++].substring(0, 3) == 'TIT') {
        List<String> strarray = _teste[i].split('|');
        setState(
          () {
            _arrayString = strarray;
          },
        );
      } else if (_teste[i++].substring(0, 3) == 'CPO') {
        List<String> estacao = _teste[cont].split('^');

        setState(
          () {
            _linhasArquivo = estacao;
          },
        );
      }
    }
    setState(() {
      separador();
    });
  }
*/

// Separa o nome das tabelas e cria uma lista para o menu
  separador() async {
    listaTIT = await conteudoArquivo.split('TIT ');
    int posicaoSeparador = 0;

    for (int i = 0; i < listaTIT.length; i++) {
      posicaoSeparador = listaTIT[i].indexOf("#");
      if (posicaoSeparador != -1) {
        nomeTabelas = [listaTIT[i].substring(0, posicaoSeparador)];
      } else {
        nomeTabelas = [];
      }
      setState(
        () {
          carrega = carrega + nomeTabelas;
        },
      );
    }
  }

  // strpliString(List<String> lista, int start, int end) {
  //   List<String> ret = [];
  //   for(int i = start; i<end;i++){
  //     ret.add(lista.getRange(start, end))
  //   }
  // }

//Criação das tabelas
  Widget tabelas() {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double screen = 0;
    if ((heightScreen < 960) && (heightScreen > 760)) {
      screen = MediaQuery.of(context).size.height * 0.75;
    } else if ((heightScreen > 961)) {
      screen = MediaQuery.of(context).size.height * 0.8;
    } else if (heightScreen < 760) {
      screen = MediaQuery.of(context).size.height * 0.7;
    }
    return Container(
      height: screen,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: decoracaoContainer,
      child: DataTable2(
        minWidth: 70000,
        horizontalMargin: 10,
        columnSpacing: 2,
        columns: [
          for (int i = 0; i < carrega.length; i++) ...{
            if (_controller.selectedIndex == i) ...{
              if (_arrayString != null) ...{
                for (final nomeColuna in _arrayString) ...{
                  DataColumn2(
                    label: Text(nomeColuna),
                  ),
                },
              } else ...{
                const DataColumn2(
                  size: ColumnSize.S,
                  label: Text(""),
                ),
              }
            },
          }
        ],
        rows: [
          for (int i = 0; i < carrega.length; i++) ...{
            if (_controller.selectedIndex == i) ...{
              if (_linhasArquivo != null) ...{
                //for (int i = 0; i < nomeColunas.length; i++) ...{
                DataRow2(
                  cells: [
                    for (final nomelinha in _linhasArquivo) ...{
                      DataCell(
                        Text(nomelinha),
                        // onLongPress: () {},
                        // TextFormField(
                        //   decoration:
                        //       const InputDecoration(border: InputBorder.none),
                        //   initialValue: nomelinha,
                        // ),
                        // showEditIcon: true,
                      ),
                    },
                  ],
                ),
                //},
              } else ...{
                const DataRow2(
                  cells: [
                    DataCell(Text("")),
                  ],
                ),
              }
            }
          }
        ],
      ),
    );
  }

//Criação dos botoes para abrir e carregar o arquivo
  Widget button() {
    return Wrap(
      spacing: 10,
      children: [
        ElevatedButton(
          onPressed: abreArquivo,
          style: estiloBotao,
          child: const Text("Procurar"),
        ),
      ],
    );
  }

//barra que recebe o caminho do arquivo
  Widget pesquisa() {
    var v;
    if (_recebeCaminhoArquivo == '') {
      v = 'Arquivo';
    } else {
      v = _recebeCaminhoArquivo;
    }

    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.archive),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        labelText: v,
      ),
    );
  }

//carrega os componentes da tela de tabelas
  Widget colunaComponentes() {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double screen = 0;
    if ((heightScreen < 960) && (heightScreen > 760)) {
      screen = MediaQuery.of(context).size.height * 0.75;
    } else if ((heightScreen > 961)) {
      screen = MediaQuery.of(context).size.height * 0.8;
    } else if (heightScreen < 760) {
      screen = MediaQuery.of(context).size.height * 0.7;
    }
    return Column(
      children: [
        Container(
          height: screen,
          width: MediaQuery.of(context).size.width,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                children: [
                 
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 10, right: 20, top: 10),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          verticalDirection: VerticalDirection.down,
                          children: [
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              verticalDirection: VerticalDirection.down,
                              children: [
                                SizedBox(
                                  width: 400,
                                  height: 30,
                                  child: pesquisa(),
                                ),
                                SizedBox(
                                  width: 300,
                                  height: 30,
                                  child: button(),
                                ),
                                SizedBox(
                                  height: screen,
                                  child: tabelas(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

// corpo da tela de tabelas
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            SidebarX(
              controller: _controller,
              theme: StyleSideBar,
              extendedTheme: StyleExpandeSideBar,
              footerDivider: dividerWhite,
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
                SidebarXItem(
                  iconWidget: Image.asset(
                    "assets/images/icon_setaEsquerda.png",
                    color: Colors.white,
                  ),
                  label: "Voltar",
                  onTap: () => Navigator.pop(context),
                ),
                for (final teste in carrega) ...{
                  SidebarXItem(
                    iconWidget: Image.asset("assets/images/icon_prancheta.png",
                        color: Colors.white),
                    label: teste,
                  ),
                },
              ],
            ),
            Expanded(
              child: colunaComponentes(),
            ),
          ],
        ),
      ),
    );
  }
}

// class _CorpoTabelas extends StatelessWidget {
//   const _CorpoTabelas({Key? key, required this.controleTela}) : super(key: key);
//   final SidebarXController controleTela;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: controleTela,
//       builder: (context, child) {
//         return  return  AnimatedBuilder (
//       animação : controleTela,
//       construtor : (contexto, filho) {
//         if (controleTela.selectedIndex !=  0 ) {
//           return  const  TelaTabelas ();
//         }
//         return  const  Texto (
//             "O desenvolvedor foi preguiçoso e não exibiu nada por aqui, favor reclamado!!!" );
//         return  const  TelaTabelas ();
//       },
//     );
//
//       },
//     );
//   }
// }
