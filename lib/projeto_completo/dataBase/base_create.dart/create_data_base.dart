import 'package:sqflite/sqflite.dart';

import 'package:editorconfiguracao/projeto_completo/dataBase/base_create.dart/insert_dataBase.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/converte_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/nome_tabelas.dart';
import 'package:editorconfiguracao/projeto_completo/separa_arquivo/seleciona_arquivo.dart';

criaTabelas(Database dataBase, var caminho, var base, bool atualiza) async {
  List<String> listaTabelas = [];
  var batch = dataBase.batch();
  try {
    listaTabelas = await nomeTabelasArquivo(
        await converteArquivo(await arquivoGeraBanco()));

    for (final deletaTabelas in listaTabelas) {
      batch.execute("Drop table if exists $deletaTabelas;");
    }
    for (final tabelas in listaTabelas) {
      batch.execute(
        "CREATE TABLE IF NOT EXISTS $tabelas ("
        "id_$tabelas INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "campo CHARACTER(30) NOT NULL,"
        "tipo CHARACTER(1) NOT NULL,  "
        "titulo CHARACTER(50) NOT NULL, "
        "mensagem CHARACTER(255) NOT NULL, "
        "mascara CHARACTER(50)"
        ");\n",
      );
    }
  } finally {
    batch.commit();

    insertTabelas(base, caminho, dataBase, listaTabelas);
  }
}
