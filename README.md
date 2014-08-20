unscrambler
===========

Dart scrabble word unscrambler, for use in word games (i.e. Scrabble) or as an int32 benchmark reference.

Unscrambler requires a word list, sowpods is included (official Scrabble word list, over 200000 words).

The program will preprocess each word and convert it into a list of int32 values.

To find matches, it will then run over all word int32 values and find matches using only 2 bitwise operations.

The algo is quite fast, on my machine it can find all matching words for a given scrambled word in about 4ms.

[![Build Status](https://drone.io/github.com/frankpepermans/unscrambler/status.png)](https://drone.io/github.com/frankpepermans/unscrambler/latest)

Try It Now
-----------
Add the unscramble package to your pubspec.yaml file:

```yaml
dependencies:
  unscramble: any
```

Usage
-----
```
  void main() {
    final String V = 'stbalet'; // scrambled word
    final int numBlanks = 0; // Scrabble blank letters
    final String C = new File('bin/sowpods.txt').readAsStringSync(); // word list
    final Dictionary D = new Dictionary(C);
    
    print(match(D, V, numBlanks)); // all matches
    print(anagrams(D, V)); // all anagrams of the same word length
  }
```
