class FilterModel {
  final String? coluna;
  final String? estacao;
  final String? mensagem;
  final String? posicao;
  final String? tabela;
  final String? titulo;
  final String? unidade;
  final bool? dicionario;

  FilterModel({
    this.coluna,
    this.estacao,
    this.mensagem,
    this.posicao,
    this.tabela,
    this.titulo,
    this.unidade,
    this.dicionario,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
        coluna: json["coluna"],
        estacao: json["estacao"],
        mensagem: json["mensagem"],
        posicao: json["posicao"],
        tabela: json["tabela"],
        titulo: json["titulo"],
        unidade: json["unidade"],
        dicionario: json["dicionario"]);
  }

  static List<FilterModel> fromJsonList(List list) {
    return list.map((item) => FilterModel.fromJson(item)).toList();
  }
}

class OpcaoFiltroModel {
  dynamic _escolha;
  dynamic _tipoFiltro;

  get escolha => _escolha;
  set setEscolha(var escolha) {
    _escolha = escolha;
  }

  get tipoFiltro => _tipoFiltro;
  set settipoFiltro(var tipoFiltro) {
    _tipoFiltro = tipoFiltro;
  }
}

class EstacaoFiltroModel {
  dynamic _estacaoOpcao;
  dynamic _mapaEstacao;
  dynamic _estacaoNumero;
  dynamic _colunasFiltro;
  dynamic _colunasMapa;
  dynamic _colunaNome;
  dynamic _tabelasNome;

  //Filtro principal
  dynamic _colunasPrincipal;

  get estacaoOpcao => _estacaoOpcao;
  set setEstacaoOpcao(var estacaoOpcao) {
    _estacaoOpcao = estacaoOpcao;
  }

  get mapaEstacao => _mapaEstacao;
  set setMapaEstacao(var mapaEstacao) {
    _mapaEstacao = mapaEstacao;
  }

  get estacaoNumero => _estacaoNumero;
  set setEstacaoNumero(var estacaoNumero) {
    _estacaoNumero = estacaoNumero;
  }

  // Lista com o nome de todas as colunas da tabela Estac
  get colunasFiltro => _colunasFiltro;
  set setColunasFiltro(var colunasFiltro) {
    _colunasFiltro = colunasFiltro;
  }

  // == Recebe o nome de todas as colunas e suas posições na tabela Estac direto do config ==
  get colunasMapa => _colunasMapa;
  set setColunasMapa(var colunasMapa) {
    _colunasMapa = colunasMapa;
  }

  get colunaNome => _colunaNome;
  set setColunaNome(var colunaNome) {
    _colunaNome = colunaNome;
  }

  get tabelasNome => _tabelasNome;
  set setTabelasNome(var tabelasNome) {
    _tabelasNome = tabelasNome;
  }

  get colunasPrincipal => _colunasPrincipal;
  set setColunasPrincipal(var colunasPrincipal) {
    _colunasPrincipal = colunasPrincipal;
  }
}

enum FiltroOpcao {
  subTitulo,
  conteudo,
  titulo,
  estacao,
  mensagem;
}
