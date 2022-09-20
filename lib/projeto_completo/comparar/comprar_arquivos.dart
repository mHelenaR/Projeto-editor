// ignore_for_file: unused_local_variable, unused_field, prefer_typing_uninitialized_variables, await_only_futures, unused_import, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:editorconfiguracao/projeto_completo/menuPrincipal/menu_program.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_sidebar_menu.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_colors_project.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_container.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_elevated_button.dart';
import 'package:editorconfiguracao/projeto_completo/style_project/style_fontes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:sidebarx/sidebarx.dart';

class CompararArquivos extends StatelessWidget {
  CompararArquivos({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            SidebarX(
              controller: _controller,
              theme: temaMenu,
              extendedTheme: backgroundMenu,
              footerDivider: dividerWhite,
              items: [
                SidebarXItem(
                  iconWidget: Image.asset(
                    "assets/images/icon_setaEsquerda.png",
                    color: Colors.white,
                  ),
                  label: "Voltar",
                  onTap: () => Navigator.pop(context),
                ),
                SidebarXItem(
                  iconWidget: Image.asset("assets/images/icon_prancheta.png",
                      color: Colors.white),
                  label: "Comparar",
                ),
              ],
            ),
            const Expanded(
              child: Center(
                child: TabelasComparar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NomeTela extends StatelessWidget {
  const NomeTela({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 60,
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
                    "Comparar Tabelas",
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

class TabelasComparar extends StatefulWidget {
  const TabelasComparar({Key? key}) : super(key: key);

  @override
  State<TabelasComparar> createState() => _TabelasCompararState();
}

class _TabelasCompararState extends State<TabelasComparar> {
  var _arquivoUmRecebeCaminho,
      arquivoUmCaminho,
      arquivoDoisCaminho,
      _arquivoDoisRecebeCaminho = '';
  String arquivoUmContent = '', arquivoDoisContent = '';

  Future<void> abreArqUm() async {
    try {
      String? arquivoUmCaminho = 'r/File/';
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['cfg'],
        dialogTitle: 'Abrir',
        withData: true,
      );

      if (result != null) {
        arquivoUmCaminho = result.files.single.path;
        setState(() {
          _arquivoUmRecebeCaminho = arquivoUmCaminho!;
        });

        final arquivoUmDados = await File(_arquivoUmRecebeCaminho)
            .readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));

        setState(() {
          arquivoUmContent = arquivoUmDados;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Operação cancelada! Arquivo não selecionado!"),
          ),
        );
        setState(() {
          _arquivoUmRecebeCaminho = '';
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exception: $e'),
        ),
      );
      setState(() {
        _arquivoUmRecebeCaminho = '';
      });
    }
  }

  Future<void> abreArqDois() async {
    try {
      String? arquivoDoisCaminho = 'r/File/';
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['cfg'],
        dialogTitle: 'Abrir',
      );
      if (result != null) {
        arquivoDoisCaminho = result.files.single.path;
        setState(() {
          _arquivoDoisRecebeCaminho = arquivoDoisCaminho!;
        });

        final arquivoDoisDados = await File(_arquivoDoisRecebeCaminho)
            .readAsStringSync(encoding: const Latin1Codec(allowInvalid: true));

        setState(() {
          arquivoDoisContent = arquivoDoisDados;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Operação Cancelada! Arquivo não selecionado!"),
          ),
        );
        setState(() {
          _arquivoDoisRecebeCaminho = '';
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exception: $e'),
        ),
      );
      setState(() {
        _arquivoDoisRecebeCaminho = '';
      });
    }
  }

// Carrega tabelas
  Widget containerTabelas() {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double screen = 0;
    if ((heightScreen < 960) && (heightScreen > 760)) {
      screen = MediaQuery.of(context).size.height * 0.75;
    } else if ((heightScreen > 961)) {
      screen = MediaQuery.of(context).size.height * 0.8;
    } else if (heightScreen < 760) {
      screen = MediaQuery.of(context).size.height * 0.7;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: Container(
            height: screen,
            decoration: decoracaoContainer,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Container(
            height: screen,
            decoration: decoracaoContainer,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

// Primeiro Arquivo
  Widget arquivoUm() {
    return Flexible(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 30,
                width: 300,
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.archive),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: "Primeiro Arquivo",
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: estiloBotao,
              onPressed: () {
                abreArqUm();
              },
              child: const Text('Abrir'),
            ),
          ],
        ),
      ),
    );
  }

//Comprar Arquivos
  Widget botaoComparar() {
    return ElevatedButton(
      style: estiloBotao,
      onPressed: () {},
      child: const Text('Comparar'),
    );
  }

// Segundo Arquivo
  Widget arquivoDois() {
    return Flexible(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 30,
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.archive),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: "Segundo Arquivo",
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: estiloBotao,
              onPressed: () {
                abreArqDois();
              },
              child: const Text('Abrir'),
            ),
          ],
        ),
      ),
    );
  }

// Agrupa Widgets
  Widget componentesArquivo() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        arquivoUm(),
        Flexible(
          child: Container(
            alignment: Alignment.center,
            child: botaoComparar(),
          ),
        ),
        arquivoDois(),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

//Corpo da Tela
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const NomeTela(),
        const SizedBox(
          height: 20,
        ),
        componentesArquivo(),
        const SizedBox(
          height: 20,
        ),
        containerTabelas(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
