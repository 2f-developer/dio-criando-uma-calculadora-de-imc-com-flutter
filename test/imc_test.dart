import 'package:imc_console/aplicacao.dart';
import 'package:imc_console/classificacao.dart';
import 'package:imc_console/pessoa.dart';
import 'package:test/test.dart';

void main() {
  test('calcula sem arredondar a regra de domínio', () {
    final pessoa = Pessoa(nome: '  Ana  ', peso: 70, altura: 1.7);
    expect(pessoa.nome, 'Ana');
    expect(pessoa.imc, closeTo(24.221453287197235, 1e-12));
  });

  test('rejeita nome vazio e medidas inválidas', () {
    expect(() => Pessoa(nome: ' ', peso: 70, altura: 1.7), throwsArgumentError);
    for (final invalido in [0.0, -1.0, double.nan, double.infinity]) {
      expect(
        () => Pessoa(nome: 'Ana', peso: invalido, altura: 1.7),
        throwsArgumentError,
      );
      expect(
        () => Pessoa(nome: 'Ana', peso: 70, altura: invalido),
        throwsArgumentError,
      );
    }
  });

  test('rejeita overflow e underflow no cálculo', () {
    expect(
      () => Pessoa(nome: 'Ana', peso: 70, altura: 1e-200),
      throwsArgumentError,
    );
    expect(
      () => Pessoa(nome: 'Ana', peso: 70, altura: 1e200),
      throwsArgumentError,
    );
  });

  ({int codigo, List<String> saida, List<String> erros}) rodar(
    List<String> entrada,
  ) {
    final iterator = entrada.iterator;
    final saida = <String>[];
    final erros = <String>[];
    final codigo = executarImc(
      lerLinha: () => iterator.moveNext() ? iterator.current : null,
      escrever: saida.add,
      escreverErro: erros.add,
    );
    return (codigo: codigo, saida: saida, erros: erros);
  }

  test('lê três campos do terminal e aceita vírgula decimal', () {
    final resultado = rodar(['Ana', '70,0', '1,70']);
    expect(resultado.codigo, 0);
    expect(resultado.erros, isEmpty);
    expect(resultado.saida.last, 'IMC de Ana: 24,22 kg/m² (Peso normal)');
  });

  test('aceita ponto decimal', () {
    expect(rodar(['Ana', '70', '1.70']).codigo, 0);
  });

  test('retorna erro legível para texto no lugar de número', () {
    final resultado = rodar(['Ana', 'setenta', '1,70']);
    expect(resultado.codigo, 64);
    expect(resultado.erros.single, contains('Informe o peso como número'));
    expect(resultado.saida.any((s) => s.startsWith('IMC de')), isFalse);
  });

  test('captura erro do domínio sem mostrar stack trace', () {
    final resultado = rodar(['Ana', '70', '0']);
    expect(resultado.codigo, 64);
    expect(resultado.erros.single, contains('altura'));
    expect(resultado.saida.any((s) => s.startsWith('IMC de')), isFalse);
  });

  test('trata entrada incompleta e EOF', () {
    final resultado = rodar(['Ana']);
    expect(resultado.codigo, 64);
    expect(resultado.erros.single, contains('Entrada encerrada'));
  });

  test('classifica nas faixas da OMS, com limites inclusivos à esquerda', () {
    final casos = {
      15.99: ClassificacaoImc.magrezaGrave,
      16.0: ClassificacaoImc.magrezaModerada,
      17.0: ClassificacaoImc.magrezaLeve,
      18.5: ClassificacaoImc.normal,
      24.99: ClassificacaoImc.normal,
      25.0: ClassificacaoImc.sobrepeso,
      30.0: ClassificacaoImc.obesidadeGrau1,
      35.0: ClassificacaoImc.obesidadeGrau2,
      40.0: ClassificacaoImc.obesidadeGrau3,
    };
    casos.forEach((imc, esperada) {
      expect(ClassificacaoImc.de(imc), esperada, reason: 'IMC $imc');
    });
  });
}
