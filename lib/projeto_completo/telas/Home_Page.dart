import 'package:editorconfiguracao/projeto_completo/style_project/cores.dart';
import 'package:flutter/material.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: AppBar(
        backgroundColor: white,
        actions: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Editor de Configuração',
                style: textFormato,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
