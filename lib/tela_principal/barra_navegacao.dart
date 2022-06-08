import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class navegacao extends StatelessWidget {
  const navegacao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(child: barraContainer()),
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

  void setSidebarState() {
    setState(() {
      xOffset = sidebarOpen ? 220 : 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[50],
      child: Stack(children: [
        Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: Text('titulo'),
                ),
                Container(
                    child: Expanded(
                        child: ListView.builder(
                            itemCount: menuItens.length,
                            itemBuilder: (context, index) => Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Image.asset(
                                            "assets/images/${menuIcons[index]}.png"),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(menuItens[index]),
                                      )
                                    ],
                                  ),
                                )))),
                Container(
                  child: Text('saida'),
                ),
              ],
            )),
        GestureDetector(
            onTap: () {
              sidebarOpen = !sidebarOpen;
              setSidebarState();
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              transform: Matrix4.translationValues(xOffset, yOffset, 1.0),
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              color: Colors.white,
              child: Text('teste'),
            ))
      ]),
    );
  }
}
