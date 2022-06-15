import 'package:editorconfiguracao/Cores_Projeto/StyleSideBar.dart';
import 'package:editorconfiguracao/Cores_Projeto/cores.dart';
import 'package:editorconfiguracao/busca_arquivo/explorador_arq.dart';
import 'package:editorconfiguracao/tabelas/tabelas_page.dart';
import 'package:editorconfiguracao/tela_principal/Home_Page.dart';
import 'package:editorconfiguracao/tela_principal/app_bar.dart';

import 'package:editorconfiguracao/tela_principal/corpo_programa.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class telaConfiguracao extends StatefulWidget {
  @override
  _telaConfiguracaoState createState() => _telaConfiguracaoState();
}

class _telaConfiguracaoState extends State<telaConfiguracao> {
  final _controller = SidebarXController(selectedIndex: 0);

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
              // expande a barra
              extendedTheme: StyleExpandeSideBar,
              // linha de divisa

              footerDivider: divider,
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
                        MaterialPageRoute(builder: (context) => TablePages()));
                  },
                ),
                SidebarXItem(
                  iconWidget: Image.asset("assets/images/icon_nuvem.png",
                      color: Colors.white),
                  label: "Pagina Inicial",
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
            return Home_Page();

          case 2:
            return Text(
              'Teste',
              style: theme.textTheme.headline5,
            );
          case 3:
            return ExploradorArquivos();

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

class Home_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter, child: const PaginaInicial());
  }
}
