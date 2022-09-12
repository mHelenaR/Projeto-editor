// bibliotecas
// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:editorconfiguracao/projeto_completo/abre%20arquivo/abreExplorador.dart';
import 'package:editorconfiguracao/projeto_completo/componentes_telas/app_bar.dart';
import 'package:editorconfiguracao/projeto_completo/menuPrincipal/menu_program.dart';

// importar arquivo
import 'package:editorconfiguracao/projeto_completo/abre%20arquivo/explorador_arq.dart';

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

  String pageTitle = "Pagina Inicial";

  void setPageTitle() {
    switch (selectMenu) {
      case 0:
        pageTitle = "Pagina Inicial";
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MenuPrincipal()));
        break;
      case 2:
        pageTitle = "Comparar";
        break;
      case 3:
        pageTitle = "Configuração";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFF673AB7),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: menuItens.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          sidebarOpen = true;
                          selectMenu = index;
                          setSidebarState();
                          setPageTitle();
                        },
                        child: ListMenu(
                          itemIcon: menuIcons[index],
                          itemText: menuItens[index],
                          selecao: selectMenu,
                          posicao: index,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      if (sidebarOpen == false) {
                        sidebarOpen = true;
                        setSidebarState();
                      } else if (sidebarOpen == true) {
                        sidebarOpen = false;
                        setSidebarState();
                      }
                    },
                    child: ListMenu(
                      itemIcon: "icon_setaPreta",
                      itemText: "Fechar Menu",
                      selecao: selectMenu,
                      posicao: menuItens.length + 1,
                    ),
                  ),
                )
              ],
            ),
          ),
          Stack(
            children: [
              AnimatedContainer(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(17.0),
                  ),
                ),
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.translationValues(xOffset, yOffset, 1.0),
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: const [
                    AppBarra(),
                    PesquisaArquivo(),
                    ExploradorArquivos(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// passa itens de uma classe para outra

class ListMenu extends StatelessWidget {
  final String itemIcon;
  final String itemText;
  final int selecao;
  final int posicao;
  const ListMenu(
      {required this.itemIcon,
      required this.itemText,
      required this.selecao,
      required this.posicao});

  final _estiloTexto = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selecao == posicao
          ? const Color(0xFF532F99)
          : const Color(0XFF673AB7),
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
            padding: const EdgeInsets.all(10),
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
