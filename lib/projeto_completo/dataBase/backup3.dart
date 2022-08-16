// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:editorconfiguracao/projeto_completo/dataBase/base_messages/description_dialogs.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/base_messages/title_dialogs.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_container.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_fontes.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_textField.dart';

class ConexaoPostgres extends StatefulWidget {
  const ConexaoPostgres({Key? key}) : super(key: key);

  @override
  State<ConexaoPostgres> createState() => _ConexaoPostgresState();
}

class _ConexaoPostgresState extends State<ConexaoPostgres> {
  //focusNode captura eventos do teclado
  late FocusNode myFocusNode;

  bool? atualizaBanco;

  var recebeCaminhoDB;

  //Variavel recebendo a função de conexão com o banco e sendo inicializada
  var databaseConnection = PostgreSQLConnection('', 0, '');

  //Criando os controladores de texto, para receber os dados do banco
  final _ctUserDataBase = TextEditingController();
  final _ctHostDataBase = TextEditingController();
  final _ctPasswordDataBase = TextEditingController();
  final _ctPortDataBase = TextEditingController();
  final _ctNameDataBase = TextEditingController();

  //Inicializando varivais ao abrir a tela
  @override
  void initState() {
    atualizaBanco = false;
    myFocusNode = FocusNode();
    super.initState();
  }

  //Liberando a memoria assim que a tela é desfocada
  @override
  void dispose() {
    _ctUserDataBase.dispose();
    _ctHostDataBase.dispose();
    _ctPasswordDataBase.dispose();
    _ctPortDataBase.dispose();
    _ctNameDataBase.dispose();
    myFocusNode.dispose();
    databaseConnection.close();
    super.dispose();
  }

  //Inicializa a conexão com o banco
  initDatabaseConnection() async {
    //Verifica se a conexão com o banco esta fechada
    if (databaseConnection.isClosed == true) {
      databaseConnection = PostgreSQLConnection(
        _ctHostDataBase.text,
        int.parse(_ctPortDataBase.text),
        _ctNameDataBase.text,
        username: _ctUserDataBase.text,
        password: _ctPasswordDataBase.text,
      );

      //Conecta o banco de dados
      databaseConnection.open();

      //teste de select no banco

      // then(
      //   (value) async {
      //     if (databaseConnection.isClosed != true) {
      //       // var result = await databaseConnection
      //       //     .query("SELECT * FROM unidades order by uni_codigo");

      //       // //  print(result);
      //     } else {
      //       debugPrint("Desconectado!");
      //     }
      //   },
      // );
    } else {
      print('ja esta aberto');
    }
  }

  var recebe;
  // Criação do arquivo .db
  Future<void> initDB() async {
    String? path;
    try {
      //Prepara a conexão com o SQLite
      sqfliteFfiInit();
    } catch (e) {
      print(e.toString());
    }

    // verifica se esta desconectado
    if (databaseConnection.isClosed == false) {
      var databaseFactory = databaseFactoryFfi;

      if (atualizaBanco == false) {
        String? result = await FilePicker.platform.getDirectoryPath(
          dialogTitle: 'Caminho Salvar Banco',
          initialDirectory: 'C:',
        );
        recebe = result;
      }
      path = '${recebe}\\Dicionario.db';

      //FileSystemEntity gerencia os arquivos da maquina
      //typeSync: Localiza de forma síncrona o tipo de objeto do sistema de arquivos para o
      //qual um caminho aponta
      if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
        // criando o arquivo de banco sqlite
        // criaBanco(await databaseFactory.openDatabase(path));
        criaBanco(databaseFactory, path);

        databaseConnection.close();
      } else {
        caixaBancoExiste(path);
        print('O banco ja existe');
      }

      if (atualizaBanco == true) {
        var t = await databaseFactory.openDatabase(path);

        t.execute(
          "CREATE TABLE IF NOT EXISTS unidades ("
          "id_unidades INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "campo CHARACTER(30) NOT NULL,"
          "tipo CHARACTER(1) NOT NULL,  "
          "titulo CHARACTER(50) NOT NULL, "
          "mensagem CHARACTER(255) NOT NULL, "
          "mascara CHARACTER(50)"
          ");"
          "CREATE TABLE IF NOT EXISTS estac ("
          "id_unidades INTEGER  PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "campo CHARACTER(30) NOT NULL,"
          "tipo CHARACTER(1) NOT NULL,  "
          "titulo CHARACTER(50) NOT NULL, "
          "mensagem CHARACTER(255) NOT NULL, "
          "mascara CHARACTER(50)"
          ");"
          "CREATE TABLE IF NOT EXISTS teste1 ("
          "iwde INTEGER PRIMARY KEY,"
          "first_name TEXT,"
          "last_name TEXT,"
          "blocked BIT"
          ");"
          "CREATE TABLE IF NOT EXISTS teste2 ("
          "iwder INTEGER PRIMARY KEY,"
          "first_name TEXT,"
          "last_name TEXT,"
          "blocked BIT"
          ");"
          "CREATE TABLE IF NOT EXISTS teste3 ("
          "iwdt INTEGER PRIMARY KEY,"
          "first_name TEXT,"
          "last_name TEXT,"
          "blocked BIT"
          ");",
        );

        print('Atualizado');
      }
    } else {
      print('Fechado');
    }
  }

  insertTeste1(var dataBase) {
    // teste insert
    /*  insert into unidades(campo,
        tipo ,  
        titulo , 
        mensagem , 
        mascara ) values(1,2,3,4,5);*/
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  criaBanco(var database, pathw) {
    var at = database.openDatabase(pathw);
    at.execute(
      "CREATE TABLE IF NOT EXISTS Client ("
      "id INTEGER PRIMARY KEY,"
      "first_name TEXT,"
      "last_name TEXT,"
      "blocked BIT"
      ");"
      "CREATE TABLE IF NOT EXISTS teste ("
      "iwd INTEGER PRIMARY KEY,"
      "first_name TEXT,"
      "last_name TEXT,"
      "blocked BIT"
      ");"
      "CREATE TABLE IF NOT EXISTS teste1 ("
      "iwde INTEGER PRIMARY KEY,"
      "first_name TEXT,"
      "last_name TEXT,"
      "blocked BIT"
      ");"
      "CREATE TABLE IF NOT EXISTS teste2 ("
      "iwder INTEGER PRIMARY KEY,"
      "first_name TEXT,"
      "last_name TEXT,"
      "blocked BIT"
      ");"
      "CREATE TABLE IF NOT EXISTS teste3 ("
      "iwdt INTEGER PRIMARY KEY,"
      "first_name TEXT,"
      "last_name TEXT,"
      "blocked BIT"
      ");",
    );
  }

  void caixaBancoExiste(String caminho) {
    showDialog(
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
                closeDialog(context);
                initDB();
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
                          textInputAction: TextInputAction.next,
                          controller: _ctHostDataBase,
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
                          textInputAction: TextInputAction.next,
                          controller: _ctNameDataBase,
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
                          textInputAction: TextInputAction.next,
                          controller: _ctPortDataBase,
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
                          textInputAction: TextInputAction.next,
                          controller: _ctUserDataBase,
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
                          textInputAction: TextInputAction.next,
                          controller: _ctPasswordDataBase,
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
