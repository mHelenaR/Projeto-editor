// ignore_for_file: file_names, await_only_futures, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print

import 'package:postgres/postgres.dart';
import 'package:sqflite/sqflite.dart';

insertTabelas(PostgreSQLConnection basePostgresql, var caminhoArquivo,
    Database baseSqlite, var tabelas) async {
  var batch = await baseSqlite.batch();

  var tabela, campo, titulo, mensagem, mascara, tipo;

  List<String> listaTabelas = [];

  listaTabelas = await tabelas;

  for (final nomeTabelas in listaTabelas) {
    List<Map<String, Map<String, dynamic>>> resul =
        await basePostgresql.mappedResultsQuery(
      "SELECT tabela, campo, titulo, mensagem, mascara, tipo FROM dicionario where tabela = upper('$nomeTabelas')",
    );

    for (final element in resul) {
      for (final valoresBanco in element.entries) {
        tabela = valoresBanco.value["tabela"];
        tipo = valoresBanco.value["tipo"];
        campo = valoresBanco.value["campo"];
        titulo = valoresBanco.value["titulo"];
        mensagem = valoresBanco.value["mensagem"];
        mascara = valoresBanco.value["mascara"];
        var value = {
          'campo': campo,
          'tipo': tipo,
          'titulo': titulo,
          'mensagem': mensagem,
          'mascara': mascara,
        };

        batch.insert(nomeTabelas, value);

        print('Atualizado');
      }
    }
  }

  await batch.commit();
}
