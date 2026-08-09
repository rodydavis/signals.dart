# useValueNotifierToSignal

Bridges a standard Flutter **ValueNotifier** to a mutable reactive **Signal**.

## Example

```dart
class NotifierToSignalView extends HookWidget {
  const NotifierToSignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = useMemoized(() => ValueNotifier(0));
    final signalValue = useValueNotifierToSignal(
      notifier,
      SignalOptions(name: 'value-notifier-bridge'),
    );

    return Text('Signal: ${signalValue.value}');
  }
}
```
