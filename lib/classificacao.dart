/// Faixas de IMC para adultos segundo a Organização Mundial da Saúde.
enum ClassificacaoImc {
  magrezaGrave('Magreza grave'),
  magrezaModerada('Magreza moderada'),
  magrezaLeve('Magreza leve'),
  normal('Peso normal'),
  sobrepeso('Sobrepeso'),
  obesidadeGrau1('Obesidade grau I'),
  obesidadeGrau2('Obesidade grau II'),
  obesidadeGrau3('Obesidade grau III');

  const ClassificacaoImc(this.descricao);

  final String descricao;

  /// Os limites são inclusivos à esquerda: 18,5 já é peso normal, 25 já é sobrepeso.
  factory ClassificacaoImc.de(double imc) => switch (imc) {
    < 16 => magrezaGrave,
    < 17 => magrezaModerada,
    < 18.5 => magrezaLeve,
    < 25 => normal,
    < 30 => sobrepeso,
    < 35 => obesidadeGrau1,
    < 40 => obesidadeGrau2,
    _ => obesidadeGrau3,
  };
}
