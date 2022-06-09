import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class appBarra extends StatelessWidget {
  final formatarTexto =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      // margin: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
      height: 65,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom:
              BorderSide(width: 1.0, color: Color.fromARGB(255, 105, 105, 105)),
        ),
        color: Colors.white,
        /*borderRadius: BorderRadius.only(
            topLeft: Radius.circular(17.0),
            bottomLeft: Radius.circular(17.0),
          )*/
      ),
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(20),
        child: Text(
          'Teste',
          style: formatarTexto,
        ),
      ),
    );
  }
}
