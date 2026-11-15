import 'classificacao.dart';

/// Valores de peso em quilogramas e altura em metros.
class Pessoa {
  final String nome;
  final double peso;
  final double altura;

  Pessoa({required String nome, required this.peso, required this.altura})
    : nome = nome.trim() {
    if (this.nome.isEmpty) {
      throw ArgumentError('O nome não pode ficar vazio.');
    }
    if (!peso.isFinite || peso <= 0) {
      throw ArgumentError('O peso deve ser um número finito maior que zero.');
    }
    if (!altura.isFinite || altura <= 0) {
      throw ArgumentError('A altura deve ser um número finito maior que zero.');
    }
    if (!imc.isFinite || imc <= 0) {
      throw ArgumentError(
        'Peso ou altura fora do intervalo numérico suportado.',
      );
    }
  }

  double get imc => peso / (altura * altura);

  ClassificacaoImc get classificacao => ClassificacaoImc.de(imc);
}
