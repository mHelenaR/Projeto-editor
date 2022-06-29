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
  final _controller = SidebarXController(selectedIndex: 0);

  final List<String> menuTabelas = ["LISTA", "UNIDADE", "ESTAÇÃO"];
  final List<String> menuIconTabela = ["icon_prancheta"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          mainAxisSize: MainAxisSize.min,
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                for (final nomeTabela in menuTabelas) ...{
                  SidebarXItem(
                    iconWidget: Image.asset("assets/images/icon_prancheta.png",
                        color: Colors.white),
                    label: nomeTabela,
                  ),
                },
              ],
            ),
            // Expanded(
            //   child: Column(
            //     children: [
            //       _CorpoTabelas(
            //         controleTela: _controller,
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _CorpoTabelas(
                    controleTela: _controller,
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
        if (controleTela.selectedIndex != 0) {
          return const TelaTabelas();
        }
        return const Text(
            "O desenvolvedor foi preguiçoso e não exibiu nada por aqui, favor reclamar!!!");
      },
    );
  }
}
