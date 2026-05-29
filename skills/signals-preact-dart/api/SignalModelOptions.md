# class `SignalModelOptions`

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

---

## Members of `SignalModelOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **name** | `field` | `String? name` | The name or debug label of the model. |
| **wrapInAction** | `field` | `bool wrapInAction` | Whether to automatically wrap returned Map functions in actions.
Defaults to true. |
| **SignalModelOptions** | `constructor` | `SignalModelOptions({this.name, this.wrapInAction = true})` | Creates a new instance of [SignalModelOptions](/types/signalmodeloptions). |
| **copyWith** | `method` | `SignalModelOptions copyWith({String? name, bool? wrapInAction})` | Copy options with new values. |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
