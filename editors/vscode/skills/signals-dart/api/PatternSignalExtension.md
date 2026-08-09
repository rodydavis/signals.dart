# extension `PatternSignalExtension`

Helper extensions for [ReadonlySignal<Pattern>](/types/readonlysignal)

---

## Members of `PatternSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **allMatches** | `method` | `Iterable<Match> allMatches(String string, [int start = 0])` | Matches this pattern against the string repeatedly.

If **start** is provided, matching will start at that index.

The returned iterable lazily finds non-overlapping matches
of the pattern in the **string**.
If a user only requests the first match,
this function should not compute all possible matches.

The matches are found by repeatedly finding the first match
of the pattern in the string, initially starting from **start**,
and then from the end of the previous match (but always
at least one position later than the *start* of the previous
match, in case the pattern matches an empty substring).
```dart
RegExp exp = RegExp(r'(\w+)');
var str = 'Dash is a bird';
Iterable<Match> matches = exp.allMatches(str, 8);
for (final Match m in matches) {
  String match = m[0]!;
  print(match);
}
```
The output of the example is:
```
a
bird
``` |
| **matchAsPrefix** | `method` | `Match? matchAsPrefix(String string, [int start = 0])` | Matches this pattern against the start of <code>string</code>.

Returns a match if the pattern matches a substring of **string**
starting at **start**, and <code>null</code> if the pattern doesn't match
at that point.

The **start** must be non-negative and no greater than <code>string.length</code>.
```dart
final string = 'Dash is a bird';

var regExp = RegExp(r'bird');
var match = regExp.matchAsPrefix(string, 10); // Match found.

regExp = RegExp(r'bird');
match = regExp.matchAsPrefix(string); // null
``` |
