import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class navegacao extends StatelessWidget {
  const navegacao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.blue[50],
          child: barraContainer(),
        ),
      ),
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
    "icon_home",
    "icon_table",
    "icon_database",
    "icon_settings"
  ];
  bool sidebarOpen = false;
  double xOffset = 60;
  double yOffset = 0;

  void setSidebarState() {
    setState(() {
      xOffset = sidebarOpen ? 265 : 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        child: new ListView.builder(
                            itemCount: menuItens.length,
                            itemBuilder: (context, index) => Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(20),
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
              width: double.infinity,
              height: double.infinity,
              child: Text('teste'),
            ))
      ]),
    );
  }
}



// expande por fora
/*
  @override
  Widget build(BuildContext context) {
    final isCollapsed = true;

    return Container(
        width: isCollapsed ? MediaQuery.of(context).size.width * 0.1 : null,
        child: Drawer(child: Container(color: Colors.amberAccent[50])));
  }

 */