# class `WatchBuilder`

> [!WARNING]
> This API is deprecated. Avoid using it in new code.

## WatchBuilder

To watch a signal for changes in Flutter, use the <code>WatchBuilder</code> widget. This will only rebuild this widget method and not the entire widget tree.

```dart
final signal = signal(10);
...
@override
Widget build(BuildContext context) {
  return WatchBuilder(
    child: const Icon(Icons.add),
    builder: (context, child) => Row(children: [Text('$signal'), child!]),
  );
}
```

---

## Members of `WatchBuilder`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **WatchBuilder** | `constructor` | `WatchBuilder({super.key, required this.builder, this.debugLabel, this.dependencies = const [], this.child})` | Minimal builder for signal changes that rerender a widget tree.

```dart
final counter = signal(0);
...
WatchBuilder(
  builder: (context, child) => Text('$counter')
)
``` |
| **builder** | `field` | `T Function(BuildContext context, Widget? child) builder` | The widget to rebuild when any signals change |
| **debugLabel** | `field` | `String? debugLabel` | Optional debug label to use for devtools |
| **child** | `field` | `Widget? child` | Cached widget to pass in |
| **dependencies** | `field` | `List<core.ReadonlySignal<dynamic>> dependencies` | List of optional dependencies to watch |
| **build** | `method` | `Widget build(BuildContext context)` |  |
