---
title: MigrateWatchToSignalBuilder
description: An IDE quick-fix refactoring tool (Dart Assist) that automatically migrates a positional or named.
---

An IDE quick-fix refactoring tool (Dart Assist) that automatically migrates a positional or named
<code>Watch</code> constructor call to use the modern, type-safe [SignalBuilder](/packages/signals/flutter/watch) component.

:::important
The <code>Watch</code> widget was updated and aligned under the standard [SignalBuilder](/packages/signals/flutter/watch) paradigm in v7.
This automated refactoring quick-fix updates your positional widget structure to a type-safe
<code>SignalBuilder(builder: (context) => ...)</code> signature seamlessly.
:::

### How to use
1. Place your cursor on the <code>Watch</code> constructor call.
2. Click the lightbulb icon or press your IDE's quick-fix shortcut (<code>Alt+Enter</code> or <code>Cmd+.</code>).
3. Select the **Migrate Watch to SignalBuilder** assist option.

### Examples

**Before:**
```dart
Widget build(BuildContext context) {
  return Watch((context) => Text('${counter.value}')); // LINT: Positional Watch
}
```

**After (Apply Assist):**
```dart
Widget build(BuildContext context) {
  return SignalBuilder(builder: (context) => Text('${counter.value}')); // OK
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="migratewatchtosignalbuilder"></a><a name="migratewatchtosignalbuilder"></a>`MigrateWatchToSignalBuilder()`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="run"></a>`void run(CustomLintResolver resolver, ChangeReporter reporter, CustomLintContext context, SourceRange target)`

</details>
