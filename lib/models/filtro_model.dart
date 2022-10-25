class FilterModel {
  final String? tabela;
  final String? coluna;
  final String? titulo;
  final String? mensagem;
  final String? estacao;

  FilterModel({
    this.tabela,
    this.coluna,
    this.titulo,
    this.mensagem,
    this.estacao,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      tabela: json["tabela"],
      coluna: json["coluna"],
      titulo: json["titulo"],
      mensagem: json["mensagem"],
      estacao: json["estacao"],
    );
  }

  static List<FilterModel> fromJsonList(List list) {
    return list.map((item) => FilterModel.fromJson(item)).toList();
  }
}

class FilterEstacModel {
  final String? unidade;
  final String? estacao;
  final String? posicao;
  final String? coluna;

  FilterEstacModel({
    this.unidade,
    this.estacao,
    this.posicao,
    this.coluna,
  });

  factory FilterEstacModel.fromJson(Map<String, dynamic> json) {
    return FilterEstacModel(
      unidade: json['unidade'],
      estacao: json['estacao'],
      posicao: json['posicao'],
      coluna: json['coluna'],
    );
  }

  static List<FilterEstacModel> fromJsonList(List list) {
    return list.map((item) => FilterEstacModel.fromJson(item)).toList();
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
}

enum FiltroOpcao {
  subTitulo,
  conteudo,
  titulo,
  estacao,
  mensagem;
}
