import 'dart:io';

import 'package:unscrambler/unscrambler.dart';

void main() {
  /// Fetch the English words dictionary file
  final allWords = new File('bin/sowpods.txt').readAsStringSync(),
      dictionary = new Dictionary(allWords);

  /// let's define a Scrabble play state:
  /// We have 7 letters, 6 of those are random, 1 is blank (wildcard)
  const rndLetters = 'paenxd', numWildcards = 1;
  final allWordMatches = dictionary.match(rndLetters, numWildcards);

  /// now we only care for words that are 7 letters large
  print(allWordMatches.where((bin) => bin.word.length >= 7));

  /// yields (expands, spandex)

  /// you can also list all anagrams of any given word:
  print(dictionary.anagrams('battles', 0));

  /// yields [batlets, battels, battles, blatest, tablets]
}
