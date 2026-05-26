---
title: SignalsAvoidCreateInBuildMethod
description: A Dart lint rule that checks and reports instances where a signal or computed.
---

A Dart lint rule that checks and reports instances where a signal or computed
variable is created directly inside Flutter's `build(BuildContext context)` method.

<Warning>
Creating a signal inside the build method is a severe reactive anti-pattern.
On every widget rebuild, a brand new signal instance is created, resetting its value
and breaking state persistence. This can lead to bugs, infinite rebuild loops, and
high memory consumption.
</Warning>

### Examples

**Incorrect:**
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = signal(0); // LINT: Created in build() method
    return Text('${counter.value}');
  }
}
```

**Correct:**
```dart
class MyWidget extends StatelessWidget {
  // Define signals outside the build method (e.g. as a field, in an InheritedWidget, or global)
  final counter = signal(0);

  @override
  Widget build(BuildContext context) {
    return Text('${counter.value}');
  }
}
```

### How to suppress
If you have a highly specific edge case and need to ignore this lint, you can suppress it by adding
a line-level comment:
```dart
// ignore: signals_avoid_create_in_build_method
final mySignal = signal(42);
```


### Constructors

##### <a name="signalsavoidcreateinbuildmethod"></a><a name="signalsavoidcreateinbuildmethod"></a>`SignalsAvoidCreateInBuildMethod()`


### Methods

##### <a name="run"></a>`void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context)`
