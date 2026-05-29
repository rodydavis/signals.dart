# class `SignalEquality`

Defines the equality check algorithm used by signals to determine if a new value
actually differs from the current value.

By default, signals use standard Dart operator equality (<code>==</code>). However, you can configure
a signal to use different strategies, such as deep equality check for collections or custom comparator checks.

Strategies:
- **standard**: Default value equality (<code>a == b</code>).
- **identity**: Identity-based comparison (<code>identical(a, b)</code>).
- **deep**: Deep collection comparison for Lists, Maps, and Sets.
- **custom**: User-defined boolean comparison function.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  // Create a list signal using deep equality check
  final items = signal(
    [1, 2, 3],
    options: SignalOptions(
      equality: SignalEquality.deep(),
    ),
  );

  effect(() {
    print('Items changed: ${items.value}');
  });

  // Reassigning an identical value structure does NOT trigger a rebuild!
  items.value = [1, 2, 3];

  // Triggers rebuild
  items.value = [1, 2, 3, 4];
}
```

---

## Members of `SignalEquality`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalEquality** | `constructor` | `SignalEquality()` | @nodoc |
| **equals** | `method` | `bool equals(Object? a, Object? b)` | Check if two values are equal |
| **standard** | `method` | `static SignalEquality<T> standard()` | Standard equality check (a == b)

Matches two objects if their standard <code>==</code> operator returns true.
This is the default strategy used by all signals. |
| **identity** | `method` | `static SignalEquality<T> identity()` | Identity equality check (identical(a, b))

Matches two objects only if they are the exact same instance in memory. |
| **deep** | `method` | `static SignalEquality<T> deep()` | Deep equality check

Matches collections (Lists, Maps, Sets) recursively by comparing their items. |
| **SignalEquality.custom** | `constructor` | `SignalEquality.custom(bool Function(T a, T b) fn)` | Custom equality check

Uses a user-provided boolean function **fn** to check for equality. |
