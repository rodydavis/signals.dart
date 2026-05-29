# function `iterableSignal`

Creates an [IterableSignal](/types/iterablesignal) holding the provided **iterable**.

This is a convenience function that instantiates an [IterableSignal](/types/iterablesignal), which delegates
all standard **Iterable** operations reactively and tracks changes.

### Example Usage

```dart
import 'package:signals/signals.dart';

final s = iterableSignal([1, 2, 3]);
print(s.length); // 3
```

---

## Signature

```dart
IterableSignal<T> iterableSignal(Iterable<T> iterable, {IterableSignalOptions<T>? options, @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: IterableSignalOptions(name: ...) instead') String? debugLabel})
```

