// Bibliotecas

import 'package:editorconfiguracao/projeto_completo/componentes_telas/sidebarX.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// Importar arquivos
import 'package:editorconfiguracao/projeto_completo/componentes_telas/navBar_corpo.dart';
import 'package:editorconfiguracao/projeto_completo/componentes_telas/app_bar.dart';

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
