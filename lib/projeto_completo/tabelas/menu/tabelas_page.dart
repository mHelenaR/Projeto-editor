// ignore_for_file: use_key_in_widget_constructors

import 'package:editorconfiguracao/projeto_completo/abre%20arquivo/abreExplorador.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/tabelas/corpo_tabela/tabela_completa.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class TableMenu extends StatefulWidget {
  TableMenu({Key? key}) : super(key: key);

  @override
  State<TableMenu> createState() => _TableMenuState();
}

class _TableMenuState extends State<TableMenu> {
  var test = ArquivoState();
  final _controller = SidebarXController(selectedIndex: 0);

  final List<String> menuTabelas = [];
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
                  iconWidget: Image.asset(
                    "assets/images/icon_setaEsquerda.png",
                    color: Colors.white,
                  ),
                  label: "Voltar",
                  onTap: () => Navigator.pop(context),
                ),
                for (final nomeTabela in menuIconTabela) ...{
                  SidebarXItem(
                    iconWidget: Image.asset("assets/images/icon_prancheta.png",
                        color: Colors.white),
                    label: nomeTabela,
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
                    child: _CorpoTabelas(
                      controleTela: _controller,
                    ),
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

class _CorpoTabelas extends StatelessWidget {
  const _CorpoTabelas({Key? key, required this.controleTela}) : super(key: key);

  final SidebarXController controleTela;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controleTela,
      builder: (context, child) {
        return const TelaTabelas();
      },
    );
  }
}
