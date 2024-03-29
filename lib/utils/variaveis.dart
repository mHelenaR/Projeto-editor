import 'package:editorconfiguracao/models/edicao_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:editorconfiguracao/models/filtro_model.dart';
import 'package:editorconfiguracao/projeto_completo/arquivo_cfg/salvar_arquivo.dart';
import 'package:editorconfiguracao/projeto_completo/styles/style_colors_project.dart';

//String
String? opcaoEscolhida;
String recebeCaminhoArquivo = '';
String conteudoArquivo = '';
String separarArquivo = '';
String? caminhoArq;
String filtro = 'principal';

//double
double height = 0.0;
double width = 0.0;

//booleana
bool clicked = false;

//Listas
List<String> listaTIT = [];
List<String> nomeTabelas = [];
List<String> nomeColunas = [];
List<List<String>> nomeColunasDicionario = [];
List<String> nomeSubtituloDicionario = [];
List<String> recebeCPO = [];
List<String> celulaCPO = [];
List<PlutoRow> rows = [];
List<PlutoColumn> columns = [];
List<Tab> tabs = [];

List<dynamic> recebeMpa = [];
List<String> menuSubtitulo = [];

List<Map<String, dynamic>> listaMapaEstac = [];

//banco

//controle
final OpcaoFiltroModel objFiltroModel = OpcaoFiltroModel();
final EdicaoModel objEdicaoModel = EdicaoModel();
final EstacaoFiltroModel objEstacaoModel = EstacaoFiltroModel();
//final TextEditingController controleArquivo = TextEditingController();
final TextEditingController controlePesquisa = TextEditingController();

// Gerencia o estado da tabela
PlutoGridStateManager? stateManager;
late TabController tabController;

//Objetos
RecebeValor objArquivoGravacao = RecebeValor();
Logger logger = Logger();

//cores
Color cor = white;
