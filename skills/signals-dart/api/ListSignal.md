# function `listSignal`

Creates a [ListSignal](/types/listsignal) initialized with the provided **list**.

This is a convenience helper function for creating reactive list signals.

```dart
import 'package:signals/signals.dart';

final list = listSignal([1, 2, 3]);
```

---

## Signature

```dart
ListSignal<T> listSignal(List<T> list, {ListSignalOptions<T>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})
```

