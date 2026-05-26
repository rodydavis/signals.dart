# useTrackedSignal

Creates a **TrackedSignal** that remembers its previous values.

## Example

```dart
class TrackedView extends HookWidget {
  const TrackedView({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useTrackedSignal(
      0,
      const [],
      TrackedSignalOptions(name: 'tracked-count'),
    );

    return Column(
      children: [
        Text('Current: \${count.value}'),
        Text('Previous: \${count.previousValue ?? "None"}'),
      ],
    );
  }
}
```
