import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
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
                "Editor de Configuração",
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
          Flexible(
            child: Container(
              alignment: Alignment.centerRight,
              child: BotaoPesquisa(),
            ),
          ),
        ],
      ),
    );
  }
  /* @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        alignment: Alignment.topLeft,
        height: 70,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Editor de Configuração',
                    style: fontePreta,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.center,
                  child: SizedBox(
                      height: 36,
                      width: 500,
                      child: Stack(
                        children: const [
                          SizedBox(
                            width: 400,
                            child: BarraPesquisa(),
                          ),
                          Positioned(
                            top: 4.5,
                            right: 0,
                            child: BotaoPesquisa(),
                          )
                        ],
                      )),
                ),
                /* Positioned(
                  top: 5,
                  right: 1,
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // Button color
                      child: InkWell(
                        splashColor: const Color(0XFF673AB7), // Splash color
                        onTap: () => exit(0),
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/images/icon_sair.png")),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }*/
}

class BarraPesquisa extends StatelessWidget {
  const BarraPesquisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        labelText: 'Pesquisar',
      ),
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
              content: const Text("cdsfvsev"),
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
      style: ElevatedButton.styleFrom(
        primary: const Color(0XFF673AB7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: const Text("Pesquisar"),
    );
  }
}
