class FilterModel {
  final String? tabela;
  final String? campo;
  final String? titulo;
  final String? mensagem;

  FilterModel({this.tabela, this.campo, this.titulo, this.mensagem});

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      tabela: json["tabela"],
      campo: json["campo"],
      titulo: json["titulo"],
      mensagem: json["mensagem"],
    );
  }

  static List<FilterModel> fromJsonList(List list) {
    return list.map((item) => FilterModel.fromJson(item)).toList();
  }
}

class OpcaoFiltro {
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
