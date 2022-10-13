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

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.tabela} ${this.tabela}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(FilterModel model) {
    return this.campo == model.campo;
  }

  @override
  String toString() => campo!;
}
