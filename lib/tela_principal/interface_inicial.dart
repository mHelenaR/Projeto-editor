// bibliotecas-classes
import 'package:editorconfiguracao/busca_arquivo/explorador_arq.dart';
import 'package:editorconfiguracao/tela_principal/corpo_programa.dart';
import 'package:flutter/material.dart';

// Importar outros arquivos
import 'package:editorconfiguracao/main.dart';

class telaInicial extends StatelessWidget {
  const telaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: corpoProjeto(),
    );
  }
}
