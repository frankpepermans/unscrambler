import 'dart:io';

import 'package:unscrambler/unscrambler.dart';
import 'package:test/test.dart';

void main() {
  final C = new File('bin/sowpods.txt').readAsStringSync(),
      D = new Dictionary(C);

  test('', () {
    const expectedMatches = const <String>[
      'no',
      'nox',
      'noy',
      'ny',
      'on',
      'ony',
      'onyx',
      'ox',
      'oxy',
      'oy',
      'yo',
      'yon',
      'zo',
      'zzz'
    ],
        expectedAnagrams = const <String>[
      'batlets',
      'battels',
      'battles',
      'blatest',
      'tablets'
    ];
    final allMatches = D.match('zyxonzz', 0),
        allMatches2 = D.match('zyxonzz', 1),
        allMatches3 = D.match('zyxonzz', 2),
        allMatches4 = D.anagrams('battles', 0);

    expect(allMatches.length, 14);

    allMatches
        .forEach((bin) => expect(expectedMatches.contains(bin.word), true));

    expect(allMatches2.length, 192);
    expect(allMatches3.length, 1452);

    allMatches4.forEach(
        (WordBinary W) => expect(expectedAnagrams.contains(W.word), true));
  });
}
