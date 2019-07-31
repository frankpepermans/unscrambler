import 'dart:io';

import 'package:unscrambler/unscrambler.dart';
import 'package:test/test.dart';

void main() {
  final source = new File('bin/sowpods.txt').readAsStringSync(),
      dictionary = new Dictionary(source);

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
    final allMatches = dictionary.match('zyxonzz', 0),
        allMatches2 = dictionary.match('zyxonzz', 1),
        allMatches3 = dictionary.match('zyxonzz', 2),
        allMatches4 = dictionary.anagrams('battles', 0);

    print(allMatches.map<String>((v) => v.word).toList());

    expect(allMatches.length, 14);

    allMatches
        .forEach((bin) => expect(expectedMatches.contains(bin.word), true));

    expect(allMatches2.length, 192);

    expect(allMatches3.length, 1452);

    allMatches4.forEach(
        (WordBinary W) => expect(expectedAnagrams.contains(W.word), true));
  });
}
