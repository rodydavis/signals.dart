# useMapSignal

Creates a reactive **MapSignal** for key-value collections.

## Example

```dart
class MapSignalView extends HookWidget {
  const MapSignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final config = useMapSignal({'theme': 'dark'}, MapSignalOptions(name: 'config'));
    return Text('Theme: ${config['theme']}');
  }
}
```
