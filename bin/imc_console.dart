import 'dart:convert';
import 'dart:io';

import 'package:imc_console/aplicacao.dart';

void main() {
  exitCode = executarImc(
    lerLinha: () => stdin.readLineSync(encoding: utf8),
    escrever: stdout.writeln,
    escreverErro: stderr.writeln,
  );
}
