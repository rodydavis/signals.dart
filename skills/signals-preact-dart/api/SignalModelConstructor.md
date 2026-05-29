# class `SignalModelConstructor`

A constructor for models that manages nested effects.

The model constructor starts capturing effects when called, storing them inside the returned [SignalModel](/types/signalmodel).

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final myModel = SignalModelConstructor(() => 'data');
final model = myModel();
print(model.value); // Prints: data
```

---

## Members of `SignalModelConstructor`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **options** | `field` | `SignalModelOptions options` | Options used to configure this constructor. |
| **SignalModelConstructor** | `constructor` | `SignalModelConstructor(this._factory, {this.options = const SignalModelOptions()})` | Creates a new instance of [SignalModelConstructor](/types/signalmodelconstructor). |
| **call** | `method` | `SignalModel<T> call()` | Instantiates a new [SignalModel](/types/signalmodel) instance. |
