# useValueNotifierToSignal

Bridges a standard Flutter `ValueNotifier` to a mutable reactive **Signal**.

## Example

```dart
class NotifierBridgeView extends HookWidget {
  final ValueNotifier<int> notifier;
  const NotifierBridgeView(this.notifier, {super.key});

  @override
  Widget build(BuildContext context) {
    final signal = useValueNotifierToSignal(
      notifier,
      const [],
      SignalOptions(name: 'bridge-mutable'),
    );

    return ElevatedButton(
      onPressed: () => signal.value++,
      child: Text('Notifier value: \${signal.value}'),
    );
  }
}
```
