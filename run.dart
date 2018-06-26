import 'dart:io';

import 'package:unscrambler/unscrambler.dart';

void main() {
  final String C = new File('bin/sowpods.txt').readAsStringSync();

  Dictionary D = new Dictionary(C);

  // warmup
  for (int i = 0; i < 100; i++) match(D, 'battles', 1, false);

  print(match(D, 'battles', 0, true));
  print(match(D, 'battles', 1, true));
  print(match(D, 'battles', 2, true));
  print(match(D, 'battles', 3, true));
  //print(anagrams(D, 'battles', 0, true));
}

const List<int> LETTER_VALS = const <int>[
  1,
  3,
  3,
  2,
  1,
  4,
  2,
  4,
  1,
  8,
  5,
  1,
  3,
  1,
  1,
  3,
  10,
  1,
  1,
  1,
  1,
  4,
  4,
  8,
  4,
  10
];

List<WordBinary> match(Dictionary D, String V, int N, bool printReport) {
  Stopwatch S;

  if (printReport) S = new Stopwatch()..start();

  final List<WordBinary> L = D.match(V, N);
  // roh

  if (printReport) {
    S.stop();
    print(
        'MATCH => scramble:"$V" blanks:[$N], elapsed:${S.elapsedMilliseconds} ms');
  }

  L.sort((WordBinary A, WordBinary B) {
    final int vA =
        A.word.codeUnits.fold(0, (int P, int C) => P + LETTER_VALS[C - 97]);
    final int vB =
        B.word.codeUnits.fold(0, (int P, int C) => P + LETTER_VALS[C - 97]);

    return vB.compareTo(vA);
  });

  return L;
}

List<WordBinary> anagrams(Dictionary D, String V, int N, bool printReport) {
  final Stopwatch S = new Stopwatch()..start();

  final List<WordBinary> L = D.anagrams(V, N);
  // roh

  S.stop();
  print('${S.elapsedMilliseconds} ms');

  L.sort((WordBinary A, WordBinary B) {
    final int vA =
        A.word.codeUnits.fold(0, (int P, int C) => P + LETTER_VALS[C - 97]);
    final int vB =
        B.word.codeUnits.fold(0, (int P, int C) => P + LETTER_VALS[C - 97]);

    return vB.compareTo(vA);
  });

  return L;
}
