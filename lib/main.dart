// páginas
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:editorconfiguracao/projeto_completo/telas/corpo_programa.dart';
// funções
import 'package:flutter/material.dart';

void main() {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    doWhenWindowReady(
      () {
        final windowsScreen = appWindow;
        const initialSize = Size(1270, 700);
        windowsScreen.minSize = initialSize;
        windowsScreen.size = initialSize;
        windowsScreen.alignment = Alignment.center;
        windowsScreen.title = "Editor de Configuração";
        windowsScreen.show();
      },
    );

    runApp(const CorpoProjeto());
  } catch (e) {
    debugPrint(e.toString());
  }
}
