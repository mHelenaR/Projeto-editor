// bibliotecas
import 'dart:ffi';

import 'package:editorconfiguracao/tela_principal/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// importar arquivo
import 'package:editorconfiguracao/busca_arquivo/explorador_arq.dart';

class navegacao extends StatelessWidget {
  const navegacao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: barraContainer(),
    );
  }
}

class barraContainer extends StatefulWidget {
  const barraContainer({Key? key}) : super(key: key);

  @override
  State<barraContainer> createState() => _barraContainerState();
}

class _barraContainerState extends State<barraContainer> {
  final List<String> menuItens = [
    "Página principal",
    "Tabelas",
    "Conexão",
    "Configuração"
  ];
  final List<String> menuIcons = [
    "homepage_1",
    "icon_prancheta",
    "icon_nuvem",
    "icon_configuracao"
  ];
  bool sidebarOpen = true;

  double xOffset = 60;
  double yOffset = 0;

  int selectMenu = 0;

  void setSidebarState() {
    setState(() {
      xOffset = sidebarOpen ? 220 : 60;
    });
  }

  final _estiloTexto = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFF673AB7),
      child: Stack(children: [
        Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                  child: Text('titulo'),
                ),
                Container(
                    child: Expanded(
                        child: ListView.builder(
                            itemCount: menuItens.length,
                            itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  sidebarOpen = !sidebarOpen;
                                  selectMenu = index;
                                  setSidebarState();
                                },
                                child: ListMenu(
                                  itemIcon: menuIcons[index],
                                  itemText: menuItens[index],
                                  selecao: selectMenu,
                                  posicao: index,
                                ))))),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text('saida'),
                ),
              ],
            )),
        AnimatedContainer(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5),
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17.0),
                bottomLeft: Radius.circular(17.0),
              )),
          duration: Duration(milliseconds: 200),
          transform: Matrix4.translationValues(xOffset, yOffset, 1.0),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              appBarra(),
              SizedBox(
                height: 100,
              ),
              ExploradorArquivos(),
            ],
          ),
        )
      ]),
    );
  }
}

// passa itens de uma classe para outra

class ListMenu extends StatelessWidget {
  final String itemIcon;
  final String itemText;
  final int selecao;
  final int posicao;
  ListMenu(
      {required this.itemIcon,
      required this.itemText,
      required this.selecao,
      required this.posicao});

  final _estiloTexto = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selecao == posicao ? Color(0xFF532F99) : Color(0XFF673AB7),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              "assets/images/${itemIcon}.png",
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              itemText,
              style: _estiloTexto,
            ),
          )
        ],
      ),
    );
  }
}
