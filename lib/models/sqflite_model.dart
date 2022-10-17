class SqfliteModel {
  late List<dynamic> _tabelasCompletas;
  late List<dynamic> _nomeColunasDcn;

  // Encapsulamento
  get tabelasCompletas => _tabelasCompletas;
  set setTabelasCompletas(value) => _tabelasCompletas = value;

  get nomeColunasDcn => _nomeColunasDcn;
  set setnomeColunasDcn(value) => _nomeColunasDcn = value;
}
