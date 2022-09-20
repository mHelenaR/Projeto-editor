import 'package:flutter/material.dart';

import 'package:editorconfiguracao/projeto_completo/mensagens/status_prog.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';

void erroSalvarArquivo(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Image.asset(
            "assets/images/icon_warning_24.png",
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
                "${StatusProgram.errorSaveArchive.message} Não foi possível gravar o arquivo!\nArquivo não carregado!"),
          ),
        ],
      ),
    ),
  );
}

void erroArquivoNaoAlterado(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.edit_off_outlined, color: white),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
                '${StatusProgram.errorChangedFile.message} O sistema não detectou alterações!'),
          ),
        ],
      ),
    ),
  );
}

void erroCarregarArquivo(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Image.asset(
            "assets/images/icon_error_file.png",
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Flexible(
              child: Text(
                  '${StatusProgram.errorOperation.message}\nArquivo não selecionado!'))
        ],
      ),
    ),
  );
}

void erroTryCatch(BuildContext context, var erroName) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Image.asset(
            "assets/images/icon_cancel_24.png",
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
                'Error Program: $erroName\nVerifique a integridade dos dados do arquivo!'),
          ),
        ],
      ),
    ),
  );
}
