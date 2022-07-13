// páginas
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:editorconfiguracao/projeto_completo/telas/corpo_programa.dart';
// funções
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  doWhenWindowReady(
    () {
      final win = appWindow;
      const initialSize = Size(1270, 700);
      win.minSize = initialSize;
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "Editor de Configuração";
      win.show();
    },
  );

  runApp(const CorpoProjeto());
}
