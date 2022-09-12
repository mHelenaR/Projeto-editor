// ignore_for_file: file_names
import 'package:flutter/material.dart';

styleBarraPesquisa(var cor) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: cor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    ),
    prefixIcon: const Icon(Icons.search),
    label: const Text("Pesquisar"),
  );
}

final styleBarraArquivo = InputDecoration(
  label: const Text("Arquivo de Configuração"),
  prefixIcon: const Icon(Icons.archive),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
  ),
);

final tFBancoConexao1 = InputDecoration(
  prefixIcon: const Icon(Icons.cloud_done),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
  ),
  labelText: 'HostName',
);

final tFBancoConexao2 = InputDecoration(
  prefixIcon: const Icon(Icons.cloud_circle),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
  ),
  labelText: 'Nome do Banco',
);

final tFBancoConexao3 = InputDecoration(
  prefixIcon: const Icon(Icons.cloud_circle),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
  ),
  labelText: 'Porta',
);

final tFBancoConexao4 = InputDecoration(
  prefixIcon: const Icon(Icons.cloud_circle),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
  ),
  labelText: 'Usuário',
);

final tFBancoConexao5 = InputDecoration(
  prefixIcon: const Icon(Icons.cloud_circle),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
  ),
  labelText: 'Senha',
);


 // final updatedText = controle.text + troca();
                  // controle.value = controle.value.copyWith(
                  //   text: updatedText,
                  //   selection:
                  //       TextSelection.collapsed(offset: updatedText.length),
                  // );
                 // controle.text = troca();