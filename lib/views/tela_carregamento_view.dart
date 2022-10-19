import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:editorconfiguracao/widgets/menu_principal_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
