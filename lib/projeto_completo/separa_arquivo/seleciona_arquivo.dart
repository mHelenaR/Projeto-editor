import 'package:file_picker/file_picker.dart';

Future<String> arquivoGeraBanco() async {
  String recebe;
  FilePickerResult? caminhoArquivo = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: ['cfg'],
    dialogTitle: 'Escolha um arquivo de configuração para gerar o banco',
    withData: true,
  );
  if (caminhoArquivo != null) {
    recebe = caminhoArquivo.files.single.path!;
    return recebe;
  } else {
    return "erro";
  }
}

Future<String> arquivoTabela() async {
  String recebe;
  FilePickerResult? caminhoArquivo = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    initialDirectory: 'C:/frente',
    allowedExtensions: ['cfg'],
    dialogTitle: 'Escolha o arquivo de configuração',
    withData: true,
  );
  if (caminhoArquivo != null) {
    recebe = caminhoArquivo.files.single.path!;

    return recebe;
  } else {
    return "erro";
  }
}
