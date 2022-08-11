import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_fontes.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_inkButton.dart';
import 'package:flutter/material.dart';

Widget arquivoAppBarTable(
    BuildContext context, var barraPesquisa, var botaoPesquisa) {
  return SizedBox(
    height: 70,
    child: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: white,
      actions: [
        const SizedBox(
          width: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: inkButton(context),
        ),
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
            child: SizedBox(
              height: 40,
              child: barraPesquisa,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Container(
            alignment: Alignment.centerLeft,
            child: botaoPesquisa,
          ),
        ),
      ],
    ),
  );
}
