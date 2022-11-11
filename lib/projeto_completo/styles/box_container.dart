import 'package:editorconfiguracao/projeto_completo/styles/style_container.dart';
import 'package:flutter/material.dart';

BoxDecoration? boxSelecao1(var opcao) {
  if (opcao == "estacao") {
    return containerOpSelecionada;
  } else {
    return containerOp;
  }
}

BoxDecoration? boxSelecao2(var opcao) {
  if (opcao == "conteudo") {
    return containerOpSelecionada;
  } else {
    return containerOp;
  }
}

BoxDecoration? boxSelecao3(var opcao) {
  if (opcao == "subTitulo") {
    return containerOpSelecionada;
  } else {
    return containerOp;
  }
}

BoxDecoration? boxSelecao4(var opcao) {
  if (opcao == "mensagem") {
    return containerOpSelecionada;
  } else {
    return containerOp;
  }
}
