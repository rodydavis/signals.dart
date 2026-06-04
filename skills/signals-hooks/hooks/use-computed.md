# useComputed

Creates a read-only **Computed** signal that caches computed values and tracks changes.

## Example

```dart
class DoubledCounter extends HookWidget {
  const DoubledCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useSignal(10);
    final doubled = useComputed(() => count.value * 2);
    return Text('Doubled: ${doubled.value}');
  }
}
```
