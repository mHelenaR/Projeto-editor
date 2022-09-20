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

  return listaMenu;
}
