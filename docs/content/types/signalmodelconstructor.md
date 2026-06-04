---
title: "Type: SignalModelConstructor"
description: "API reference and details for SignalModelConstructor from signals.dart."
---

# SignalModelConstructor

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: SignalModelConstructor

A constructor for models that manages nested effects.

The model constructor starts capturing effects when called, storing them inside the returned [SignalModel](/types/signalmodel).

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final myModel = SignalModelConstructor(() => 'data');
final model = myModel();
print(model.value); // Prints: data
```

### Members of SignalModelConstructor

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **options** | <code>field</code> | <code>dart SignalModelOptions options</code> | Options used to configure this constructor. |
| **SignalModelConstructor** | <code>constructor</code> | <code>dart SignalModelConstructor(this._factory, {this.options = const SignalModelOptions()})</code> | Creates a new instance of [SignalModelConstructor](/types/signalmodelconstructor). |
| **call** | <code>method</code> | <code>dart SignalModel<T> call()</code> | Instantiates a new [SignalModel](/types/signalmodel) instance. |

## References

The **SignalModelConstructor** type is referenced and used in the following pages:

* [Model](/packages/signals_flutter/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [Model](/packages/signals_core/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [Model](/packages/signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [Model](/packages/preact_signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>

