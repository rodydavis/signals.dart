---
title: WrapWithSignalBuilder
description: An IDE quick-fix refactoring tool (Dart Assist) that automatically wraps any.
---

An IDE quick-fix refactoring tool (Dart Assist) that automatically wraps any
instantiated widget expression inside a [SignalBuilder](/packages/signals/flutter/watch) component.

<Success>
Wrapping a widget inside `SignalBuilder(builder: (context) => ...)` optimizes rebuilding
performance by confining redraws strictly to the smallest possible sub-tree whenever
reactive signals read inside the builder change.
</Success>

### How to use
1. Place your cursor on any widget constructor call (e.g., `Text('...')`).
2. Click the lightbulb icon or press your IDE's quick-fix shortcut (`Alt+Enter` or `Cmd+.`).
3. Select the **Wrap with SignalBuilder** assist option.

### Examples

**Before (Cursor on `Text` constructor):**
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

##### <a name="wrapwithsignalbuilder"></a><a name="wrapwithsignalbuilder"></a>`WrapWithSignalBuilder()`


### Methods

##### <a name="run"></a>`void run(CustomLintResolver resolver, ChangeReporter reporter, CustomLintContext context, SourceRange target)`
