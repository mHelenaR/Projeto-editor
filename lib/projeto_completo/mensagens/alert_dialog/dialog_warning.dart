import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:editorconfiguracao/projeto_completo/dataBase/base_messages/title_dialogs.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';

class CaixaAviso {
  BuildContext contexto;

  String texto;

  CaixaAviso({
    required this.contexto,
    required this.texto,
  });

  aviso() {
    return showDialog(
      barrierDismissible: false,
      context: contexto,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Container(
            alignment: Alignment.center,
            child: Lottie.asset("assets/lottie/lottie_warning6.json"),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: dlgWarning,
          content: SizedBox(
            width: 300,
            child: Text(
              texto,
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
                  style: botaoAviso,
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
}
