import 'package:editorconfiguracao/projeto_completo/abre%20arquivo/abreExplorador.dart';
import 'package:editorconfiguracao/projeto_completo/busca_arquivo/explorador_arq.dart';
import 'package:editorconfiguracao/projeto_completo/componentes_telas/app_bar.dart';
import 'package:flutter/material.dart';

class TelaTabelas extends StatefulWidget {
  const TelaTabelas({Key? key}) : super(key: key);

  @override
  State<TelaTabelas> createState() => _TelaTabelasState();
}

class _TelaTabelasState extends State<TelaTabelas> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppBarra(),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const PesquisaArquivo(),
        ),
        // ExploradorArquivos(),
      ],
    );
  }
}
