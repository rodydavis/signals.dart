---
title: MigrateSignalsMixinToSignalStatefulWidget
description: An IDE quick-fix refactoring tool (Dart Assist) that automatically migrates a deprecated.
---

An IDE quick-fix refactoring tool (Dart Assist) that automatically migrates a deprecated
<code>SignalsMixin</code> usage on a <code>State</code> class to extend the reactive **SignalStatefulWidget** instead.

:::important
Since <code>SignalsMixin</code> is deprecated in <code>signals</code> v7, this automated quick-fix does two things:
1. Removes <code>SignalsMixin</code> from your State class's <code>with</code> clause.
2. Changes the parent widget class's superclass from <code>StatefulWidget</code> to <code>SignalStatefulWidget</code>.
This results in a cleaner, highly optimized codebase that runs with zero unnecessary overhead.
:::

### How to use
1. Place your cursor on the <code>SignalsMixin</code> name in the State's class signature.
2. Click the lightbulb icon or press your IDE's quick-fix shortcut (<code>Alt+Enter</code> or <code>Cmd+.</code>).
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

<details>
<summary> View Constructors </summary>

##### <a name="migratesignalsmixintosignalstatefulwidget"></a><a name="migratesignalsmixintosignalstatefulwidget"></a>`MigrateSignalsMixinToSignalStatefulWidget()`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="run"></a>`void run(CustomLintResolver resolver, ChangeReporter reporter, CustomLintContext context, SourceRange target)`

</details>
