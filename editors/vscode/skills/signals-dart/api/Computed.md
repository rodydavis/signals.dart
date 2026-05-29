# function `computed`

Data is often derived from other pieces of existing data. The <code>computed</code> function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.

> <code>Computed</code> class extends the [<code>Signal</code>](/core/signal/) class, so you can use it anywhere you would use a signal.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");

final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
print(fullName.value);

// Updates flow through computed, but only if someone
// subscribes to it. More on that later.
name.value = "John";
// Logs: "John Doe"
print(fullName.value);
```

Any signal that is accessed inside the <code>computed</code>'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.

> Computed signals are both lazily evaluated and memoized

## Force Re-evaluation

You can force a computed signal to re-evaluate by calling its <code>.recompute</code> method. This will re-run the computed callback and update the computed signal's value.

```dart
final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

fullName.recompute(); // Re-runs the computed callback
```

## Disposing

### Auto Dispose

If a computed signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.

```dart
final s = computed(() => 0, autoDispose: true);
s.onDispose(() => print('Signal destroyed'));
final dispose = s.subscribe((_) {});
dispose();
final value = s.value; // 0
// prints: Signal destroyed
```

A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.

This means that it will no longer react to changes in its dependencies.

```dart
final s = computed(() => 0);
s.dispose();
final value = s.value; // 0
final b = computed(() => s.value); // 0
// b will not react to changes in s
```

You can check if a signal is disposed by calling the <code>.disposed</code> method.

```dart
final s = computed(() => 0);
print(s.disposed); // false
s.dispose();
print(s.disposed); // true
```

### On Dispose Callback

You can attach a callback to a signal that will be called when the signal is destroyed.

```dart
final s = computed(() => 0);
s.onDispose(() => print('Signal destroyed'));
s.dispose();
```


## Flutter

In Flutter applications, manage derived/computed state seamlessly by utilizing [SignalStatefulWidget](/types/signalstatefulwidget) (for state-bound signals and computeds) or [SignalWidget](/types/signalwidget).
Computed signals accessed via <code>.value</code> inside the <code>build</code> method are automatically tracked, ensuring the widget rebuilds only when the computed value changes.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterWidget extends SignalStatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final counter = signal(0);
  late final isEven = computed(() => counter.value.isEven);
  late final isOdd = computed(() => counter.value.isOdd);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: even=${isEven.value}, odd=${isOdd.value}'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

No manual <code>Watch</code> widget or context extension is needed; the widget automatically rebuilds when any tracked signal mutates.

## Testing

Testing computed signals is possible by converting a computed to a stream and testing it like any other stream in Dart.

```dart
test('test as stream', () {
    final a = signal(0);
    final s = computed(() => a());
    final stream = s.toStream();

    a.value = 1;
    a.value = 2;
    a.value = 3;

    expect(stream, emitsInOrder([0, 1, 2, 3]));
});
```

<code>emitsInOrder</code> is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.

You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.

```dart
test('test with override', () {
    final a = signal(0);
    final s = computed(() => a()).overrideWith(-1);

    final stream = s.toStream();

    a.value = 1;
    a.value = 2;
    a.value = 2; // check if skipped
    a.value = 3;

    expect(stream, emitsInOrder([-1, 1, 2, 3]));
});
```

<code>overrideWith</code> returns a new computed signal with the same global id sets the value as if the computed callback returned it.

---

## Signature

```dart
Computed<T> computed(ComputedCallback<T> compute, {ComputedOptions<T>? options, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ComputedOptions(name: ...) instead') String? debugLabel})
```

