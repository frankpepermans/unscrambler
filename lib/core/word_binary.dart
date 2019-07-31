part of unscrambler;

class WordBinary {
  WordBinary(this.word) : wordLen = word.length {
    segments = toBinary();
  }

  final String word;
  final int wordLen;

  Uint8List segments;

  bool isAnagramOf(WordBinary other, int numBlanks) =>
      (other.wordLen + numBlanks == wordLen) &&
      _test(other.segments, numBlanks);

  bool matches(WordBinary other, int numBlanks) =>
      (other.wordLen + numBlanks >= wordLen) &&
      _test(other.segments, numBlanks);

  bool _test(Uint8List other, int numBlanks) {
    var _availableBlanks = numBlanks;

    // Otherwise, check every letter
    for (var i = 1; i < 27; i++) {
      final _thisLetter = segments[i];
      final _otherLetter = other[i];

      // Mask off the bits of the letters we currently have
      // This leaves only N consecutive bits when we're missing N letters
      var _missingLetters = (_otherLetter ^ _thisLetter) & _thisLetter;

      // We have enough of this letter
      if (_missingLetters == 0) continue;

      // Here we assume that we will never encounter non-consecutive bits
      while (_missingLetters & 0x1 == 0) {
        _missingLetters >>= 1;
      }

      // Subtract a blank for every active bit
      while (_missingLetters & 0x1 != 0) {
        _missingLetters >>= 1;
        _availableBlanks--;
      }

      // If we can't, give up
      if (_availableBlanks < 0) return false;
    }

    // We have enough letters for everything
    return true;
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
