part of unscrambler;

class WordBinary {
  
  final String word;
  
  List<int> binary;
  int wordLen;
  
  WordBinary(this.word) {
    wordLen = word.length;
    
    binary = toBinary();
  }
  
  bool isAnagramOf(WordBinary other, int numBlanks) {
    if (other.wordLen + numBlanks != wordLen) return false;
    
    return matches(other, numBlanks);
  }
  
  bool matches(WordBinary other, int numBlanks) {
    if (other.wordLen + numBlanks < wordLen) return false;
    
    for (int i=0; i<Dictionary.NUM_INT; i++) {
      numBlanks = _test(binary[i], other.binary[i], numBlanks);
      
      if (numBlanks == -1) return false;
    }
    
    return true;
  }
  
  int _test(int O, int P, int numBlanks) {
    int M = (P ^ O) & O;
    
    if (M == 0) return numBlanks;
    else if (numBlanks == 0) return -1;
    
    int N;
    
    while (M > 0) {
      N = M & 0x7F;
      
      if (N > 0) {
        switch (N) {
          case 1: case 2: case 4: case 8: case 16: case 32: case 64: numBlanks -= 1; break;
          case 3: case 5: case 6: case 9: case 10: case 12: case 17: case 18: case 20: case 24: case 33: case 34: case 36: case 40: case 48: case 65: case 66: case 68: case 72: case 80: case 96: numBlanks -= 2; break;
          case 7: case 11: case 13: case 14: case 19: case 21: case 22: case 25: case 26: case 28: case 35: case 37: case 38: case 41: case 42: case 44: case 49: case 50: case 52: case 56: case 67: case 69: case 70: case 73: case 74: case 76: case 81: case 82: case 84: case 88: case 97: case 98: case 100: case 104: case 112: numBlanks -= 3; break;
          case 15: case 23: case 27: case 29: case 30: case 39: case 43: case 45: case 46: case 51: case 53: case 54: case 57: case 58: case 60: case 71: case 75: case 77: case 78: case 83: case 85: case 86: case 89: case 90: case 92: case 99: case 101: case 102: case 105: case 106: case 108: case 113: case 114: case 116: case 120: numBlanks -= 4; break;
          case 31: case 47: case 55: case 59: case 61: case 62: case 79: case 87: case 91: case 93: case 94: case 103: case 107: case 109: case 110: case 115: case 117: case 118: case 121: case 122: case 124: numBlanks -= 5; break;
          case 63: case 95: case 111: case 119: case 123: case 125: case 126: numBlanks -= 6; break;
          case 127: numBlanks -= 7; break;
        }
        
        if (numBlanks < 0) return -1;
      }
      
      M >>= 7;
    }
    
    return numBlanks;
  }
  
  List<int> toBinary() {
    final List<int> R = new List<int>(Dictionary.NUM_INT);
    final List<int> U = word.codeUnits;
    final List<int> B = new List<int>(Dictionary.NUM_CHARS);
    final int len = U.length;
    int i, j, k, l;
    
    for (i=0; i<len; i++) {
      j = U[i] - 97;
     
      if (B[j] == null) B[j] = 2;
      else B[j] *= 2;
    }
    
    for (i=j=k=l=0; i<Dictionary.NUM_CHARS; i++, k += 7) {
      if (k > Dictionary.INT_SIZE) {
        R[l++] = j;
        
        j = k = 0;
      }
      
      if (B[i] != null) j |= (B[i] - 1) << k;
    }
    
    R[l++] = j;
    
    return R;
  }
  
  String toString() => word;
}