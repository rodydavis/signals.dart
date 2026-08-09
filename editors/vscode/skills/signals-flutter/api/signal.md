# function `signal`

Creates a mutable, reactive [FlutterSignal](/types/fluttersignal) initialized with the given **value**.

When the value changes, all registered builders, effects, and **ValueNotifier** listeners
are automatically scheduled to update/rebuild.

### Flutter Widget Example

```dart
final count = signal(0);

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SignalBuilder(
          builder: (context) => Text('Count: ${count.value}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

---

## Signature

```dart
FlutterSignal<T> signal(T value, {core.SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```

