import 'dart:io';

import 'package:unscrambler/unscrambler.dart';

void main() {
  final source = File('bin/sowpods.txt').readAsStringSync();

  final dictionary = Dictionary(source);

  // warmup
  for (var i = 0; i < 100; i++) {
    match(dictionary, 'battles', 1, log: false);
  }

  match(dictionary, 'battles', 0, log: true);
  match(dictionary, 'battles', 1, log: true);
  match(dictionary, 'battles', 2, log: true);
  match(dictionary, 'battles', 3, log: true);
  anagrams(dictionary, 'battles', 0, log: true);
}

const List<int> letterVals = <int>[
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

List<WordBinary> match(Dictionary dict, String value, int blanks, {bool log}) {
  final watch = Stopwatch();

  if (log) watch.start();

  final wordList = dict.match(value, blanks);

  if (log) {
    watch.stop();
    print(
      'MATCH => scramble:"$value" '
      'blanks:[$blanks], '
      'elapsed:${watch.elapsedMilliseconds} ms',
    );
  }

  int foldChars(int prev, int char) => prev + letterVals[char - 97];

  wordList.sort((a, b) {
    final vA = a.word.codeUnits.fold(0, foldChars),
        vB = b.word.codeUnits.fold(0, foldChars);

    return vB.compareTo(vA);
  });

  return wordList;
}

List<WordBinary> anagrams(
  Dictionary dict,
  String value,
  int blanks, {
  bool log,
}) {
  final watch = Stopwatch();

  if (log) watch.start();

  final wordList = dict.anagrams(value, blanks);

  if (log) {
    watch.stop();
    print(
      'ANAGRAMS => scramble:"$value" '
      'blanks:[$blanks], '
      'elapsed:${watch.elapsedMilliseconds} ms',
    );
  }

  int foldChars(int prev, int char) => prev + letterVals[char - 97];

  wordList.sort((a, b) {
    final vA = a.word.codeUnits.fold(0, foldChars),
        vB = b.word.codeUnits.fold(0, foldChars);

    return vB.compareTo(vA);
  });

  return wordList;
}
