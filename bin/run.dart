import 'src/unscrambler.dart';

import 'dart:io';

void main() {
  String C = new File('sowpods.txt').readAsStringSync();
  
  Dictionary D = new Dictionary(C);
  
  for (int i=0; i<10; i++) bench(D);
  
  print(bench(D));
}

const List<int> LETTER_VALS = const <int>[1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10];

List<WordBinary> bench(Dictionary D) {
  final Stopwatch S = new Stopwatch()..start();
  
  final List<WordBinary> L = D.match('polymer', 1);
  // roh
  
  S.stop();
  print('${S.elapsedMilliseconds} ms');
  
  L.sort(
    (WordBinary A, WordBinary B) {
      final int vA = A.word.codeUnits.fold(0, (int P, int C) => P + LETTER_VALS[C - 97]);
      final int vB = B.word.codeUnits.fold(0, (int P, int C) => P + LETTER_VALS[C - 97]);
      
      return vB.compareTo(vA);
    }
  );
  
  return L;
}