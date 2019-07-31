part of unscrambler;

class Dictionary {
  Dictionary(String source, {String delimiter}) {
    final sample = source.substring(0, 100);
    String split;

    if (delimiter != null) {
      split = delimiter;
    } else {
      //Go from the least likely encoding to the most likely,
      //and from the longest to the shortest
      if (sample.contains('\n\r')) split = '\n\r'; // Almost unheard of
      if (sample.contains('\r\n')) split = '\r\n'; // Windows line endings
      if (sample.contains('\r')) split = '\r'; // Last seen on OS-9
      if (sample.contains('\n')) split = '\n'; // UNIX line endings
    }

    final words = source.split(split);
    for (final word in words) {
      if (word != '') {
        addStructure(WordBinary(word));
      }
    }
  }

  final _structures = <WordBinary>[];

  void addStructure(WordBinary word) => _structures.add(word);

  List<WordBinary> match(String word, int numBlanks) {
    final wordBinary = WordBinary(word),
        allMatches = <WordBinary>[],
        len = _structures.length;

    for (var i = 0; i < len; i++) {
      final s = _structures[i];
      if (s.matches(wordBinary, numBlanks)) allMatches.add(s);
    }

    return allMatches;
  }

  List<WordBinary> anagrams(String word, int numBlanks) {
    final wordBinary = WordBinary(word),
        allMatches = <WordBinary>[],
        len = _structures.length;

    for (var i = 0; i < len; i++) {
      final s = _structures[i];

      if (s.isAnagramOf(wordBinary, numBlanks)) allMatches.add(s);
    }

    return allMatches;
  }
}
