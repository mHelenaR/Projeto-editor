import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class appBarra extends StatefulWidget {
  const appBarra({Key? key}) : super(key: key);

  @override
  State<appBarra> createState() => _appBarraState();
}

class _appBarraState extends State<appBarra> {
  final formatarTexto =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
          alignment: Alignment.topLeft,
          height: 65,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Teste',
                      style: formatarTexto,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 36,
                        width: 500,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 400,
                              child: BarraPesquisa(),
                            ),
                            Positioned(
                                top: 4.5, right: 0, child: botaoPesquisa())
                          ],
                        )),
                  ),
                  Positioned(
                      top: 5,
                      right: 1,
                      child: ClipOval(
                        child: Material(
                          color: Colors.white, // Button color
                          child: InkWell(
                            splashColor: Color(0XFF673AB7), // Splash color
                            onTap: () => exit(0),
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child:
                                    Image.asset("assets/images/icon_sair.png")),
                          ),
                        ),
                      )),
                ])
              ])),
    );
  }
}

class BarraPesquisa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          labelText: 'Pesquisar',
        ));
  }
}

class botaoPesquisa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: Text("Pesquisar"),
        style: ElevatedButton.styleFrom(
          primary: Color(0XFF673AB7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ));
  }
}
