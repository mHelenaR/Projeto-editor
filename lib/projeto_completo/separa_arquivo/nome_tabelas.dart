import 'package:editorconfiguracao/projeto_completo/separa_arquivo/converte_arquivo.dart';

Future<List<String>> nomeTabelasArquivo(String teste) async {
  List<String> nomeTabelas = [];
  List<String> listaMenu = [];

  String diretorio = await converteArquivo(teste);
  var listaTIT = diretorio.split('TIT ');
  listaMenu.clear();

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
