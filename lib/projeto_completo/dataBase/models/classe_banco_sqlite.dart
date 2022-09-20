import 'dart:io';

import 'package:editorconfiguracao/projeto_completo/dataBase/base_messages/title_dialogs.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/projeto_completo/dataBase/base_create.dart/create_data_base.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/base_create.dart/update_base.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/base_messages/description_dialogs.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/controllers/variaveis.dart';

class CriaArquivoDB {
  BuildContext context;

  CriaArquivoDB({required this.context});

  Future<void> initDB() async {
    if (databaseConnection.isClosed == false) {
      if (atualizaBanco == false) {
        String? result = await FilePicker.platform.getDirectoryPath(
          dialogTitle: 'Caminho Salvar Banco',
          initialDirectory: 'C:',
        );
        if (result != null) {
          recebe = result;
          path = '$recebe\\Dicionario.db';
        }
      }

      if (FileSystemEntity.typeSync(path!) == FileSystemEntityType.notFound) {
        var novo = await databaseFactory.openDatabase(path!);

        criaTabelas(novo, path!, databaseConnection, atualizaBanco!);
      } else {
        caixaBancoExiste(path!);
        debugPrint('O banco ja existe');
      }
    } else {
      debugPrint('Fechado');
    }
  }

  atualizar() async {
    var novo = await databaseFactory.openDatabase(path!);
    atualizarBanco(novo, path!, atualizaBanco!, databaseConnection);
  }

  caixaBancoExiste(String caminho) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: erroCriacao,
          content: descricaoErroCriacao(caminho),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Atualizar"),
              onPressed: () {
                atualizaBanco = true;
                atualizar();
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
