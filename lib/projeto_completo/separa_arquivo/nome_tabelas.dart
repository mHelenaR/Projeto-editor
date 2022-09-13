import 'package:editorconfiguracao/projeto_completo/separa_arquivo/converte_arquivo.dart';

// Future<List<String>> nomeTabelasArquivo(String caminhoArquivo) async {
//   List<String> erro = [];

//   List<String> nomeTabelas = [];
//   List<String> listaMenu = [];
//   List<String> lista = [];

//   String diretorio = await converteArquivo(caminhoArquivo);
//   var listaTIT = diretorio.split('TIT ');
//   int posicaoSeparador = 0;

//   for (int i = 0; i < listaTIT.length; i++) {
//     posicaoSeparador = listaTIT[i].indexOf('#');
//     if (posicaoSeparador != -1) {
//       nomeTabelas = [listaTIT[i].substring(0, posicaoSeparador)];
//     } else {
//       nomeTabelas = [];
//     }

//     listaMenu = listaMenu + nomeTabelas;
//   }

//   lista = listaMenu;

//   return lista;
// }
Future<List<String>> nomeTabelasArquivo(String teste) async {
  List<String> erro = [];

  List<String> nomeTabelas = [];
  List<String> listaMenu = [];
  List<String> lista = [];

  var listaTIT = await teste.split('TIT ');
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
