import 'dart:io';

import 'package:unscrambler/unscrambler.dart';

import 'package:benchmark_harness/benchmark_harness.dart';

void main() => TemplateBenchmark.main();

class TemplateBenchmark extends BenchmarkBase {
  
  Dictionary D;
  
  TemplateBenchmark() : super('Template');

  static void main() => new TemplateBenchmark().report();

  @override
  List<WordBinary> run() => D.match('polymer', 0);

  @override
  void setup() {
    final String C = new File('bin/sowpods.txt').readAsStringSync();
    
    D = new Dictionary(C);
  }
}