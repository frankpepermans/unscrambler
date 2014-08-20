unscrambler
===========

Dart scrabble word unscrambler, for use in word games (i.e. Scrabble) or as an int32 benchmark reference.

Unscrambler requires a word list, sowpods is included (official Scrabble word list, over 200000 words).

The program will preprocess each word and convert it into a list of int32 values.

To find matches, it will then run over all word int32 values and find matches using only 2 bitwise operations.

The algo is quite fast, on my machine it can find all matching words for a given scrambled word in about 4ms.
