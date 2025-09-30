import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<Pattern>]
extension PatternSignalExtension on ReadonlySignal<Pattern> {
  /// Matches this pattern against the string repeatedly.
  ///
  /// If [start] is provided, matching will start at that index.
  ///
  /// The returned iterable lazily finds non-overlapping matches
  /// of the pattern in the [string].
  /// If a user only requests the first match,
  /// this function should not compute all possible matches.
  ///
  /// The matches are found by repeatedly finding the first match
  /// of the pattern in the string, initially starting from [start],
  /// and then from the end of the previous match (but always
  /// at least one position later than the *start* of the previous
  /// match, in case the pattern matches an empty substring).
  /// ```dart
  /// RegExp exp = RegExp(r'(\w+)');
  /// var str = 'Dash is a bird';
  /// Iterable<Match> matches = exp.allMatches(str, 8);
  /// for (final Match m in matches) {
  ///   String match = m[0]!;
  ///   print(match);
  /// }
  /// ```
  /// The output of the example is:
  /// ```
  /// a
  /// bird
  /// ```
  Iterable<Match> allMatches(String string, [int start = 0]) =>
      value.allMatches(string, start);

  /// Matches this pattern against the start of `string`.
  ///
  /// Returns a match if the pattern matches a substring of [string]
  /// starting at [start], and `null` if the pattern doesn't match
  /// at that point.
  ///
  /// The [start] must be non-negative and no greater than `string.length`.
  /// ```dart
  /// final string = 'Dash is a bird';
  ///
  /// var regExp = RegExp(r'bird');
  /// var match = regExp.matchAsPrefix(string, 10); // Match found.
  ///
  /// regExp = RegExp(r'bird');
  /// match = regExp.matchAsPrefix(string); // null
  /// ```
  Match? matchAsPrefix(String string, [int start = 0]) =>
      value.matchAsPrefix(string, start);
}

/// Extensions for [Pattern]
extension SignalPatternExtensions on Pattern {
  /// Return a signal from a Pattern value
  Signal<Pattern> get $ => signal<Pattern>(this);
}
