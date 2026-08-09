---
title: "Type: StringSignalExtension"
description: "API reference and details for StringSignalExtension from signals.dart."
---

# StringSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: StringSignalExtension

```dart
extension StringSignalExtension on ReadonlySignal<String>
```

Helper extensions for [ReadonlySignal<String>](/types/readonlysignal)

### Members of StringSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **[]** | <code>method</code> | <code>dart String [](int index)</code> | The character (as a single-code-unit **String**) at the given **index**. |
| **codeUnitAt** | <code>method</code> | <code>dart int codeUnitAt(int index)</code> | Returns the 16-bit UTF-16 code unit at the given **index**. |
| **length** | <code>method</code> | <code>dart int length</code> | The length of the string. |
| **endsWith** | <code>method</code> | <code>dart bool endsWith(String other)</code> | Whether this string ends with **other**. |
| **startsWith** | <code>method</code> | <code>dart bool startsWith(Pattern pattern, [int index = 0])</code> | Whether this string starts with a match of **pattern**. |
| **indexOf** | <code>method</code> | <code>dart int indexOf(Pattern pattern, [int start = 0])</code> | Returns the position of the first match of **pattern** in this string, |
| **lastIndexOf** | <code>method</code> | <code>dart int lastIndexOf(Pattern pattern, [int? start])</code> | The starting position of the last match **pattern** in this string. |
| **isEmpty** | <code>method</code> | <code>dart bool isEmpty</code> | Whether this string is empty. |
| **isNotEmpty** | <code>method</code> | <code>dart bool isNotEmpty</code> | Whether this string is not empty. |
| **+** | <code>method</code> | <code>dart String +(String other)</code> | Creates a new string by concatenating this string with **other**. |
| **substring** | <code>method</code> | <code>dart String substring(int start, [int? end])</code> | The substring of this string from **start**, inclusive, to **end**, exclusive. |
| **trim** | <code>method</code> | <code>dart String trim()</code> | The string without any leading and trailing whitespace. |
| **trimLeft** | <code>method</code> | <code>dart String trimLeft()</code> | The string without any leading whitespace. |
| **trimRight** | <code>method</code> | <code>dart String trimRight()</code> | The string without any trailing whitespace. |
| ***** | <code>method</code> | <code>dart String *(int times)</code> | Creates a new string by concatenating this string with itself a number |
| **padLeft** | <code>method</code> | <code>dart String padLeft(int width, [String padding = ' '])</code> | Pads this string on the left if it is shorter than **width**. |
| **padRight** | <code>method</code> | <code>dart String padRight(int width, [String padding = ' '])</code> | Pads this string on the right if it is shorter than **width**. |
| **contains** | <code>method</code> | <code>dart bool contains(Pattern other, [int startIndex = 0])</code> | Whether this string contains a match of **other**. |
| **replaceFirst** | <code>method</code> | <code>dart String replaceFirst(Pattern from, String to, [int startIndex = 0])</code> | Creates a new string with the first occurrence of **from** replaced by **to**. |
| **replaceFirstMapped** | <code>method</code> | <code>dart String replaceFirstMapped(Pattern from, String Function(Match match) replace, [int startIndex = 0])</code> | Replace the first occurrence of **from** in this string. |
| **replaceAll** | <code>method</code> | <code>dart String replaceAll(Pattern from, String replace)</code> | Replaces all substrings that match **from** with **replace**. |
| **replaceAllMapped** | <code>method</code> | <code>dart String replaceAllMapped(Pattern from, String Function(Match match) replace)</code> | Replace all substrings that match **from** by a computed string. |
| **replaceRange** | <code>method</code> | <code>dart String replaceRange(int start, int? end, String replacement)</code> | Replaces the substring from **start** to **end** with **replacement**. |
| **split** | <code>method</code> | <code>dart List<String> split(Pattern pattern)</code> | Splits the string at matches of **pattern** and returns a list of substrings. |
| **splitMapJoin** | <code>method</code> | <code>dart String splitMapJoin(Pattern pattern, {String Function(Match)? onMatch, String Function(String)? onNonMatch})</code> | Splits the string, converts its parts, and combines them into a new |
| **codeUnits** | <code>method</code> | <code>dart List<int> codeUnits</code> | An unmodifiable list of the UTF-16 code units of this string. |
| **runes** | <code>method</code> | <code>dart Runes runes</code> | An **Iterable** of Unicode code-points of this string. |
| **toLowerCase** | <code>method</code> | <code>dart String toLowerCase()</code> | Converts all characters in this string to lower case. |
| **toUpperCase** | <code>method</code> | <code>dart String toUpperCase()</code> | Converts all characters in this string to upper case. |

## References

The **StringSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

