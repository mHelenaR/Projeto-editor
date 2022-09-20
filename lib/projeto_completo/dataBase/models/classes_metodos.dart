import 'package:editorconfiguracao/projeto_completo/dataBase/controllers/variaveis.dart';
import 'package:flutter/material.dart';

// Métodos
reiniciaObjeto(var objeto) {
  return objeto = null;
}

debugInfoBase() {
  debugPrint(
    "${objControlBase.hostBanco.text}\n${objControlBase.portaBanco.text}\n${objControlBase.nomeBanco.text}\n${objControlBase.usuarioBanco.text}\n${objControlBase.senhaBanco.text}",
  );
}

// Classes
class ControllerBanco {
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
