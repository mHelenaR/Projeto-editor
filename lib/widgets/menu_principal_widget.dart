import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:editorconfiguracao/projeto_completo/styles/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_sidebar_menu.dart';
import 'package:editorconfiguracao/views/data_base_view.dart';
import 'package:editorconfiguracao/views/edicao_view.dart';
import 'package:editorconfiguracao/views/pagina_inicial_view.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({Key? key}) : super(key: key);

  @override
  MenuPrincipalState createState() => MenuPrincipalState();
}

class MenuPrincipalState extends State<MenuPrincipal> {
  final _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Row(
        children: [
          SidebarX(
            controller: _controller,
            theme: temaMenu,

            // Tema do menu expandido
            extendedTheme: backgroundMenu,

            // Linha de divisa do menu
            footerDivider: dividerWhite,

            // Cabeçalho do Menu
            headerBuilder: (context, extended) {
              return SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/icon_engrenagem_roxo.png',
                  ),
                ),
              );
            },

            // Opções do menu
            items: [
              SidebarXItem(
                label: "Página Inicial",
                iconWidget: Image.asset(
                  "assets/images/homepage_1.png",
                  color: white,
                ),
              ),
              SidebarXItem(
                label: "Edição",
                iconWidget: Image.asset(
                  "assets/images/icon_prancheta.png",
                  color: white,
                ),
              ),
              SidebarXItem(
                label: "Comparação",
                iconWidget: Image.asset(
                  "assets/images/icon_nuvem.png",
                  color: white,
                ),
              ),
              SidebarXItem(
                label: "Configuração",
                iconWidget: Image.asset(
                  "assets/images/icon_configuracao.png",
                  color: white,
                ),
              ),
            ],
          ),

          /* Opções de exibição na tela;
           * Muda o container principal de acondo com o índice
           * de seleção do controlador;
           */
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  switch (_controller.selectedIndex) {
                    case 0:
                      return const TelaInicial();

                    case 1:
                      return const TelaEdicao();
                    case 2:
                      return const Text('Fazer a tela de comparação');

                    case 3:
                      return const TelaConexao();

                    default:
                      return const Text('Fora do Menu');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
