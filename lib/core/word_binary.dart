part of unscrambler;

/// A letter position independent representation of a word
///
/// The representation is a simple binary format using one bit per
/// letter occurence
///
///    a   = 00000001
///    aa  = 00000011
///    aaa = 00000111
///    ...
///
/// This allows us to check if we have enough letters, or are missing a letter
/// using the following operation
///
///     Given A is a letter of the first word,
///       B is the same letter of the second word
///       And that A and B are consecutive suites of bits
///
///     X = (B^A) & A
///
///     X is now a consecutive suite of bits, either 0, or the number of missing
///     letters offset to the left by the number of letters we already have.
///
///     if(X == 0) continue
///
///     M = 0b00000001
///
///     while(X & M != 1) X >>= 1
///
///     X is now a consecutive suite of bits aligned to the right
///
///     while(X & M == 1)
///       X >>= 1
///       Available Blanks - 1
///
///     if(Available Blanks < 0) We don't have enough letters to make this word
///
/// A [WordBinary] matches another if
/// - it is the same length, or bigger
/// - it has an equal or larger amount of each letter
/// - it has enough blanks to replace missing letters
///
/// A [WordBinary] is anagram to another if
/// - it is the same length (with blanks)
/// - it matches the other word
class WordBinary {
  /// Creates a string's binary representation
  WordBinary(this.word) : wordLen = word.length {
    segments = toBinary();
  }

  /// The string used to create this [WordBinary]
  final String word;

  /// The length of the given string, precomputed for later
  final int wordLen;

  /// The binary representation of the string, read [WordBinary] for details
  Uint8List segments;

  /// A [WordBinary] is anagram to another if
  /// - it is the same length (with blanks)
  /// - it matches the other word
  bool isAnagramOf(WordBinary other, int numBlanks) =>
      (other.wordLen + numBlanks == wordLen) &&
      _test(other.segments, numBlanks);

  /// A [WordBinary] matches another if
  /// - it is the same length, or bigger
  /// - it has an equal or larger amount of each letter
  /// - it has enough blanks to replace missing letters
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

  /// Creates the binary representation of the string,
  /// read [WordBinary] for details
  Uint8List toBinary() {
    // The signature is 32*8 (so 256) bits in order to fit into 2 SIMDs ops
    // The length can also be computed as the first element of the list
    final signature = Uint8List(32),
        units = word.toLowerCase().codeUnits,
        charFrequency = List<int>(26);

    for (var i = 0; i < wordLen; i++) {
      // Ascii -> decimal alphabetic order - 1
      final j = units[i] - 97;

      // The character frequency is counted in powers of 2
      // 2 = 00000010
      // 4 = 00000100
      // And so on. Only one bit is ever active for a given letter.
      if (charFrequency[j] == null) {
        charFrequency[j] = 2;
      } else {
        charFrequency[j] *= 2;
      }
    }

    // The length is the first element of the signature to compare it with SIMD
    signature[0] = wordLen;

    for (var i = 0; i < 26; i++) {
      // Substracting one will therefore flip all previous bits
      // 4 = 00000100  => 3 = 000000011
      // 2^2 = 4          2 bits are enabled.
      signature[i + 1] = (charFrequency[i] ?? 1) - 1;
    }

    return signature;
  }

  @override
  String toString() => word;
}
