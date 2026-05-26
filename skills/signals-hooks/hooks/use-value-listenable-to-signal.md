# useValueListenableToSignal

Bridges a standard Flutter **ValueListenable** to a read-only **ReadonlySignal**.

## Example

```dart
class ListenableToSignalView extends HookWidget {
  final ValueListenable<int> listenable;
  const ListenableToSignalView(this.listenable, {super.key});

  @override
  Widget build(BuildContext context) {
    final signalValue = useValueListenableToSignal(
      listenable,
      SignalOptions(name: 'listenable-bridge'),
    );

    return Text('Signal: ${signalValue.value}');
  }
}
```
