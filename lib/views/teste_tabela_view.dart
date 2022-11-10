import 'package:editorconfiguracao/test/separa_arq.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class TesteTabela extends StatefulWidget {
  const TesteTabela({super.key});

  @override
  State<TesteTabela> createState() => _TesteTabelaState();
}

class _TesteTabelaState extends State<TesteTabela>
    with TickerProviderStateMixin {
  List<Widget> tabTeste = [];

  TabController getTabController() {
    return TabController(length: tabTeste.length, vsync: this);
  }

  late TabController tabController;

  @override
  void initState() {
    tabController = getTabController();
    super.initState();
  }

  List<Widget> tabelasConfig() {
    List<Widget> criarWidgets = [];
    criarWidgets.clear();

    for (int i = 0; i < tabTeste.length; i++) {
      criarWidgets.add(Column(
        children: [
          Text('$i'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: PlutoGrid(
                columns: [
                  for (int i = 0; i < 630; i++) ...{
                    PlutoColumn(
                        title: 'tabela $i',
                        field: '$i',
                        type: PlutoColumnType.text())
                  }
                ],
                rows: [
                  for (int j = 0; j < 200; j++) ...{
                    //linha
                    PlutoRow(
                      cells: {
                        for (int i = 0; i < 630; i++) ...{
                          //celula
                          '$i': PlutoCell(value: 'linhas tabela $i'),
                        }
                      },
                    )
                  }
                ],
              ),
            ),
          )
        ],
      ));
    }

    return criarWidgets;
  }

  List<String> chaves = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            setState(() {
              for (var i = 0; i < 60; i++) {
                chaves.add('Tab $i');
                tabTeste.add(Tab(
                  text: 'tab $i',
                ));
              }
              tabelasConfig();

              objeto.setTesteTab = tabelasConfig;
              tabController =
                  TabController(length: tabTeste.length, vsync: this);
            });
          },
          child: const Text('tabela'),
        ),
        ElevatedButton(
            onPressed: () {
              tabController.index = 30;
            },
            child: const Text('Pular')),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Flexible(
                child: AppBar(
                  title: TabBar(
                    isScrollable: true,
                    controller: tabController,
                    tabs: tabTeste,
                    // const [
                    //   Tab(text: '1'),
                    //   Tab(text: '2'),
                    //   Tab(text: '3'),
                    // ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: tabelasConfig(),
            //tabelasConfig,
            //     <Widget>[
            //   for (int i = 0; i < tabTeste.length; i++) ...{
            //     Text('teste $i'),
            //   },
            // ],
          ),
        ),
      ],
    );
  }
}
