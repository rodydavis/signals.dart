# useMapSignal

Creates a reactive **MapSignal** for key-value collections.

## Example

```dart
class MapStateView extends HookWidget {
  const MapStateView({super.key});

  @override
  Widget build(BuildContext context) {
    final map = useMapSignal(
      {'theme': 'dark'},
      const [],
      MapSignalOptions(name: 'app-settings'),
    );

    return Text('Theme: \${map['theme']}');
  }
}
```
