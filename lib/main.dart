// páginas
import 'busca_arquivo/explorador_arq.dart';
import 'tela_principal/interface_inicial.dart';
// funções
import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TelaPrincipal(), debugShowCheckedModeBanner: false));
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ExploradorArquivos(),
      ),
    );
  }
}
