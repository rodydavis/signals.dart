---
title: ConvertStatelessToSignalWidget
description: An IDE quick-fix refactoring tool (Dart Assist) that automatically converts a standard.
---

An IDE quick-fix refactoring tool (Dart Assist) that automatically converts a standard
<code>StatelessWidget</code> to extend the reactive **SignalWidget** instead.

<Success>
By extending <code>SignalWidget</code> instead of <code>StatelessWidget</code>, your widget automatically registers
fine-grained dependency tracking for any signals referenced within its <code>build</code> method. It
will rebuild automatically when their values change, removing the need for manual listener
code or wrapper components.
</Success>

### How to use
1. Place your cursor on the widget class declaration (e.g., <code>class MyWidget extends StatelessWidget</code>).
2. Click the lightbulb icon or press your IDE's quick-fix shortcut (<code>Alt+Enter</code> or <code>Cmd+.</code>).
3. Select the **Convert to SignalWidget** assist option.

### Examples

**Before:**
```dart
class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Count: ${counter.value}');
  }
}
```

**After (Apply Assist):**
```dart
class CounterDisplay extends SignalWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Count: ${counter.value}');
  }
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="convertstatelesstosignalwidget"></a><a name="convertstatelesstosignalwidget"></a>`ConvertStatelessToSignalWidget()`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="run"></a>`void run(CustomLintResolver resolver, ChangeReporter reporter, CustomLintContext context, SourceRange target)`

</details>
