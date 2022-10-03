// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_fontes.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
              ElevatedButton(
                  onPressed: () async {
                    var novo = await databaseFactoryFfi
                        .openDatabase('C:\\baseDados flutter\\Dicionario.db');

                    var result = await novo.query('estac', columns: ['campo']);
                    print(result);
                  },
                  child: Text('banco teste'))
            ],
          ),
        ),
      ],
    );
  }
}
