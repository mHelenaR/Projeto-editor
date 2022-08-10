// ignore_for_file: unused_import

import 'package:editorconfiguracao/projeto_completo/comparar/comprar_arquivos.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/pg_connection.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/abre%20arquivo/explorador_arq.dart';
import 'package:editorconfiguracao/projeto_completo/tabelas/corpo_tabela/table_page.dart';
import 'package:editorconfiguracao/projeto_completo/tabelas/menu/tabelas_page.dart';
import 'package:editorconfiguracao/projeto_completo/telas/home_page.dart';
import 'package:editorconfiguracao/projeto_completo/componentes_telas/app_bar.dart';

import 'package:editorconfiguracao/projeto_completo/telas/corpo_programa.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBarExpansivel extends StatefulWidget {
  const SideBarExpansivel({Key? key}) : super(key: key);

  @override
  _SideBarExpansivelState createState() => _SideBarExpansivelState();
}

class _SideBarExpansivelState extends State<SideBarExpansivel> {
  final _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: white,
        body: Row(
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Arquivo() /*TableMenu()*/,
                      ),
                    );
                  },
                ),
                SidebarXItem(
                  iconWidget: Image.asset("assets/images/icon_nuvem.png",
                      color: Colors.white),
                  label: "Comparar Tabelas",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CompararArquivos(),
                      ),
                    );
                  },
                ),
                SidebarXItem(
                  iconWidget: Image.asset("assets/images/icon_configuracao.png",
                      color: Colors.white),
                  label: "Configuração",
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: _ScreensExample(controller: _controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return const HomePage();
          case 3:
            return ConexaoPostgres();

          case 4:
            return Text(
              'Custom iconWidget',
              style: theme.textTheme.headline5,
            );
          default:
            return Text(
              '',
              style: theme.textTheme.headline5,
            );
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: const PaginaInicial(),
    );
  }
}
