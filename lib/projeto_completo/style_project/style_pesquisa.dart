import 'package:flutter/material.dart';

final styleBarraPesquisa = InputDecoration(
  prefixIcon: const Icon(Icons.search),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
  ),
  labelText: 'Pesquisar',
);

final styleBarraArquivo = InputDecoration(
  prefixIcon: const Icon(Icons.archive),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
  ),
);
