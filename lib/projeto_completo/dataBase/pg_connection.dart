// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:postgres/postgres.dart';
import 'package:sqflite/sqflite.dart';
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
  // String? path = r'/storage/';
  bool? atualizaBanco;
  Color? cor;
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

  testeConect(var cor) {
    if (databaseConnection.isClosed != false) {
      setState(() {
        cor = Colors.green;
      });
    } else {
      setState(() {
        cor = Colors.red;
      });
    }
  }

  //Inicializa a conexão com o banco
  initDatabaseConnection() async {
    //Verifica se a conexão com o banco esta fechada
    if (databaseConnection.isClosed == true) {
      databaseConnection = PostgreSQLConnection(
        "10.1.12.73",
        5432,
        "mariah_wrpdv",
        username: "rpdv",
        password: "rpdvwin1064",
      );

      //Conecta o banco de dados
      databaseConnection.open();
    } else {
      print('ja esta aberto');
    }
  }

  var recebe;
  // Criação do arquivo .db
  Future<void> initDB() async {
    String? teste1 = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Novo teste 1 novo teste',
      lockParentWindow: true,
      initialDirectory: 'C:\\',
    );

    String path = '$teste1\\Dicionario.db';
    print(path);

    // var teste2 = databaseFactoryFfi.openDatabase(path);
  }

  closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void bancoCriado(String caminho) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Banco Criado"),
          content: descricaoErroCriacao(caminho),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Ok"),
              onPressed: () {
                closeDialog(context);
              },
            ),
          ],
        );
      },
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
                closeDialog(context);
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
              mainAxisAlignment: MainAxisAlignment.start,
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
