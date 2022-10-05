import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:editorconfiguracao/connection_sqflite.dart';
import 'package:editorconfiguracao/projeto_completo/pages/tela_carregamento.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    /* Esse plugin [bitsdojo_window] edita as configurações da tela nativa do windows;
     * O bloco abaixo define o tamanho inicial da tela e
     * bloqueia o redimencionamento, para evitar erros de 
     * Range nos componentes;
     * O método [show] inicia a tela após a leitura das configurações;
     */

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

    if (Platform.isWindows) {
      sqfliteFfiInit();
      await connectSqlite();
    }

    runApp(const SplashScreen());
  } catch (e) {
    debugPrint(e.toString());
  }
}
