// Bibliotecas

import 'package:editorconfiguracao/projeto_completo/menuPrincipal/menu_program.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:flutter/material.dart';

class CorpoProjeto extends StatefulWidget {
  const CorpoProjeto({Key? key}) : super(key: key);

  @override
  State<CorpoProjeto> createState() => _CorpoProjetoState();
}

class _CorpoProjetoState extends State<CorpoProjeto> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // tratamento de erros de widget
      builder: (context, widget) {
        Widget error = const Text('...Erro de renderização...');
        if (widget is Scaffold || widget is Navigator) {
          error = Scaffold(body: Center(child: error));
        }
        ErrorWidget.builder = (errorDetails) => error;
        if (widget != null) return widget;
        throw ('widget is null');
      },
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: white,
        body: MenuPrincipal(),
      ),
    );
  }
}
