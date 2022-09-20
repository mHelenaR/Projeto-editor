import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:flutter/material.dart';

final estiloBotao = ElevatedButton.styleFrom(
  backgroundColor: purpleAB7,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);

final estiloBotao2 = ElevatedButton.styleFrom(
  elevation: 0,
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

final botaoAviso = ElevatedButton.styleFrom(
  padding: const EdgeInsets.all(10),
  backgroundColor: Colors.yellow[700],
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);
