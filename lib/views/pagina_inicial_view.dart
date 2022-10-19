// ignore_for_file: file_names, depend_on_referenced_packages, unused_import, avoid_print, unused_local_variable, prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_fontes.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: AppBar(
            backgroundColor: white,
            actions: [
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Editor de Configuração',
                    style: fontePreta,
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
