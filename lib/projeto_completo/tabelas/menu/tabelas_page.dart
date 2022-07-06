// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, unused_field, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, await_only_futures, no_leading_underscores_for_local_identifiers, avoid_print, deprecated_member_use, unused_import

import 'dart:convert';
import 'dart:io';

import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:editorconfiguracao/projeto_completo/abre%20arquivo/abreExplorador.dart';
import 'package:editorconfiguracao/projeto_completo/componentes_telas/app_bar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_container.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/tabelas/corpo_tabela/tabela_completa.dart';

class TableMenu extends StatefulWidget {
  TableMenu({Key? key}) : super(key: key);

  @override
  State<TableMenu> createState() => _TableMenuState();
}

class _TableMenuState extends State<TableMenu> {
  String _recebeCaminhoArquivo = "";
  String conteudoArquivo = "";
  String dadosArquivo = "";
  String _separaArquivo = "";
  List<String> nomeTabelas = [];
  List<String> carrega = [];
  List<String> _linhasArquivo = [""];
  List<String> _arrayString = [""];
  var estacao, strarray, tes;

  final _controller = SidebarXController(selectedIndex: 0);

  final List<String> menuIconTabela = ["icon_prancheta"];

//Abre o explorador e pega o caminho do arquivo
  Future<void> abreArquivo() async {
    String? caminhoArquivo = r'/storage/';
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      caminhoArquivo = result.files.single.path;
    }
    // caso aconteça mudanças no estado da variavel
    setState(
      () {
        _recebeCaminhoArquivo = caminhoArquivo!;
      },
    );

    //recebe o arquivo e decodifica para preservar os caracteres especiais
    final dadosArquivo = await File(_recebeCaminhoArquivo).readAsStringSync(
      encoding: const Latin1Codec(allowInvalid: true),
    );
    setState(
      () {
        conteudoArquivo = dadosArquivo;
      },
    );

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
    setState(
      () {
        separador();
      },
    );
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
  separador() async {
    List<String> listaTIT = await conteudoArquivo.split('TIT ');
    int posicaoSeparador = 0;

    for (int i = 0; i < listaTIT.length; i++) {
      posicaoSeparador = listaTIT[i].indexOf("#");
      if (posicaoSeparador != -1) {
        nomeTabelas = [listaTIT[i].substring(0, posicaoSeparador)];
      } else {
        nomeTabelas = [];
      }

      setState(() {
        carrega = carrega + nomeTabelas;
      });
    }
  }

//Criação das tabelas
  Widget tabelas() {
    return Container(
      decoration: decoracaoContainer,
      child: DataTable2(
        minWidth: 3000,
        horizontalMargin: 10,
        showCheckboxColumn: true,
        columnSpacing: 2,
        checkboxHorizontalMargin: 2.5,
        columns: [
          if (_arrayString != null) ...{
            for (final nomeColuna in _arrayString) ...{
              DataColumn2(
                label: Text(nomeColuna),
              ),
            },
          } else ...{
            const DataColumn2(
              label: Text(""),
            ),
          }
        ],
        rows: [
          if (_linhasArquivo != null) ...{
            for (int i = 0; i <= estacao.toString().length; i++) ...{
              DataRow2(
                cells: [
                  for (final nomelinha in _linhasArquivo) ...{
                    DataCell(Text(nomelinha)),
                  },
                ],
              ),
            },
          } else ...{
            const DataRow2(
              cells: [
                DataCell(Text("")),
              ],
            ),
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
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.archive),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        labelText: 'Arquivo',
      ),
    );
  }

  //carrega os componentes da tela de tabelas
  Widget colunaComponentes() {
    return Column(
      children: [
        const AppBarra(),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
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
                          width: 300,
                          height: 30,
                          child: pesquisa(),
                        ),
                        SizedBox(
                          width: 300,
                          height: 30,
                          child: button(),
                        ),
                        SizedBox(
                          height: 700,
                          child: tabelas(),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
        // ExploradorArquivos(),
      ],
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
              items: [
                SidebarXItem(
                  iconWidget: Image.asset(
                    "assets/images/icon_setaEsquerda.png",
                    color: Colors.white,
                  ),
                  label: "Voltar",
                  onTap: () => Navigator.pop(context),
                ),
                for (int i = 0; i < carrega.length; i++) ...{
                  SidebarXItem(
                    iconWidget: Image.asset("assets/images/icon_prancheta.png",
                        color: Colors.white),
                    label: carrega[i],
                  ),
                },
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: colunaComponentes(),
                  ),
                ],
              ),
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

/*@override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return ListView.builder(
              //padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => Container(
                height: 100,
                //width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).canvasColor,
                  boxShadow: const [BoxShadow()],
                ),
              ),
            );
          case 1:
            return Text(
              'Search',
              style: theme.textTheme.headline5,
            );
          case 2:
            return Text(
              'People',
              style: theme.textTheme.headline5,
            );
          case 3:
            return Text(
              'Favorites',
              style: theme.textTheme.headline5,
            );
          case 4:
            return Text(
              'Custom iconWidget',
              style: theme.textTheme.headline5,
            );
          default:
            return Text(
              'Not found page',
              style: theme.textTheme.headline5,
            );
        }
      },
    );
  }
} */