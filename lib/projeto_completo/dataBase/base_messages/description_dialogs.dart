import 'package:flutter/material.dart';

Widget descricaoErroCriacao(var caminho) {
  return Text(
      "O arquivo criado já existe no diretório: ${caminho}\nDeseja atualizar as tabelas?");
}

const msgSuccessConnect = Text("Conexão realizada com sucesso!!");
