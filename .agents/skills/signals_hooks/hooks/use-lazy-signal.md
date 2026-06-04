# useLazySignal

Creates a **LazySignal** initialized lazily on first access.

## Example

```dart
class LazySignalView extends HookWidget {
  const LazySignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final lazyValue = useLazySignal<int>(
      options: SignalOptions(name: 'lazy'),
    );
    return ElevatedButton(
      onPressed: () => lazyValue.value = 42,
      child: Text(lazyValue.isInitialized ? 'Value: \${lazyValue.value}' : 'Initialize'),
    );
  }
}
```
