// Bibliotecas

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/projeto_completo/menuPrincipal/menu_program.dart';

class CorpoProjeto extends StatefulWidget {
  const CorpoProjeto({Key? key}) : super(key: key);

  @override
  State<CorpoProjeto> createState() => _CorpoProjetoState();
}

class _CorpoProjetoState extends State<CorpoProjeto> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        animationDuration: const Duration(seconds: 1),
        splashIconSize: 600,
        splash: 'assets/images/icone_rp1.png',
        nextScreen: const MenuPrincipal(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 600,
      ),
    );
  }
}
