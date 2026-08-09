# extension `SignalIterableUtils`

Utility extension methods on **Iterable** to convert them to [IterableSignal](/types/iterablesignal)s.

---

## Members of `SignalIterableUtils`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `IterableSignal<T> toSignal({IterableSignalOptions<T>? options, @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: IterableSignalOptions(name: ...) instead') String? debugLabel})` | Convert an existing **Iterable** to an [IterableSignal](/types/iterablesignal).

This returns an [IterableSignal](/types/iterablesignal) initialized with the current collection.

```dart
import 'package:signals/signals.dart';

final numbers = [1, 2, 3];
final signal = numbers.toSignal();
``` |
