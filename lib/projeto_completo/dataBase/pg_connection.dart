// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print

import 'dart:io';

import 'package:editorconfiguracao/projeto_completo/dataBase/base_create.dart/insert_dataBase.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/base_create.dart/update_base.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:editorconfiguracao/projeto_completo/dataBase/base_create.dart/create_dataBase.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/base_messages/description_dialogs.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/base_messages/title_dialogs.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_container.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_fontes.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_textField.dart';

class TelaConexao extends StatefulWidget {
  const TelaConexao({Key? key}) : super(key: key);

  @override
  State<TelaConexao> createState() => _TelaConexaoState();
}

class _TelaConexaoState extends State<TelaConexao> {
  //focusNode captura eventos do teclado
  late FocusNode myFocusNode;
  String? path;
  bool? atualizaBanco;

  var recebeCaminhoDB;
  var recebe;

  //Variavel recebendo a função de conexão com o banco e sendo inicializada
  var databaseConnection = PostgreSQLConnection('', 0, '');
  var databaseFactory = databaseFactoryFfi;

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
      // databaseConnection = PostgreSQLConnection(
      //   "10.1.12.73",
      //   5432,
      //   "mariah_wrpdv",
      //   username: "rpdv",
      //   password: "rpdvwin1064",
      // );
      databaseConnection = PostgreSQLConnection(
        _ctHostDataBase.text,
        int.parse(_ctPortDataBase.text),
        _ctNameDataBase.text,
        username: _ctUserDataBase.text,
        password: _ctPasswordDataBase.text,
      );

      databaseConnection.open();
    } else {
      print('ja esta aberto');
    }
  }

  Future<void> initDB() async {
    if (databaseConnection.isClosed == false) {
      if (atualizaBanco == false) {
        String? result = await FilePicker.platform.getDirectoryPath(
          dialogTitle: 'Caminho Salvar Banco',
          initialDirectory: 'C:',
        );
        recebe = result;
      }
      setState(() {
        path = '${recebe}\\Dicionario.db';
      });

      if (FileSystemEntity.typeSync(path!) == FileSystemEntityType.notFound) {
        var novo = await databaseFactory.openDatabase(path!);

        criaTabelas(novo, path!, databaseConnection, atualizaBanco!);
      } else {
        caixaBancoExiste(path!);

        print('O banco ja existe');
      }
    } else {
      print('Fechado');
    }
  }

  atualizar() async {
    var novo = await databaseFactory.openDatabase(path!);
    atualizarBanco(novo, path!, atualizaBanco!, databaseConnection);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
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
