import 'package:editorconfiguracao/projeto_completo/dataBase/pg_connection.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/tabelas/corpo_tabela/body_table.dart';
import 'package:editorconfiguracao/projeto_completo/telas/Home_Page.dart';

import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({Key? key}) : super(key: key);

  @override
  MenuPrincipalState createState() => MenuPrincipalState();
}

class MenuPrincipalState extends State<MenuPrincipal> {
  final _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SidebarX(
          controller: _controller,
          theme: StyleSideBar,

          // expande a barra
          extendedTheme: StyleExpandeSideBar,

          // linha de divisa
          footerDivider: dividerWhite,

          //texto lista do cabeçalho
          headerBuilder: (context, extended) {
            return SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/icon_engrenagem _roxo.png',
                ),
              ),
            );
          },

          // opções menu
          items: [
            SidebarXItem(
              iconWidget: Image.asset("assets/images/homepage_1.png",
                  color: Colors.white),
              label: "Pagina Inicial",
            ),
            SidebarXItem(
              iconWidget: Image.asset("assets/images/icon_prancheta.png",
                  color: Colors.white),
              label: "Tabelas",
            ),
            SidebarXItem(
              iconWidget: Image.asset("assets/images/icon_nuvem.png",
                  color: Colors.white),
              label: "Comparar Tabelas",
            ),
            SidebarXItem(
              iconWidget: Image.asset("assets/images/icon_configuracao.png",
                  color: Colors.white),
              label: "Configuração",
            ),
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              switch (_controller.selectedIndex) {
                case 0:
                  return const TelaPrincipal();
                case 1:
                  return const TelaTabela();
                case 3:
                  return const TelaConexao();

                default:
                  return const Text(
                    'Fora do Menu',
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: const PaginaInicial(),
    );
  }
}
