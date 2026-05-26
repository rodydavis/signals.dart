---
title: SignalsAvoidDeprecatedSignalsMixin
description: A Dart static analysis rule that detects and warns against using the deprecated <code>SignalsMixin</code> in v7.
---

A Dart static analysis rule that detects and warns against using the deprecated <code>SignalsMixin</code> in v7.

<Warning>
In <code>signals</code> v7, <code>SignalsMixin</code> was deprecated to avoid unnecessary state tracking and
CPU/memory overhead. For optimal performance and a cleaner reactive codebase, you should
migrate to specialized widgets like **SignalWidget**, **SignalStatefulWidget**, or [SignalBuilder](/packages/signals/flutter/watch).
</Warning>

### Examples

**Incorrect:**
```dart
class MyWidget extends StatefulWidget with SignalsMixin { // LINT: Deprecated SignalsMixin
  @override
  Widget build(BuildContext context) {
    return Text('${counter.value}');
  }
}
```

**Correct (using SignalWidget):**
```dart
class MyWidget extends SignalWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('${counter.value}'); // OK: Rebuilds are handled implicitly and efficiently
  }
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalsavoiddeprecatedsignalsmixin"></a><a name="signalsavoiddeprecatedsignalsmixin"></a>`SignalsAvoidDeprecatedSignalsMixin()`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="run"></a>`void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context)`

</details>
