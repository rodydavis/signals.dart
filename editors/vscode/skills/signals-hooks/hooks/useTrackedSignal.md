# useTrackedSignal

Creates a **TrackedSignal** that remembers its previous values.

## Example

```dart
class TrackedSignalView extends HookWidget {
  const TrackedSignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useTrackedSignal(0, TrackedSignalOptions(name: 'tracked-count'));
    return Column(
      children: [
        Text('Current: ${count.value}'),
        Text('Previous: ${count.previousValue}'),
      ],
    );
  }
}
```
