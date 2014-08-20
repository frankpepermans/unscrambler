import 'package:unscrambler/unscrambler.dart';

import 'package:benchmark_harness/benchmark_harness.dart';

import 'dart:io';

void main() => TemplateBenchmark.main();

class TemplateBenchmark extends BenchmarkBase {
  
  Dictionary D;
  
  TemplateBenchmark() : super("Template");

  static void main() => new TemplateBenchmark().report();
  
  List<WordBinary> run() => D.match('polymer', 0);

  void setup() {
    final String C = new File('bin/sowpods.txt').readAsStringSync();
    
    D = new Dictionary(C);
  }
}