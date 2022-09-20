import 'package:editorconfiguracao/projeto_completo/dataBase/models/classes_metodos.dart';
import 'package:postgres/postgres.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// String
String? path;
String recebeCaminhoDB = "";
String recebe = "";

// Booleano
bool? atualizaBanco;

// Objetos
ControllerBanco objControlBase = ControllerBanco();

// Dynamic
dynamic criaObjeto;

// DataBase
var databaseConnection = PostgreSQLConnection('', 0, '');
var databaseFactory = databaseFactoryFfi;
