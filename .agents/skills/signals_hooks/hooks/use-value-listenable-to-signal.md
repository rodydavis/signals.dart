# useValueListenableToSignal

Bridges a standard Flutter `ValueListenable` to a read-only **ReadonlySignal**.

## Example

```dart
class ListenableBridgeView extends HookWidget {
  final ValueListenable<int> externalListenable;
  const ListenableBridgeView(this.externalListenable, {super.key});

  @override
  Widget build(BuildContext context) {
    final signal = useValueListenableToSignal(
      externalListenable,
      const [],
      SignalOptions(name: 'bridge-readonly'),
    );

    return Text('Listenable value in signal: \${signal.value}');
  }
}
```
