import 'package:flutter/material.dart';

import 'package:editorconfiguracao/projeto_completo/dataBase/controllers/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/models/classe_banco_sqlite.dart';
import 'package:editorconfiguracao/projeto_completo/dataBase/models/classe_postgresql.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
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
  @override
  void initState() {
    atualizaBanco = false;

    super.initState();
  }

  @override
  void dispose() {
    objControlBase.usuarioBanco.text = "";
    objControlBase.hostBanco.text = "";
    objControlBase.nomeBanco.text = "";
    objControlBase.portaBanco.text = "";
    objControlBase.senhaBanco.text = "";

    databaseConnection.close();

    super.dispose();
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

  Container conectarBanco() {
    return Container(
      height: 300,
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
                  textField(
                    "IP do servidor",
                    objControlBase.hostBanco,
                    tFBancoConexao1,
                  ),
                  //DataBaseName
                  const SizedBox(
                    height: 5,
                  ),
                  textField(
                    "Nome Base de Dados:",
                    objControlBase.nomeBanco,
                    tFBancoConexao2,
                  ),

                  //Port
                  const SizedBox(
                    height: 5,
                  ),
                  textField(
                    "Porta:",
                    objControlBase.portaBanco,
                    tFBancoConexao3,
                  ),

                  //User
                  const SizedBox(
                    height: 5,
                  ),
                  textField(
                    "Usuário:",
                    objControlBase.usuarioBanco,
                    tFBancoConexao4,
                  ),

                  //Password
                  const SizedBox(
                    height: 5,
                  ),
                  textField(
                    "Senha:",
                    objControlBase.senhaBanco,
                    tFBancoConexao5,
                  ),

                  //Button conection
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: estiloBotao,
                        onPressed: () {
                          var objPostConnect = PostgresConnect(
                            context: context,
                          );
                          objPostConnect.iniciaPostgresql();
                        },
                        child: const Text('Conectar'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        style: estiloBotao,
                        onPressed: () {
                          var objPostConnect = CriaArquivoDB(
                            context: context,
                          );
                          objPostConnect.initDB();
                        },
                        child: const Text('Gerar .DB'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row textField(var label, var controller, var decoration) {
    return Row(
      children: [
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            label,
            style: fontePreta14,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          height: 30,
          width: 200,
          child: TextField(
            textInputAction: TextInputAction.next,
            controller: controller,
            decoration: decoration,
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }

  SizedBox appBarConfig() {
    return SizedBox(
      height: 70,
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        actions: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Configurações do sistema', style: fontePreta),
            ),
          ),
        ],
      ),
    );
  }
}
