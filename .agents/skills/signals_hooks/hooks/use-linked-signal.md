# useLinkedSignal

Creates a writable computed **LinkedSignal** bridging two signals.

## Example

```dart
class LinkedSignalView extends HookWidget {
  const LinkedSignalView({super.key});

  @override
  Widget build(BuildContext context) {
    final source = useSignal(10);
    final linked = useLinkedSignal<int, int>(
      () => source.value,
      const [],
      LinkedSignalOptions(
        name: 'linked',
        computation: (src, prev) => src * 2,
      ),
    );
    return Text('Linked (derived): \${linked.value}');
  }
}
```
