# useLazySignal

Creates a **LazySignal** initialized lazily on first access.

## Example

```dart
class LazySignalView extends HookWidget {
  const LazySignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final lazyValue = useLazySignal<int>(
      () => 42,
      SignalOptions(name: 'lazy'),
    );
    return Text('Value: ${lazyValue.value}');
  }
}
```
