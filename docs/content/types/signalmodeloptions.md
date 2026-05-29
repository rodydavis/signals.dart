---
title: "Type: SignalModelOptions"
description: "API reference and details for SignalModelOptions from signals.dart."
---

# SignalModelOptions

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: SignalModelOptions

Options for configuring a [SignalModel](/types/signalmodel).

Provides configuration for debug labeling (**name**) and whether to automatically wrap Map functions
in transaction-safe, batched actions (**wrapInAction**).

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final options = const SignalModelOptions(
  name: 'user-profile-model',
  wrapInAction: true,
);
```

### Members of SignalModelOptions

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **name** | <code>field</code> | <code>dart String? name</code> | The name or debug label of the model. |
| **wrapInAction** | <code>field</code> | <code>dart bool wrapInAction</code> | Whether to automatically wrap returned Map functions in actions. |
| **SignalModelOptions** | <code>constructor</code> | <code>dart SignalModelOptions({this.name, this.wrapInAction = true})</code> | Creates a new instance of [SignalModelOptions](/types/signalmodeloptions). |
| **copyWith** | <code>method</code> | <code>dart SignalModelOptions copyWith({String? name, bool? wrapInAction})</code> | Copy options with new values. |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **SignalModelOptions** type is referenced and used in the following pages:

* [Model](/packages/signals_flutter/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [Model](/packages/signals_core/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [Model](/packages/signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [Model](/packages/preact_signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

