# function `readonly`

Creates a new read-only signal initialized with **value**.

This function returns a [ReadonlySignal](/types/readonlysignal) containing **value**. Under the hood, a mutable [Signal](/types/signal)
is created, but it is returned under the [ReadonlySignal](/types/readonlysignal) interface to prevent modification by clients.

This is particularly useful when you need to expose a constant reactive value, or bridge some external,
immutable value source into the signals reactivity system.

Parameters:
- **value**: The initial value held by the read-only signal.
- **options**: Optional configuration options (e.g., custom debug name or lifecycle callbacks like <code>watched</code>/<code>unwatched</code>).

Returns:
- A [ReadonlySignal](/types/readonlysignal) containing the initial value.

### Example Usage

````dart
import 'package:preact_signals/preact_signals.dart';

final configUrl = readonly('https://api.example.com');

void main() {
  effect(() {
    print("Connecting to: ${configUrl.value}");
  });
}
````

<Warning>
If you are trying to derive a value from other signals, do not use [readonly]. Use [computed] instead
to ensure the derived signal automatically re-evaluates when its source signals change.
</Warning>

---

## Signature

```dart
ReadonlySignal<T> readonly(T value, [ReadonlySignalOptions<T>? options])
```

