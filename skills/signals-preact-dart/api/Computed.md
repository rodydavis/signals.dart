# function `computed`

Convenient global constructor for creating a derived computed signal.

Computed signals are lazily evaluated and cached (memoized). Their values
automatically update when any dependency signals accessed inside the callback function change.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final firstName = signal('Jane');
final lastName = signal('Doe');

final fullName = computed(() => '${firstName.value} ${lastName.value}');

void main() {
  print(fullName.value); // Prints: Jane Doe
}
```

---

## Signature

```dart
ReadonlySignal<T> computed(T Function() fn, [ComputedOptions<T>? options])
```

