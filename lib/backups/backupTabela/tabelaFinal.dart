// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:pluto_grid/pluto_grid.dart';

void main() {
  runApp(Myarpp());
}

class Myarpp extends StatelessWidget {
  const Myarpp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ViewEditScree(),
    );
  }
}

class ViewEditScree extends StatefulWidget {
  const ViewEditScree({super.key});

  @override
  State<ViewEditScree> createState() => _ViewEditScreeState();
}

class _ViewEditScreeState extends State<ViewEditScree>
    with TickerProviderStateMixin {
  List<String> listaTIT = [];
  List<String> nomeTabelas = [];
  List<String> listaMenu = [''];
  var _recebeCaminhoArquivo = '';
  String _separarArquivo = '';
  List<String> separaTabelasArquivo = [];
  List<String> nomeColSeparada = [];
  List<String> nomeColunas = [];
  List<String> arrayString = [''];
  List<String> linhaCPO = [];
  List<String> teste1 = [];
  List<String> teste2 = [];
  List<String> teste3 = [];
  List<String> teste4 = [];
  List<String> teste5 = [];
  List<String> gravaArquivo = ['inicio'];
  List<PlutoRow> rows = [];
  List<PlutoRow> rows2 = [];
  List<PlutoColumn> columns = [];
  String conteudoArquivo = "", principal = '';
  late PlutoGridStateManager stateManager;

  List<Tab> _tabs = [];
  final List<Widget> _generalWidgets = [];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = getTabController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teste"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: SizedBox(
              height: 80,
              child: arquivoBusca(),
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 50,
              child: AppBar(
                title: TabBar(
                  splashBorderRadius: BorderRadius.circular(40),
                  isScrollable: true,
                  tabs: _tabs,
                  controller: _tabController,
                  indicatorColor: Colors.white,
                ),
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              // height: tamanho(context),
              child: TabBarView(
                controller: _tabController,
                children: getWidgets(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> arquivoAbrirSeparar() async {
    FilePickerResult? caminhoArquivo = await FilePicker.platform.pickFiles(
      initialDirectory: 'C:/frente',
      dialogTitle: 'Escolha o arquivo de configuração',
      withData: true,
    );
    if (caminhoArquivo != null) {
      _recebeCaminhoArquivo = caminhoArquivo.files.single.path!;
    }

    final conteudoArquivo = await File(_recebeCaminhoArquivo)
        .readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));

    setState(() {
      principal = conteudoArquivo;
    });
    teste1 = await nomeTabelasArquivo(conteudoArquivo);

    nomeTab(teste1.length);

    _tabs = criaTab(teste1.length);
    setState(() {
      getWidgets();
      _tabController = TabController(length: _tabs.length, vsync: this);
    });
  }

  Future<List<String>> nomeTabelasArquivo(String teste) async {
    listaTIT = await teste.split('TIT ');
    listaMenu.clear();
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

    return listaMenu;
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  List<Tab> criaTab(int count) {
    _tabs.clear();

    for (int i = 0; i < count; i++) {
      _tabs.add(nomeTab(i));
    }
    return _tabs;
  }

// paginas
  Tab nomeTab(int widgetNumber) {
    setState(() {
      widgetNumber;
    });
    if (widgetNumber == teste1.length) {
      widgetNumber = widgetNumber - 1;
    }
    return Tab(text: teste1[widgetNumber]);
  }

  void updatePage() {
    setState(() {});
  }

  List<Widget> getWidgets() {
    _generalWidgets.clear();
    for (int i = 0; i < _tabs.length; i++) {
      _generalWidgets.add(carregarTela(i));
    }

    return _generalWidgets;
  }

  carregarTela(var controle) {
    return FutureBuilder(
      future: getValue(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return getWidget(controle);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<String> getValue() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Aguarde!\n Carregando tabelas!';
  }

  Widget getWidget(int widgetNumber) {
    rows.clear();
    columns.clear();
    listaTIT.clear();
    nomeColunas.clear();
    teste4.clear();

    String? recebeTabela;
    _separarArquivo = principal;

    if (kDebugMode) {
      print("Numero da tab: $widgetNumber");
    }

    for (int i = 0; i < listaMenu.length; i++) {
      int contador = widgetNumber + 1;
      String start = 'TIT ${listaMenu[widgetNumber]}#';

      if (contador == listaMenu.length) {
        contador = contador - 1;

        final startIndex = _separarArquivo.indexOf(start);

        recebeTabela = _separarArquivo.substring(
            startIndex + start.length, _separarArquivo.length);
      } else {
        String end = 'TIT ${listaMenu[contador]}#';

        final startIndex = _separarArquivo.indexOf(start);

        final endIndex =
            _separarArquivo.indexOf(end, startIndex + start.length);

        recebeTabela =
            _separarArquivo.substring(startIndex + start.length, endIndex);
      }
    }

    List<String> linhasTIT = recebeTabela!.split("\r\n");
    nomeColunas = linhasTIT[0].split('|');

    columns = <PlutoColumn>[
      for (int colTam = 0; colTam < nomeColunas.length; colTam++) ...{
        //coluna
        PlutoColumn(
          title: nomeColunas[colTam],
          field: colTam.toString(),
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
                for (int rColTam = 0; rColTam < teste5.length; rColTam++) ...{
                  rColTam.toString(): PlutoCell(value: teste5[rColTam]),
                },
              },
            ),
          ]);
        }
      }
    }

    return PlutoGrid(
      columns: columns,
      rows: rows,
    );
  }

  Widget arquivoBusca() {
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
                    child: ElevatedButton(
                      onPressed: () {
                        arquivoAbrirSeparar();
                      },
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
}
