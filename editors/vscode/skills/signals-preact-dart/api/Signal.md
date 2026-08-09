# function `signal`

Convenient global constructor for creating a mutable reactive state signal.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final name = signal('Jane');
```

---

## Signature

```dart
Signal<T> signal(T value, [SignalOptions<T>? options])
```

