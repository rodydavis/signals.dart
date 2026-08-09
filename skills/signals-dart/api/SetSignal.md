# function `setSignal`

Creates a [SetSignal](/types/setsignal) initialized with the provided **set**.

This is a convenience helper function for creating reactive set signals.

```dart
import 'package:signals/signals.dart';

final mySet = setSignal({1, 2, 3});
```

---

## Signature

```dart
SetSignal<T> setSignal(Set<T> list, {SetSignalOptions<T>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})
```

