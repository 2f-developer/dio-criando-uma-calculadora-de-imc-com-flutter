import 'pessoa.dart';

/// Separado de stdin/stdout para testar o mesmo fluxo usado pelo terminal.
int executarImc({
  required String? Function() lerLinha,
  required void Function(String) escrever,
  required void Function(String) escreverErro,
}) {
  String ler(String pergunta) {
    escrever(pergunta);
    final linha = lerLinha();
    if (linha == null) {
      throw const FormatException('Entrada encerrada antes de todos os dados.');
    }
    return linha.trim();
  }

  double numero(String valor, String campo) {
    final parsed = double.tryParse(valor.replaceAll(',', '.'));
    if (parsed == null) {
      throw FormatException(
        'Informe $campo como número, usando ponto ou vírgula.',
      );
    }
    return parsed;
  }

  try {
    final nome = ler('Nome:');
    final peso = numero(ler('Peso em kg:'), 'o peso');
    final altura = numero(ler('Altura em metros (ex.: 1,70):'), 'a altura');
    final pessoa = Pessoa(nome: nome, peso: peso, altura: altura);
    final resultado = pessoa.imc.toStringAsFixed(2).replaceAll('.', ',');
    escrever(
      'IMC de ${pessoa.nome}: $resultado kg/m² '
      '(${pessoa.classificacao.descricao})',
    );
    return 0;
  } on FormatException catch (erro) {
    escreverErro('Dados inválidos: ${erro.message}');
    return 64;
  } on ArgumentError catch (erro) {
    escreverErro('Dados inválidos: ${erro.message}');
    return 64;
  }
}
