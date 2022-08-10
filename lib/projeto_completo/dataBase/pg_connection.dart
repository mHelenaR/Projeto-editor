// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_container.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class ConexaoPostgres extends StatefulWidget {
  const ConexaoPostgres({Key? key}) : super(key: key);

  @override
  State<ConexaoPostgres> createState() => _ConexaoPostgresState();
}

class _ConexaoPostgresState extends State<ConexaoPostgres> {
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
        var email;
        List<Map<String, Map<String, dynamic>>> result =
            await databaseConnection.mappedResultsQuery(
                "SELECT * FROM unidades",
                substitutionValues: {
              "aEmail": email,
            });

        for (var element in result) {
          print(element.values);
        }
      } else {
        debugPrint("Desconectado!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        appBarConfig(),
        // Container(
        //   color: Colors.amber[50],
        //   child: ElevatedButton(
        //     onPressed: initDatabaseConnection,
        //     child: const Text('Conectar teste'),
        //   ),
        // ),
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
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Conectar tabela Dicionário",
                    style: fontePreta10,
                  ),
                ),
              ),
            ],
          ),
          Wrap(
            verticalDirection: VerticalDirection.up,
            children: [
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
            ],
          )
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
