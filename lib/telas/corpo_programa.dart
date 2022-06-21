// Bibliotecas

import 'package:editorconfiguracao/componentes_telas/sidebarX.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// Importar arquivos
import 'package:editorconfiguracao/componentes_telas/navBar_corpo.dart';
import 'package:editorconfiguracao/componentes_telas/app_bar.dart';

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
        body: SideBarExpansivel(),
      ),
    );
  }
}
