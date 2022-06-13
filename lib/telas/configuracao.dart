import 'package:editorconfiguracao/busca_arquivo/explorador_arq.dart';
import 'package:editorconfiguracao/tela_principal/Home_Page.dart';
import 'package:editorconfiguracao/tela_principal/app_bar.dart';
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
              theme: SidebarXTheme(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: canvaCores,
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(color: Colors.white),
                selectedTextStyle: const TextStyle(color: Colors.white),
                itemTextPadding: const EdgeInsets.only(left: 30),
                selectedItemTextPadding: const EdgeInsets.only(left: 30),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  size: 20,
                ),
              ),

              // expande a barra

              extendedTheme: const SidebarXTheme(
                width: 200,
                decoration: BoxDecoration(
                  color: canvaCores,
                ),
                margin: EdgeInsets.only(right: 10),
              ),

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
                ),
                SidebarXItem(
                  iconWidget: Image.asset("assets/images/icon_nuvem.png",
                      color: Colors.white),
                  label: "Pagina Inicial",
                ),
                SidebarXItem(
                  iconWidget: Image.asset("assets/images/icon_configuracao.png",
                      color: Colors.white),
                  label: "Tabelas",
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
            return Stack(alignment: Alignment.topLeft, children: [
              paginaInicial(),
            ]);

          case 1:
            return Text(
              'Em Construção / tabelas',
              style: theme.textTheme.headline5,
            );
          case 2:
            return Text(
              'Em Construção / banco',
              style: theme.textTheme.headline5,
            );
          case 3:
            return Text(
              'Em Construção / configuração',
              style: theme.textTheme.headline5,
            );

          case 4:
            return Text(
              'Custom iconWidget',
              style: theme.textTheme.headline5,
            );
          default:
            return Text(
              'ERROR 404',
              style: theme.textTheme.headline5,
            );
        }
      },
    );
  }
}

const primaryColor = Color(0xFF685BFF);
const canvaCores = Color(0XFF673AB7);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
const formatarTexto = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 255, 255, 255));
final divider = Divider(color: Colors.white.withOpacity(0.3), height: 1);
