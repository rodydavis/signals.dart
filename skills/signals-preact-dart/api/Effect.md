# function `effect`

Creates and immediately executes a new reactive [Effect](/types/effect).

Returns a bound disposer function that can be called to stop the effect and unsubscribe
it from all tracked signals.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final dispose = effect(() {
  print('Count is: ${count.value}');
  return () => print('Cleaning up!');
});

void main() {
  count.value = 10; // Prints: "Cleaning up!" then "Count is: 10"
  dispose(); // Stops the effect and unsubscribes
}
```

---

## Signature

```dart
void Function() effect( Function() fn, [EffectOptions? options])
```

