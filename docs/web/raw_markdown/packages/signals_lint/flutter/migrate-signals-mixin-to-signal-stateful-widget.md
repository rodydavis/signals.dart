---
title: MigrateSignalsMixinToSignalStatefulWidget
description: An IDE quick-fix refactoring tool (Dart Assist) that automatically migrates a deprecated.
---

An IDE quick-fix refactoring tool (Dart Assist) that automatically migrates a deprecated
`SignalsMixin` usage on a `State` class to extend the reactive **SignalStatefulWidget** instead.

:::important
Since `SignalsMixin` is deprecated in `signals` v7, this automated quick-fix does two things:
1. Removes `SignalsMixin` from your State class's `with` clause.
2. Changes the parent widget class's superclass from `StatefulWidget` to `SignalStatefulWidget`.
This results in a cleaner, highly optimized codebase that runs with zero unnecessary overhead.
:::

### How to use
1. Place your cursor on the `SignalsMixin` name in the State's class signature.
2. Click the lightbulb icon or press your IDE's quick-fix shortcut (`Alt+Enter` or `Cmd+.`).
3. Select the **Migrate SignalsMixin to SignalStatefulWidget** assist option.

### Examples

**Before:**
```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SignalsMixin { // LINT: Deprecated SignalsMixin
  @override
  Widget build(BuildContext context) {
    return Text('${counter.value}');
  }
}
```

**After (Apply Assist):**
```dart
class MyWidget extends SignalStatefulWidget {
  const MyWidget({super.key});
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Text('${counter.value}'); // OK
  }
}
```


### Constructors

##### <a name="migratesignalsmixintosignalstatefulwidget"></a><a name="migratesignalsmixintosignalstatefulwidget"></a>`MigrateSignalsMixinToSignalStatefulWidget()`


### Methods

##### <a name="run"></a>`void run(CustomLintResolver resolver, ChangeReporter reporter, CustomLintContext context, SourceRange target)`
