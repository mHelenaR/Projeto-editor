import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
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
