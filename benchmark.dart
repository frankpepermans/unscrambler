import 'dart:io';

import 'package:unscrambler/unscrambler.dart';

import 'package:benchmark_harness/benchmark_harness.dart';

void main() => TemplateBenchmark.main();

class TemplateBenchmark extends BenchmarkBase {
  TemplateBenchmark() : super('Template');

  Dictionary dictionary;

  static void main() => TemplateBenchmark().report();

  @override
  List<WordBinary> run() => dictionary.match('polymer', 0);

  @override
  void setup() {
    final source = File('bin/sowpods.txt').readAsStringSync();

    dictionary = Dictionary(source);
  }
}
