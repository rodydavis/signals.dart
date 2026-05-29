# function `computed`

Creates a new [FlutterComputed](/types/fluttercomputed) signal that recalculates its value dynamically
based on the signals accessed inside the **compute** callback.

The returned computed signal is read-only and cached. It will only re-evaluate
when one of its tracked dependencies changes.

### Flutter Example

```dart
final firstName = signal('John');
final lastName = signal('Doe');

// Automatically combines both signals and caches the result:
final fullName = computed(() => '${firstName.value} ${lastName.value}');

// Usage inside a widget build:
@override
Widget build(BuildContext context) {
  return SignalBuilder(
    builder: (context) => Text('Hello, ${fullName.value}!'),
  );
}
```

---

## Signature

```dart
FlutterComputed<T> computed(T Function() compute, {core.ComputedOptions<T>? options, @Deprecated('Use options: ComputedOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```

