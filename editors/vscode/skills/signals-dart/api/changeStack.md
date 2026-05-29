# function `changeStack`

Creates a [ChangeStackSignal](/types/changestacksignal) initialized with the provided **value**.

This is a convenience helper function for creating reactive undo/redo history signals.
You can pass a **limit** to restrict the maximum history stack size.

```dart
import 'package:signals/signals.dart';

final s = changeStack(0, limit: 10);
s.value = 1;
s.undo(); // Returns to 0
```

---

## Signature

```dart
ChangeStackSignal<T> changeStack(T value, {int? limit, ChangeSignalOptions<T>? options, @Deprecated('Use options: ChangeSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ChangeSignalOptions(name: ...) instead') String? debugLabel})
```

