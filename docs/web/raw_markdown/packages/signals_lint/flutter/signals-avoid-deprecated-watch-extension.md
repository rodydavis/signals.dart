---
title: SignalsAvoidDeprecatedWatchExtension
description: A Dart static analysis rule that detects and warns against using the deprecated.
---

A Dart static analysis rule that detects and warns against using the deprecated
`.watch(context)` and `.unwatch(context)` extension methods in v7.

<Warning>
The `.watch(context)` extension was deprecated in `signals` v7 due to performance concerns
and unexpected side effects with Flutter's build lifecycle. Using it can trigger unnecessary
widget rebuilds. In v7, you must migrate to specialized reactive components like
[SignalBuilder](/packages/signals/flutter/watch), **SignalWidget**, or **SignalStatefulWidget**.
</Warning>

### Examples

**Incorrect:**
```dart
@override
Widget build(BuildContext context) {
  final value = counter.watch(context); // LINT: Deprecated watch extension
  return Text('$value');
}
```

**Correct:**
```dart
@override
Widget build(BuildContext context) {
  return SignalBuilder(
    builder: (context) => Text('${counter.value}'), // OK
  );
}
```


### Constructors

##### <a name="signalsavoiddeprecatedwatchextension"></a><a name="signalsavoiddeprecatedwatchextension"></a>`SignalsAvoidDeprecatedWatchExtension()`


### Methods

##### <a name="run"></a>`void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context)`
