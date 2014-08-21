part of unscrambler;

class Dictionary {
  
  static int INT_SIZE = 32; // INT bit size
  static int NUM_CHARS = 26; // alphabetical chars
  static int NUM_INT = (7 * 26) ~/ (INT_SIZE - (INT_SIZE % 7)) + 1; // amount of INT(size) needed per word
  
  final List<WordBinary> _structures = <WordBinary>[];
  
  Dictionary(String source, {int wordSize: -1}) {
    final String T = source.substring(0, 100);
    String splitChar;
    
    if (_isCleanSplit(T.split('\r'))) splitChar = '\r';
    if (_isCleanSplit(T.split('\n'))) splitChar = '\n';
    if (_isCleanSplit(T.split('\n\r'))) splitChar = '\n\r';
    if (_isCleanSplit(T.split('\r\n'))) splitChar = '\r\n';
    
    source.split(splitChar).forEach(
      (String W) {
        if (W.length > 0) addStructure(new WordBinary(W));
      }
    );
  }
  
  void addStructure(WordBinary S) {
    _structures.add(S);
  }
  
  bool _isCleanSplit(List<String> T) {
    if (T.length <= 1) return false;
    
    final String S = T[1];
    final int min = 97, max = 97 + Dictionary.NUM_CHARS;
    final int J = S.codeUnits.firstWhere(
      (int I) => (I < min || I >= max),
      orElse: () => null
    );
    
    return (J == null);
  }
  
  List<WordBinary> match(String W, int numBlanks) {
    final WordBinary S = new WordBinary(W);
    final List<WordBinary> allMatches = <WordBinary>[];
    final int len = _structures.length;
    WordBinary s;
    int i;
    
    for (i=0; i<len; i++) {
      s = _structures[i];
      
      if (s.matches(S, numBlanks)) allMatches.add(s);
    }
    
    return allMatches;
  }
  
  List<WordBinary> anagrams(String W, int numBlanks) {
    final WordBinary S = new WordBinary(W);
    final List<WordBinary> allMatches = <WordBinary>[];
    final int len = _structures.length;
    WordBinary s;
    int i;
    
    for (i=0; i<len; i++) {
      s = _structures[i];
      
      if (s.isAnagramOf(S, numBlanks)) allMatches.add(s);
    }
    
    return allMatches;
  }
}