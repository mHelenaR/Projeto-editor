// bibliotecas-classes
import 'package:flutter/material.dart';

// Importar outros arquivos
import 'package:editorconfiguracao/main.dart';

class telaInicial extends StatelessWidget {
  const telaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
      ),
    );
  }
}
