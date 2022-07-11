import 'package:editorconfiguracao/projeto_completo/componentes_telas/carrega_tabela.dart';
import 'package:editorconfiguracao/projeto_completo/componentes_telas/sidebarX.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/StyleSideBar.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class CompararArquivos extends StatelessWidget {
  CompararArquivos({Key? key}) : super(key: key);

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
                SidebarXItem(
                  iconWidget: Image.asset("assets/images/icon_prancheta.png", color: Colors.white),
                  label: "Comparar",
                ),
              ],
            ),
            const Expanded(
                child: Center(
              child: TabelasComparar(),
            )),
          ],
        ),
      ),
    );
  }
}

class NomeTela extends StatelessWidget {
  const NomeTela({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 60,
          child: AppBar(
            backgroundColor: white,
            actions: [
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Comparar Tabelas",
                    style: fontePreta,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TabelasComparar extends StatefulWidget {
  const TabelasComparar({Key? key}) : super(key: key);

  @override
  State<TabelasComparar> createState() => _TabelasCompararState();
}

class _TabelasCompararState extends State<TabelasComparar> {
  Widget botoes() {
    return ElevatedButton(
      style: estiloBotao,
      onPressed: () {},
      child: const Text('Abrir'),
    );
  }

  Widget botaoComparar() {
    return ElevatedButton(
      style: estiloBotao,
      onPressed: () {},
      child: const Text('Comparar'),
    );
  }

  Widget arquivoUm() {
    return SizedBox(
      height: 30,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.archive),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          labelText: "Arquivo Um",
        ),
      ),
    );
  }

  Widget arquivoDois() {
    return SizedBox(
      height: 30,
      width: 300,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.archive),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          labelText: "Arquivo Dois",
        ),
      ),
    );
  }

  Widget abrirArquivos() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: Container(
            color: Colors.amber,
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: [
                arquivoUm(),
                const SizedBox(
                  width: 10,
                ),
                botoes(),
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(
            alignment: Alignment.center,
            child: botaoComparar(),
          ),
        ),
        Flexible(
          child: Container(
            alignment: Alignment.centerRight,
            child: Wrap(
              children: [
                arquivoDois(),
                const SizedBox(
                  width: 10,
                ),
                botoes(),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NomeTela(),
        const SizedBox(
          height: 15,
        ),
        abrirArquivos(),
      ],
    );
  }
}
