import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_pesquisa.dart';
import 'package:flutter/material.dart';

class AppBarra extends StatefulWidget {
  const AppBarra({Key? key}) : super(key: key);

  @override
  State<AppBarra> createState() => _AppBarraState();
}

class _AppBarraState extends State<AppBarra> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
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
                "Tabelas",
                style: fontePreta,
              ),
            ),
          ),
          Flexible(
            child: Container(
              alignment: Alignment.center,
              child: const SizedBox(
                height: 40,
                child: BarraPesquisa(),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              alignment: Alignment.centerLeft,
              child: const BotaoPesquisa(),
            ),
          ),
        ],
      ),
    );
  }
}

class BarraPesquisa extends StatelessWidget {
  const BarraPesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: styleBarraPesquisa,
    );
  }
}

class BotaoPesquisa extends StatelessWidget {
  const BotaoPesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("teste"),
              content: const Text("teste"),
              actions: <Widget>[
                TextButton(
                  child: const Text("Fechar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      style: estiloBotao,
      child: const Text("Pesquisar"),
    );
  }
}
