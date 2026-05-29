# class `SignalOptions`

Configuration options for a [Signal](/types/signal).

Extends [ReadonlySignalOptions](/types/readonlysignaloptions) to also support custom **equality** checkers,
which control whether incoming values trigger update events.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final items = signal(
  [1, 2, 3],
  options: SignalOptions(
    name: 'item-list',
    equality: SignalEquality.deep(),
    watched: () => print('Items watch active'),
    unwatched: () => print('Items watch inactive'),
  ),
);
```

---

## Members of `SignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **equalityCheck** | `method` | `SignalEquality<T> equalityCheck` | Get the active equality check |
| **SignalOptions** | `constructor` | `SignalOptions({super.name, super.watched, super.unwatched, SignalEquality<T>? equality})` | Creates a new [SignalOptions](/types/signaloptions) instance. |
| **copyWith** | `method` | `SignalOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
