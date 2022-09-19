import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/tabelas/corpo_tabela/variaveis.dart';
import 'package:flutter/material.dart';

final decoracaoContainer = BoxDecoration(
  color: corContainer,
  borderRadius: BorderRadius.circular(20),
  boxShadow: const <BoxShadow>[
    BoxShadow(
      color: Colors.black54,
      blurRadius: 10.0,
      offset: Offset(5.0, 5.0),
    ),
  ],
);

final containerSideBar = BoxDecoration(
  gradient: const LinearGradient(
    colors: [itemMenuCor1, purpleF99],
  ),
  border: Border.all(
    color: itemMenuOpacity,
  ),
  borderRadius: BorderRadius.circular(5),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.28),
      blurRadius: 30,
    ),
  ],
);

final containerConfig = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: white,
  border: Border.all(
    color: Colors.black.withOpacity(0.28),
  ),
);

final containerOpSelecionada = BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  color: Colors.purple[50],
);

final containerOp = BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  color: white,
);
