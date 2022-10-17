import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';

connectSqlite() async {
  List<Map> tabelasCompletas = [];
  List<String> tabelasDcn = [];

  var novo = await databaseFactoryFfi
      .openDatabase('C:\\baseDados flutter\\Dicionario.db');

  var type = '"table"';

  List<Map<String, Object?>> result = await novo.query(
    'sqlite_master',
    columns: ['name'],
    where: 'type = $type',
  );

  for (var i = 0; i < result.length; i++) {
    Map mapaSqflite = result[i];

    String tabelasSqflite = mapaSqflite['name'];

    if (tabelasSqflite != 'sqlite_sequence') {
      tabelasDcn.addAll([tabelasSqflite]);

      var valor = await novo
          .query(tabelasSqflite, columns: ['campo', 'titulo', 'mensagem']);

      for (var j = 0; j < valor.length; j++) {
        var mapaColunas = valor[j];

        Map novow = {
          tabelasSqflite: {
            'campo': mapaColunas['campo'],
            'titulo': mapaColunas['titulo'],
            'mensagem': mapaColunas['mensagem'],
          }
        };

        tabelasCompletas.addAll([novow]);
      }
    }
  }

  objSqlite.setnomeColunasDcn = tabelasDcn;
  objSqlite.setTabelasCompletas = tabelasCompletas;
}
