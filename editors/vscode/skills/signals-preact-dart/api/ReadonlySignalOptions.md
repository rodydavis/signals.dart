# class `ReadonlySignalOptions`

Configuration options for a [ReadonlySignal](/types/readonlysignal).

Allows intercepting the signal's active subscription state changes
via **watched** and **unwatched** callback event listeners. This is extremely useful
for initiating or canceling active background fetching, web sockets, or timer loops.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final stockTicker = signal(
  0.0,
  options: ReadonlySignalOptions(
    name: 'stock-ticker',
    watched: () => print('Stock Ticker is actively being listened to!'),
    unwatched: () => print('No more listeners, sleeping the ticker.'),
  ),
);
```

---

## Members of `ReadonlySignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **watched** | `field` | `void Function()? watched` | Callback called when the signal goes from 0 to >=1 listeners. |
| **unwatched** | `field` | `void Function()? unwatched` | Callback called when the signal goes from >=1 to 0 listeners. |
| **ReadonlySignalOptions** | `constructor` | `ReadonlySignalOptions({super.name, this.watched, this.unwatched})` | Creates a new [ReadonlySignalOptions](/types/readonlysignaloptions) instance. |
| **copyWith** | `method` | `ReadonlySignalOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})` | Creates a copy of this options with custom overrides. |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
