---
title: SignalsAvoidDeprecatedWatchExtension
description: A Dart static analysis rule that detects and warns against using the deprecated.
---

A Dart static analysis rule that detects and warns against using the deprecated
<code>.watch(context)</code> and <code>.unwatch(context)</code> extension methods in v7.

<Warning>
The <code>.watch(context)</code> extension was deprecated in <code>signals</code> v7 due to performance concerns
and unexpected side effects with Flutter's build lifecycle. Using it can trigger unnecessary
widget rebuilds. In v7, you must migrate to specialized reactive components like
<a href="/types/signalbuilder">SignalBuilder</a>, <a href="/types/signalwidget">SignalWidget</a>, or <a href="/types/signalstatefulwidget">SignalStatefulWidget</a>.
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

<details>
<summary> View Constructors </summary>

##### <a name="signalsavoiddeprecatedwatchextension"></a><a name="signalsavoiddeprecatedwatchextension"></a><code>SignalsAvoidDeprecatedWatchExtension()</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="run"></a><code>void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context)</code>

</details>
