// Bibliotecas

import 'package:editorconfiguracao/projeto_completo/componentes_telas/sidebarX.dart';
import 'package:flutter/material.dart';

class CorpoProjeto extends StatefulWidget {
  const CorpoProjeto({Key? key}) : super(key: key);

  @override
  State<CorpoProjeto> createState() => _CorpoProjetoState();
}

class _CorpoProjetoState extends State<CorpoProjeto> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SideBarExpansivel(),
      ),
    );
  }
}
