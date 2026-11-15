# Calculadora de IMC no terminal

Calculadora de Índice de Massa Corporal escrita em Dart, feita para o desafio "Criando uma Calculadora de IMC com Flutter", da formação Flutter Specialist da DIO. Essa primeira etapa do desafio é toda em Dart puro, rodando no terminal; a versão com interface Flutter vem no desafio seguinte.

O programa pergunta nome, peso e altura, calcula o IMC e mostra a faixa correspondente da OMS:

```
$ dart run bin/imc_console.dart
Nome:
Ana
Peso em kg:
70
Altura em metros (ex.: 1,70):
1,70
IMC de Ana: 24,22 kg/m² (Peso normal)
```

Aceita vírgula ou ponto como separador decimal. Se algum dado vier errado (texto no lugar de número, peso zero, nome em branco, entrada interrompida), o programa explica o problema na saída de erro e termina com código 64, o código convencional para erro de uso.

## Como está organizado

- `lib/pessoa.dart`: a classe `Pessoa`, que valida os próprios dados no construtor. Não existe `Pessoa` com peso negativo ou altura zero.
- `lib/classificacao.dart`: as oito faixas de IMC da OMS para adultos.
- `lib/aplicacao.dart`: o fluxo de perguntas e respostas. Ele recebe as funções de leitura e escrita como parâmetro, e é isso que permite testar o programa inteiro sem terminal de verdade.
- `bin/imc_console.dart`: só liga esse fluxo ao `stdin` e ao `stdout`.

## Rodando os testes

```bash
dart pub get
dart test
```

Os testes cobrem o cálculo, as validações (inclusive `NaN`, infinito e valores que estourariam o `double`), as bordas de cada faixa da OMS e o fluxo completo pelo terminal, com entradas válidas e inválidas.
