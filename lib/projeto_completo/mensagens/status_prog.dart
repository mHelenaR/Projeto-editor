enum StatusProgram {
  // erros
  errorLoading(message: 'Erro no arquivo: '),
  errorOperation(message: 'Operação cancelada!'),
  errorArchive(message: 'Erro no arquivo: '),
  errorChangedFile(message: 'Arquivo não alterado:'),
  errorSaveArchive(message: 'Falha ao salvar: '),

  // aviso
  warningLoading(message: 'Aviso carregamento'),

  // sucesso
  successLoading(message: 'Arquivo carregado com sucesso!'),
  successWarning(message: 'Sucesso!');

  const StatusProgram({required this.message});
  final String message;
}

// extension SelectMessage on StatusProgram {
//   String get nome => describeEnum(this);

//   String get displayTitle {
//     switch (this) {
//       case StatusProgram.errorLoading:
//         return 'Carregando';

//       default:
//         return 'teste default';
//     }
//   }
// }
