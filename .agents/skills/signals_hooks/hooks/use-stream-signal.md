# useStreamSignal

Subscribes to a Stream and exposes its events via a **StreamSignal**.

## Example

```dart
class StreamTicksView extends HookWidget {
  const StreamTicksView({super.key});

  @override
  Widget build(BuildContext context) {
    final ticks = useStreamSignal(
      () => Stream.periodic(Duration(seconds: 1), (i) => i),
      const [],
      AsyncSignalOptions(name: 'ticks-stream'),
    );

    return Text('Ticks: \${ticks.value.value ?? 0}');
  }
}
```
