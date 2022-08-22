import 'package:file_picker/file_picker.dart';

Future<String> arquivoGeraBanco() async {
  String recebe;
  FilePickerResult? caminhoArquivo = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: ['cfg'],
    dialogTitle: 'Escolha o arquivo para gerar o banco',
    withData: true,
  );
  if (caminhoArquivo != null) {
    recebe = caminhoArquivo.files.single.path!;
    return recebe;
  } else {
    return "erro";
  }
}
