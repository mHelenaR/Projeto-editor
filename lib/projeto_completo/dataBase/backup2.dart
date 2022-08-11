// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:io';

import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_container.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_fontes.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_textField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:postgres/postgres.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ConexaoPostgres extends StatefulWidget {
  const ConexaoPostgres({Key? key}) : super(key: key);

  @override
  State<ConexaoPostgres> createState() => _ConexaoPostgresState();
}

class _ConexaoPostgresState extends State<ConexaoPostgres> {
  var _recebeCaminhoDB;
  var userDataBase = TextEditingController();
  var hostDataBase = TextEditingController();
  var passwordDataBase = TextEditingController();
  var portDataBase = TextEditingController();
  var nameDataBase = TextEditingController();

  var databaseConnection = PostgreSQLConnection(
    '10.1.12.73',
    5432,
    'mariah_wrpdv',
    username: 'rpdv',
    password: 'rpdvwin1064',
  );

  initDatabaseConnection() async {
    databaseConnection.open().then((value) async {
      if (databaseConnection.isClosed != true) {
        var result = await databaseConnection
            .query("SELECT * FROM unidades order by uni_codigo");

        // print(result);
      } else {
        debugPrint("Desconectado!");
      }
    });
  }

// Pega diretório da pasta
  Future<void> caminhoDB() async {
    String? caminhoArquivo = r'/storage/';

    String? result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Caminho .db',
      initialDirectory: 'C:',
    );

    if (result != null) {
      caminhoArquivo = result;
      setState(() {
        _recebeCaminhoDB = caminhoArquivo!;
        print(_recebeCaminhoDB);
      });
    }
  }

  // static Database? _database;

  // Future<Database?> get database async {
  //   if (_database != null) return _database;

  //   // if _database is null we instantiate it
  //   _database = await initDB();
  //   return _database;
  // }

  Future<void> initDB() async {
    try {
      sqfliteFfiInit();
    } catch (e) {
      print(e.toString());
    }
    var _databaseFactory = databaseFactoryFfi;
    String? result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Caminho .db',
      initialDirectory: 'C:',
    );

    String path = result! + '\\TestDB.db';
    print(path);
    var _db = await _databaseFactory.openDatabase(path);

    _db.execute(
      "CREATE TABLE Client ("
      "id INTEGER PRIMARY KEY,"
      "first_name TEXT,"
      "last_name TEXT,"
      "blocked BIT"
      ")",
    );
  }

  Future<void> initDB2() async {
    try {
      sqfliteFfiInit();
    } catch (e) {
      print(e.toString());
    }
    var _databaseFactory = databaseFactoryFfi;

    String? resultw = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Caminho .db',
      initialDirectory: 'C:',
    );

    String path = '${await resultw}\\myDB.db';
    var _db = await _databaseFactory.openDatabase(path);

    final List<Map<String, dynamic>> result = await _db.query(
      'sqlite_master',
      where: 'name = ?',
      whereArgs: <String>['MyDB'],
    );

    if (result.isEmpty) {
      await _db.execute('''
CREATE TABLE MyDB (
  id INTEGER PRIMARY KEY,
  name TEXT
)
''');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        appBarConfig(),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: SizedBox(
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                conectarBanco(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget conectarBanco() {
    return Container(
      height: 400,
      width: 400,
      decoration: containerConfig,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 5,
          ),
          Flexible(
            child: SizedBox(
              height: 390,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Conectar tabela Dicionário",
                      style: fontePreta16,
                    ),
                  ),

                  //HostName
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Endereço do Servidor:',
                        style: fontePreta14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 30,
                        width: 200,
                        child: TextFormField(
                          decoration: tFBancoConexao1,
                        ),
                      ),
                    ],
                  ),

                  //DataBaseName
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Nome Base de Dados:',
                        style: fontePreta14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 30,
                        width: 200,
                        child: TextFormField(
                          decoration: tFBancoConexao2,
                        ),
                      ),
                    ],
                  ),

                  //Port
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Porta:',
                        style: fontePreta14,
                      ),
                      const SizedBox(
                        width: 27,
                      ),
                      SizedBox(
                        height: 30,
                        width: 200,
                        child: TextFormField(
                          decoration: tFBancoConexao3,
                        ),
                      ),
                    ],
                  ),

                  //User
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Usuário:',
                        style: fontePreta14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 30,
                        width: 200,
                        child: TextFormField(
                          decoration: tFBancoConexao4,
                        ),
                      ),
                    ],
                  ),

                  //Password
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Senha:',
                        style: fontePreta14,
                      ),
                      const SizedBox(
                        width: 21.4,
                      ),
                      SizedBox(
                        height: 30,
                        width: 200,
                        child: TextFormField(
                          decoration: tFBancoConexao5,
                        ),
                      ),
                    ],
                  ),

                  //Button conection
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Wrap(
                      children: [
                        ElevatedButton(
                          style: estiloBotao,
                          onPressed: initDatabaseConnection,
                          child: const Text('Conectar'),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          style: estiloBotao,
                          onPressed: initDB,
                          child: const Text('Gerar .DB'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarConfig() {
    return Container(
      height: 70,
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        actions: [
          const SizedBox(
            width: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text('Configurações do sistema', style: fontePreta),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
}
