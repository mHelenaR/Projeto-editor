import 'package:editorconfiguracao/projeto_completo/variaveis_globais/variaveis_program.dart';
import 'package:editorconfiguracao/utils/variaveis.dart';

// passa para o objeto  um mapa com a posicao e o nome da coluna da tabela estac
void mapaEstacColuna(var nomeTabelas, var nomeColunas) {
  List<Map<String, dynamic>> mapaColEstacao = [];
  List<String> listaColunasEstac = [];

  for (var i = 0; i < nomeTabelas.length; i++) {
    if (nomeTabelas[i] == 'estac') {
      for (var j = 0; j < nomeColunas.length; j++) {
        mapaColEstacao.addAll([
          {
            'estac/${nomeColunas[j]}': {
              'posicao': j.toString(),
              'nomeColuna': nomeColunas[j],
            }
          }
        ]);

        listaColunasEstac.addAll([nomeColunas[j]]);
      }
    }
  }

  // mapa com o nome e a posição das colunas do config
  objEstacaoModel.setColunasMapa = mapaColEstacao;

  // lista com o nome das colunas do config
  objEstacaoModel.setColunasFiltro = listaColunasEstac;
}

//************ Transforma a String para comparar com o dicionario ************
List<String> transformaString(List<String> listaColunasARQ) {
  List<String> lista = [];
  List<String> cols = listaColunasARQ[0].split('|');

  //retira o espaço em branco no final da linha
  int cont = cols.length - 2;

  for (var i = 0; i < cols.length; i++) {
    if (i <= cont) {
      String neww = cols[i];
      String valor = neww.substring(0, neww.length - 2);

      String upper = valor.toUpperCase();
      lista = lista + [upper];
    }
  }

  return lista;
}

// passa para o objeto um mapa com o número das estações, sua posição e unidade
void mapaEstacRowPosicao(int i, List<String> listaCelula) {
  List<String> numerosEstacao = [];
  String estacCodigo = '';

  String estacUnidade = '';
  //Ex:
  /** 001/009:
         *      unidade : 001
         *      estacao : 009
         *      posicao : 8
        */

  for (int k = 0; k < listaCelula.length; k++) {
    if (nomeColunas[k] == 'est_unidade01') {
      estacUnidade = listaCelula[k];

      numerosEstacao.addAll([listaCelula[k]]);
    } else if (nomeColunas[k] == 'est_codigo01') {
      estacCodigo = listaCelula[k];

      listaMapaEstac.addAll([
        {
          "$estacUnidade/$estacCodigo": {
            'unidade': estacUnidade,
            'estacao': estacCodigo,
            'posicao': i.toString(),
          }
        }
      ]);
    }
  }
}
/* Diminui o length da celula para o  mapa de alteração de celula no grid */

metodoContador(int valor, var tabela) {
  int contador = valor + 1;
  if (contador == tabela.length) {
    return contador = contador - 1;
  } else {
    return contador;
  }
}

// Retorna um boleano para as celulas ativas e desativas

leitura(var lista, var contador) {
  int col = lista.length - 1;
  if (contador == col) {
    return true;
  } else {
    return false;
  }
}
// retorna uma lista de dados da tabela dicionario

retornaCombo(String opcao) {
  List<String> retorno = [];
  Map listaa = {};
  List<Map<dynamic, dynamic>> lista = objSqlite.tabelasCompletas;
  for (var i = 0; i < lista.length; i++) {
    listaa = lista[i];
    for (var element in listaa.entries) {
      retorno.addAll([element.value[opcao]]);
    }
  }
  return retorno;
}
