part of unscrambler;

class Dictionary {
  static int INT_SIZE = 32; // INT bit size
  static int NUM_CHARS = 26; // alphabetical chars
  static int NUM_INT = (7 * 26) ~/ (INT_SIZE - (INT_SIZE % 7)) +
      1; // amount of INT(size) needed per word

  final _structures = <WordBinary>[];

  Dictionary(String source) {
    final String T = source.substring(0, 100);
    String splitChar;

    if (_isCleanSplit(T.split('\r'))) splitChar = '\r';
    if (_isCleanSplit(T.split('\n'))) splitChar = '\n';
    if (_isCleanSplit(T.split('\n\r'))) splitChar = '\n\r';
    if (_isCleanSplit(T.split('\r\n'))) splitChar = '\r\n';

    source.split(splitChar).forEach((word) {
      if (word.isNotEmpty) addStructure(new WordBinary(word));
    });
  }

  void addStructure(WordBinary S) => _structures.add(S);

  bool _isCleanSplit(List<String> T) {
    if (T.length <= 1) return false;

    final S = T[1],
        min = 97,
        max = 97 + Dictionary.NUM_CHARS,
        J = S.codeUnits.firstWhere((unit) => unit < min || unit >= max,
            orElse: () => null);

    return J == null;
  }

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
