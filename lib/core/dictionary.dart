part of unscrambler;

class Dictionary {
  static int NUM_CHARS = 26; // alphabetical chars

  final _structures = <WordBinary>[];

  Dictionary(String source, {String delimiter}) {
    final String sample = source.substring(0, 100);
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
    for (final word in words) addStructure(WordBinary(word));
  }

  void addStructure(WordBinary S) => _structures.add(S);

  List<WordBinary> match(String W, int numBlanks) {
    final S = new WordBinary(W),
        allMatches = <WordBinary>[],
        len = _structures.length;
    WordBinary s;
    int i;

    for (i = 0; i < len; i++) {
      s = _structures[i];

      if (s.matches(S, numBlanks)) allMatches.add(s);
    }

    return allMatches;
  }

  List<WordBinary> anagrams(String W, int numBlanks) {
    final S = new WordBinary(W),
        allMatches = <WordBinary>[],
        len = _structures.length;
    WordBinary s;
    int i;

    for (i = 0; i < len; i++) {
      s = _structures[i];

      if (s.isAnagramOf(S, numBlanks)) allMatches.add(s);
    }

    return allMatches;
  }
}
