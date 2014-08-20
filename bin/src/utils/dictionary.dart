part of unscrambler;

class Dictionary {
  
  static int NUM_CHARS = 26;
  static int NUM_BITS = 26 * 7;
  static int NUM_INT32 = (NUM_BITS / 32).ceil();
  
  final List<WordBinary> _structures = <WordBinary>[];
  
  Dictionary(String source, {int wordSize: -1}) {
    source.split('\n').forEach(
      (String W) {
        if (W.length > 0) addStructure(new WordBinary(W));
      }
    );
  }
  
  void addStructure(WordBinary S) {
    _structures.add(S);
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
  
  List<WordBinary> anagrams(String W) {
    final WordBinary S = new WordBinary(W);
    final List<WordBinary> allMatches = <WordBinary>[];
    final int len = _structures.length;
    WordBinary s;
    int i;
    
    for (i=0; i<len; i++) {
      s = _structures[i];
      
      if (s.binary == S.binary) allMatches.add(s);
    }
    
    return allMatches;
  }
  
  String toString() {
    final StringBuffer S = new StringBuffer();
    final int len = _structures.length, len2 = len-1;
    WordBinary s;
    int i;
    
    for (i=0; i<len; i++) {
      s = _structures[i];
      
      S.write('${s.word},${s.binary}${(i < len2) ? ',' : ''}');
    }
    
    return S.toString();
  }
}