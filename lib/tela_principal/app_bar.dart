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
  bool sidebarOpen = true;

  double xOffset = 60;
  double yOffset = 0;

  int selectMenu = 0;

  void setSidebarState() {
    setState(() {
      xOffset = sidebarOpen ? 220 : 60;
    });
  }

  final formatarTexto =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
          alignment: Alignment.topLeft,
          // margin: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
          height: 65,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
              Positioned(
                  top: 5,
                  right: 0,
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // Button color
                      child: InkWell(
                        splashColor: Color(0XFF673AB7), // Splash color
                        onTap: () {},
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/images/icon_sair.png")),
                      ),
                    ),
                  )),
            ])
          ])),
    );
  }
}
