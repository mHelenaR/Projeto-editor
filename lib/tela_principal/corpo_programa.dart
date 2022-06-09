import 'package:editorconfiguracao/busca_arquivo/explorador_arq.dart';
import 'package:editorconfiguracao/tela_principal/barra_navegacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class corpoProjeto extends StatefulWidget {
  const corpoProjeto({Key? key}) : super(key: key);

  @override
  State<corpoProjeto> createState() => _corpoProjetoState();
}

class _corpoProjetoState extends State<corpoProjeto> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          width: double.infinity,
          child: Container(
            child: navegacao(),
          ),
        )));
  }
}
