---
title: WrapWithSignalBuilder
description: An IDE quick-fix refactoring tool (Dart Assist) that automatically wraps any.
---

An IDE quick-fix refactoring tool (Dart Assist) that automatically wraps any
instantiated widget expression inside a [SignalBuilder](/types/signalbuilder) component.

<Success>
Wrapping a widget inside <code>SignalBuilder(builder: (context) => ...)</code> optimizes rebuilding
performance by confining redraws strictly to the smallest possible sub-tree whenever
reactive signals read inside the builder change.
</Success>

### How to use
1. Place your cursor on any widget constructor call (e.g., <code>Text('...')</code>).
2. Click the lightbulb icon or press your IDE's quick-fix shortcut (<code>Alt+Enter</code> or <code>Cmd+.</code>).
3. Select the **Wrap with SignalBuilder** assist option.

### Examples

**Before (Cursor on <code>Text</code> constructor):**
```dart
Widget build(BuildContext context) {
  return Text('Counter: ${counter.value}');
}
```

**After (Apply Assist):**
```dart
Widget build(BuildContext context) {
  return SignalBuilder(builder: (context) => Text('Counter: ${counter.value}'));
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="wrapwithsignalbuilder"></a><a name="wrapwithsignalbuilder"></a>`WrapWithSignalBuilder()`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="run"></a>`void run(CustomLintResolver resolver, ChangeReporter reporter, CustomLintContext context, SourceRange target)`

</details>
