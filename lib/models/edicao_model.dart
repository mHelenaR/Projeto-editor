import 'package:flutter/material.dart';

class testeClass {
  dynamic _tabelas;
  dynamic _separadas;
  dynamic _criaTabela;
  dynamic _testeTab;

  get tabelas => _tabelas;
  set setTabelas(var tabelas) {
    _tabelas = tabelas;
  }

  get separadasEnter => _separadas;
  set setSeparadasEnter(var separadas) {
    _separadas = separadas;
  }

  get criaTabela => _criaTabela;
  set setcriaTabela(var criaTabela) {
    _criaTabela = criaTabela;
  }

  get testeTab => _testeTab;
  set setTesteTab(var testeTab) {
    _testeTab = testeTab;
  }
}

class EdicaoModel {
  dynamic _ativaTabelas;
  List<Map<dynamic, dynamic>> _mapaNomeColunas = [];
  List<dynamic> _listaMapasAlteracao = [];

  get ativaTabelas => _ativaTabelas;
  set setAtivaTabelas(var ativaTabelas) {
    _ativaTabelas = ativaTabelas;
  }

  get mapaNomeColunas => _mapaNomeColunas;
  set setMapaNomeColunas(var mapaNomeColunas) {
    _mapaNomeColunas = mapaNomeColunas;
  }

  get getListaMapasAlteracao => _listaMapasAlteracao;
  set setListaMapasAlteracao(var listaMapasAlteracao) {
    _listaMapasAlteracao = listaMapasAlteracao;
  }
}
