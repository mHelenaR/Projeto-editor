import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/projeto_completo/style_project/style_colors.dart';

//String
String? opcaoEscolhida;
String recebeCaminhoArquivo = '';
String conteudoArquivo = '';
String separarArquivo = '';
String? caminhoArquivo;

//double
double height = 0.0;

//int

//booleana
bool clicked = false;

//Listas
List<String> listaTIT = [];
List<String> nomeTabelas = [];
List<String> listaMenu = [''];
List<String> separaTabelasArquivo = [];
List<String> nomeColSeparada = [];
List<String> nomeColunas = [];
List<String> arrayString = [''];
List<String> linhaCPO = [];
List<String> nomesTabelas = [];
List<String> teste2 = [];
List<String> teste3 = [];
List<String> teste4 = [];
List<String> teste5 = [];
List<String> gravaArquivo = ['inicio'];
List<PlutoRow> rows = [];
List<PlutoColumn> columns = [];
List<Tab> tabs = [];
final List<Widget> criarWidgets = [];

//controle
final TextEditingController controleArquivo = TextEditingController();
final TextEditingController controlePesquisa = TextEditingController();
late PlutoGridStateManager stateManager;
late TabController tabController;
var logger = Logger();

//cores
Color cor = white;

//Métodos
limpaListas() {
  nomeTabelas.clear();
  listaMenu.clear();
  separaTabelasArquivo.clear();
  nomeColSeparada.clear();
  nomeColunas.clear();
  arrayString.clear();
  linhaCPO.clear();
  nomesTabelas.clear();
  teste2.clear();
  teste3.clear();
  teste4.clear();
  teste5.clear();
  rows.clear();
  columns.clear();
}
