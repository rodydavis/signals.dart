---
title: "Type: SignalModel"
description: "API reference and details for SignalModel from signals.dart."
---

# SignalModel

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: SignalModel

A premium wrapper for cohesive state packages constructed with [createModel](/types/createmodel).

It holds the instanced model **value** and all the [Effect](/types/effect)s that were captured
during its construction. Disposing the [SignalModel](/types/signalmodel) automatically disposes of all
nested/captured effects, completely avoiding memory leaks.

### Premium Pattern: Dart 3+ Extension Type Wrappers
To avoid unchecked subscript access like <code>model['count'].value</code>, wrap your model in an extension type:

```dart
extension type TypeSafeCounter(SignalModel<Map<String, dynamic>> _model) {
  int get count => (_model['count'] as Signal<int>).value;
  set count(int val) => (_model['count'] as Signal<int>).value = val;
  void increment() => (_model['increment'] as Function)();
  void dispose() => _model.dispose();
}
```

### Members of SignalModel

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **value** | <code>field</code> | <code>dart T value</code> | The instanced model value. |
| **options** | <code>field</code> | <code>dart SignalModelOptions options</code> | Options used to configure this model. |
| **SignalModel** | <code>constructor</code> | <code>dart SignalModel(this.value, this._effects, {this.options = const SignalModelOptions()})</code> | Creates a new model instance. |
| **[]** | <code>method</code> | <code>dart dynamic [](Object? key)</code> | Access properties dynamically if the underlying **value** is a **Map**. |
| **[]=** | <code>method</code> | <code>dart void []=(dynamic key, dynamic val)</code> | Set properties dynamically if the underlying **value** is a **Map**. |
| **call** | <code>method</code> | <code>dart T call()</code> | Returns the **value** of this model. Alias for [.value] |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> | Disposes of all captured effects. |

## References

The **SignalModel** type is referenced and used in the following pages:

* [Model](/packages/signals_flutter/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [Model](/packages/signals_core/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [Model](/packages/signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [Model](/packages/preact_signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

