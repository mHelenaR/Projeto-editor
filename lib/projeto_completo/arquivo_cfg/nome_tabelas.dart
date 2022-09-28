import 'package:editorconfiguracao/projeto_completo/edicao_arquivo/models/variaveis.dart';

Future<List<String>> nomeTabelasArquivo(String caminho) async {
  List<String> nomeTabelas = [];
  List<String> listaMenu = [];

  listaMenu.clear();
  var listaTIT = caminho.split('TIT ');

  int posicaoSeparador = 0;

  for (int i = 0; i < listaTIT.length; i++) {
    posicaoSeparador = listaTIT[i].indexOf('#');
    if (posicaoSeparador != -1) {
      nomeTabelas = [listaTIT[i].substring(0, posicaoSeparador)];
    }

    listaMenu = listaMenu + nomeTabelas;
  }

  // Passando a lista de tabelas para a gravação
  objArquivoGravacao.setTabelasConfigGR = listaMenu;

  return listaMenu;
}
