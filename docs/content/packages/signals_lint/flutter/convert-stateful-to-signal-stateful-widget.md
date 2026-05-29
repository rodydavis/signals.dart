---
title: ConvertStatefulToSignalStatefulWidget
description: An IDE quick-fix refactoring tool (Dart Assist) that automatically converts a standard.
---

An IDE quick-fix refactoring tool (Dart Assist) that automatically converts a standard
<code>StatefulWidget</code> to extend the reactive [SignalStatefulWidget](/types/signalstatefulwidget) instead.

<Success>
By extending <code>SignalStatefulWidget</code> instead of <code>StatefulWidget</code>, your widget state automatically
registers fine-grained dependency tracking for any signals referenced within its <code>build</code> method. It
will rebuild automatically when their values change, removing the need for manual listener
lifecycle management or <code>setState</code> calls.
</Success>

### How to use
1. Place your cursor on the widget class declaration (e.g., <code>class MyWidget extends StatefulWidget</code>).
2. Click the lightbulb icon or press your IDE's quick-fix shortcut (<code>Alt+Enter</code> or <code>Cmd+.</code>).
3. Select the **Convert to SignalStatefulWidget** assist option.

### Examples

**Before:**
```dart
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}
```

**After (Apply Assist):**
```dart
class CounterWidget extends SignalStatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="convertstatefultosignalstatefulwidget"></a><a name="convertstatefultosignalstatefulwidget"></a><code>ConvertStatefulToSignalStatefulWidget()</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="run"></a><code>void run(CustomLintResolver resolver, ChangeReporter reporter, CustomLintContext context, SourceRange target)</code>

</details>
