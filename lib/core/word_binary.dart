part of unscrambler;

class WordBinary {
  WordBinary(this.word) : wordLen = word.length {
    segments = toBinary();
  }

  final String word;
  final int wordLen;

  List<int> segments;

  bool isAnagramOf(WordBinary other, int numBlanks) {
    if (other.wordLen + numBlanks != wordLen) return false;

    return matches(other, numBlanks);
  }

  bool matches(WordBinary other, int numBlanks) {
    var n = numBlanks;

    if (other.wordLen + n < wordLen) return false;

    for (int i = 0; i < Dictionary.NUM_INT; i++) {
      n = _test(segments[i], other.segments[i], n);

      if (n == -1) return false;
    }

    return true;
  }

  int _test(int sA, int sB, int numBlanks) {
    var n = numBlanks;

    if (sA == 0) return n;

    int M = (sB ^ sA) & sA;

    if (M == 0)
      return n;
    else if (n == 0) return -1;

    for (int N; M > 0; M >>= 7) {
      N = M & 0x7F;

      if (N > 0) {
        switch (N) {
          case 1:
          case 2:
          case 4:
          case 8:
          case 16:
          case 32:
          case 64:
            n -= 1;
            break;
          case 3:
          case 5:
          case 6:
          case 9:
          case 10:
          case 12:
          case 17:
          case 18:
          case 20:
          case 24:
          case 33:
          case 34:
          case 36:
          case 40:
          case 48:
          case 65:
          case 66:
          case 68:
          case 72:
          case 80:
          case 96:
            n -= 2;
            break;
          case 7:
          case 11:
          case 13:
          case 14:
          case 19:
          case 21:
          case 22:
          case 25:
          case 26:
          case 28:
          case 35:
          case 37:
          case 38:
          case 41:
          case 42:
          case 44:
          case 49:
          case 50:
          case 52:
          case 56:
          case 67:
          case 69:
          case 70:
          case 73:
          case 74:
          case 76:
          case 81:
          case 82:
          case 84:
          case 88:
          case 97:
          case 98:
          case 100:
          case 104:
          case 112:
            n -= 3;
            break;
          case 15:
          case 23:
          case 27:
          case 29:
          case 30:
          case 39:
          case 43:
          case 45:
          case 46:
          case 51:
          case 53:
          case 54:
          case 57:
          case 58:
          case 60:
          case 71:
          case 75:
          case 77:
          case 78:
          case 83:
          case 85:
          case 86:
          case 89:
          case 90:
          case 92:
          case 99:
          case 101:
          case 102:
          case 105:
          case 106:
          case 108:
          case 113:
          case 114:
          case 116:
          case 120:
            n -= 4;
            break;
          case 31:
          case 47:
          case 55:
          case 59:
          case 61:
          case 62:
          case 79:
          case 87:
          case 91:
          case 93:
          case 94:
          case 103:
          case 107:
          case 109:
          case 110:
          case 115:
          case 117:
          case 118:
          case 121:
          case 122:
          case 124:
            n -= 5;
            break;
          case 63:
          case 95:
          case 111:
          case 119:
          case 123:
          case 125:
          case 126:
            n -= 6;
            break;
          case 127:
            n -= 7;
            break;
        }

        if (n < 0) return -1;
      }
    }

    return n;
  }

  Uint8List toBinary() {
    // The signature is 32*8 (so 256) bits in order to fit into 2 SIMDs operations
    // The length can also be computed as the first element of the list
    final Signature = Uint8List(32),
        Units = word.toLowerCase().codeUnits,
        CharFrequency = new List<int>(26),
        len = Units.length;

    for (var i = 0; i < len; i++) {
      // Ascii -> decimal alphabetic order - 1
      final j = Units[i] - 97;

      // The character frequency is counted in powers of 2
      // 2 = 00000010
      // 4 = 00000100
      // And so on. Only one bit is ever active for a given letter.
      if (CharFrequency[j] == null)
        CharFrequency[j] = 2;
      else
        CharFrequency[j] *= 2;
    }

    // The length is the first element of the signature to compare it with SIMD
    Signature[0] = len;

    for (var i = 0; i < 26; i++) {
      // Substracting one will enable all of the bits before the currently active one
      // 4 = 00000100  => 3 = 000000011
      // 2^2 = 4          2 bits are enabled.
      Signature[i + 1] = (CharFrequency[i] ?? 1) - 1;
    }

    return Signature;
  }

  @override
  String toString() => word;
}
