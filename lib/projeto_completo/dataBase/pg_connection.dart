import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
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
    return Container(
      child: Column(
        children: [
          appBarConfig(),
          Container(
            color: Colors.amber[50],
            child: ElevatedButton(
              child: Text('Conectar teste'),
              onPressed: initDatabaseConnection,
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarConfig() {
    return Flexible(
      child: Container(
        height: 70,
        child: AppBar(
          backgroundColor: white,
          actions: [
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
