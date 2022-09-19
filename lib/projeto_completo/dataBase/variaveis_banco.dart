import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ControllerBanco {
  //Construtor
  ControllerBanco();

  final _ctUserDataBase = TextEditingController();
  final _ctHostDataBase = TextEditingController();
  final _ctPasswordDataBase = TextEditingController();
  final _ctPortDataBase = TextEditingController();
  final _ctNameDataBase = TextEditingController();

  TextEditingController get usuarioBanco => _ctUserDataBase;
  TextEditingController get hostBanco => _ctHostDataBase;
  TextEditingController get senhaBanco => _ctPasswordDataBase;
  TextEditingController get portaBanco => _ctPortDataBase;
  TextEditingController get nomeBanco => _ctNameDataBase;
}

String? path;
bool? atualizaBanco;

var recebeCaminhoDB = "";
var recebe = "";

var databaseConnection = PostgreSQLConnection('', 0, '');
var databaseFactory = databaseFactoryFfi;
