import 'package:editorconfiguracao/Cores_Projeto/StyleSideBar.dart';
import 'package:editorconfiguracao/Cores_Projeto/cores.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:get/get.dart';
import 'package:editorconfiguracao/busca_arquivo/explorador_arq.dart';

class TablePages extends StatefulWidget {
  TablePages({Key? key}) : super(key: key);

  @override
  State<TablePages> createState() => _TablePagesState();
}

class _TablePagesState extends State<TablePages> {
  final _controller = SidebarXController(selectedIndex: 0);

  final List<String> menuTabelas = ["LISTA", "UNIDADE", "ESTAÇÃO"];
  final List<String> menuIconTabela = ["icon_prancheta"];
  var _teste;
  get MenuIte => menuTabelas;
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                for (final teste in menuTabelas) ...{
                  SidebarXItem(
                    iconWidget: Image.asset("assets/images/icon_prancheta.png",
                        color: Colors.white),
                    label: teste,
                  ),
                },
              ],
            ),
            Expanded(
              child: Center(
                child: _CorpoTabelas(
                  controleTela: _controller,
                ),
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
    var v = 2;
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controleTela,
      builder: (context, child) {
        for (int i = 0; i < v; i++) {
          if (controleTela.selectedIndex != 0) {
            return ExploradorArquivos();
          }
        }
        return Container();
        /*switch (controleTela.selectedIndex) {
          case 1:
            return Text(
              'Teste',
              style: theme.textTheme.headline5,
            );
          default:
            return Container();
        }*/
      },
    );
  }
}
