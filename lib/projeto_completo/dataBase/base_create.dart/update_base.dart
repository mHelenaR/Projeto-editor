import 'package:postgres/postgres.dart';
import 'package:sqflite/sqflite.dart';

import 'package:editorconfiguracao/projeto_completo/dataBase/base_create.dart/create_dataBase.dart';

atualizarBanco(Database dataBase, var caminho, bool atualiza,
    PostgreSQLConnection bancoPostgresql) async {
  await criaTabelas(dataBase, caminho, bancoPostgresql, atualiza);
}
