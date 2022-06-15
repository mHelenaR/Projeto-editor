import 'package:editorconfiguracao/Cores_Projeto/StyleSideBar.dart';
import 'package:editorconfiguracao/Cores_Projeto/cores.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class TablePages extends StatefulWidget {
  TablePages({Key? key}) : super(key: key);

  @override
  State<TablePages> createState() => _TablePagesState();
}

class _TablePagesState extends State<TablePages> {
  final _controller = SidebarXController(selectedIndex: 0);

  final List<String> menuTabelas = ["Unidade", "Estação", "Teclas"];
  final List<String> menuIconTabela = ["icon_prancheta"];

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
                  iconWidget: Image.asset("assets/images/icon_setaEsquerda.png",
                      color: Colors.white),
                  label: "Voltar",
                ),
                for (final teste in menuTabelas) ...{
                  SidebarXItem(
                    iconWidget: Image.asset("assets/images/icon_prancheta.png",
                        color: Colors.white),
                    label: teste,
                    onTap: () {
                      Container(
                        child: Text("Teste"),
                      );
                    },
                  ),
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}
