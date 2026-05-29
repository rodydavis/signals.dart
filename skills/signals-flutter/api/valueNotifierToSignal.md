# function `valueNotifierToSignal`

A global helper function to convert a Flutter **ValueNotifier** to a mutable [Signal](/types/signal).

Updates to either the notifier or the returned signal will automatically update the other.
This helper is a functional equivalent of the <code>toSignal()</code> extension method.

### Example
```dart
final textControllerValue = ValueNotifier('');
final textSignal = valueNotifierToSignal(textControllerValue);
```

---

## Signature

```dart
Signal<T> valueNotifierToSignal(ValueNotifier<T> valueNotifier, {String? debugLabel, bool autoDispose = false})
```

