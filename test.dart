import 'package:unscrambler/unscrambler.dart';
import 'package:unittest/unittest.dart';

import 'dart:io';

void main() {
  final String V = 'battles';
  final int numBlanks = 0;
  final String C = new File('bin/sowpods.txt').readAsStringSync();
  final Dictionary D = new Dictionary(C);
  
  test('', () {
    final List<String> expectedMatches = const <String>['no', 'nox', 'noy', 'ny', 'on', 'ony', 'onyx', 'ox', 'oxy', 'oy', 'yo', 'yon', 'zo', 'zzz'];
    final List<String> expectedAnagrams = const <String>['batlets', 'battels', 'battles', 'blatest', 'tablets'];
    final List<WordBinary> allMatches = D.match('zyxonzz', 0);
    final List<WordBinary> allMatches2 = D.match('zyxonzz', 1);
    final List<WordBinary> allMatches3 = D.match('zyxonzz', 2);
    final List<WordBinary> allMatches4 = D.anagrams('battles');
    
    expect(allMatches.length, 14);
    
    allMatches.forEach(
      (WordBinary W) => expect(expectedMatches.contains(W.word), true)    
    );
    
    expect(allMatches2.length, 192);
    expect(allMatches3.length, 1452);
    
    allMatches4.forEach(
      (WordBinary W) => expect(expectedAnagrams.contains(W.word), true)    
    );
  });
}