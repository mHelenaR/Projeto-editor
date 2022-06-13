import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class paginaInicial extends StatelessWidget {
  const paginaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 75,
                    color: Colors.amber,
                    child: Text(
                      "Editor de Configuração",
                      textAlign: TextAlign.center,
                    )),
              ],
            )
          ],
        ),
      ],
    );
  }
}
