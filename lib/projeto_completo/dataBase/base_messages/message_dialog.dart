import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';

dialogAviso(var context, var nomeBanco) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: Container(
          alignment: Alignment.center,
          child: Lottie.asset("assets/lottie/lottie_warning5.json"),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Aviso!",
          style: TextStyle(color: purpleF99, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: 400,
          child: Text(
            "O banco: '$nomeBanco' já está conectado!",
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          dividerGrey,
          const SizedBox(
            height: 13,
          ),
          Center(
            child: SizedBox(
              height: 35,
              width: 200,
              child: ElevatedButton(
                style: estiloBotao3,
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      );
    },
  );
}
