# extension `SignalListUtils`

Utility extension methods on **List** to convert them to [ListSignal](/types/listsignal)s.

---

## Members of `SignalListUtils`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `ListSignal<T> toSignal({ListSignalOptions<T>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})` | Convert this existing **List** to a reactive [ListSignal](/types/listsignal).

```dart
import 'package:signals/signals.dart';

final myList = [1, 2, 3];
final signal = myList.toSignal();
``` |
