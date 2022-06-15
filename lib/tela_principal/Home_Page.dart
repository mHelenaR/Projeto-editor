import 'package:editorconfiguracao/Cores_Projeto/cores.dart';
import 'package:flutter/material.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 60,
          child: AppBar(
            backgroundColor: white,
            actions: [
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Editor de Configuração',
                    style: TextFormato,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
