import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import 'package:editorconfiguracao/projeto_completo/mensagens/alert_dialog/dialog_warning.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/controllers/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/models/classes_metodos.dart';

class PostgresConnect {
  BuildContext context;

  PostgresConnect({
    required this.context,
  });

  iniciaPostgresql() async {
    /*  Verifica se a conexão com o banco esta fechada
     */

    if (databaseConnection.isClosed == true) {
      databaseConnection = PostgreSQLConnection(
        "10.1.12.73",
        5432,
        "mariah_wrpdv",
        username: "rpdv",
        password: "rpdvwin1064",
      );
      // databaseConnection = PostgreSQLConnection(
      //   objControlBase.hostBanco.text,
      //   int.parse(objControlBase.portaBanco.text),
      //   objControlBase.nomeBanco.text,
      //   username: objControlBase.usuarioBanco.text,
      //   password: objControlBase.senhaBanco.text,
      // );

      // Menssagens de debug
      debugInfoBase();

      databaseConnection.open();
    } else {
      criaObjeto = CaixaAviso(
        contexto: context,
        texto: "O banco ${objControlBase.nomeBanco.text} já está conectado!",
      );

      criaObjeto.aviso();

      reiniciaObjeto(criaObjeto);

      debugPrint('O banco já está conectado!');
    }
  }
}
