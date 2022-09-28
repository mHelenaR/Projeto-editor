// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unnecessary_import, unused_import, prefer_typing_uninitialized_variables
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/criacao_tabs/tabs_create.dart';
import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_pluto_grid.dart';

class TesteTabela extends StatefulWidget {
  var contador;
  var caminho;
  var colunas;
  var linhas;
  var child;

  TesteTabela(
      {Key? key,
      this.child,
      this.contador,
      this.caminho,
      this.colunas,
      this.linhas})
      : super(key: key);

  @override
  State<TesteTabela> createState() => _TesteTabelaState();
}

class _TesteTabelaState extends State<TesteTabela> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
