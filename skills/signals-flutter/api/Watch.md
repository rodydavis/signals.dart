# class `Watch`

> [!WARNING]
> This API is deprecated. Avoid using it in new code.

A deprecated widget for watching signal changes in the widget tree.

<Warning>
  <strong>DEPRECATED</strong>: Use <a href="/types/signalbuilder">SignalBuilder</a> instead for superior, self-contained reactivity
  and consistent API design.
</Warning>

### Migration to [SignalBuilder](/types/signalbuilder)
```dart
// Deprecated legacy pattern:
Watch((context) => Text('$counter'))

// Modern, streamlined pattern:
SignalBuilder(builder: (context) => Text('${counter.value}'))
```

---

## Members of `Watch`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **Watch** | `constructor` | `Watch(this.builder, {super.key, this.debugLabel, this.dependencies = const []})` | Minimal builder for signal changes that rerender a widget tree.

```dart
final counter = signal(0);
...
Watch((context) => Text('$counter'))
``` |
| **Watch.builder** | `constructor` | `Watch.builder({super.key, required this.builder, this.debugLabel, this.dependencies = const []})` | Drop in replacement for the Flutter builder widget.

```dart
final counter = signal(0);
...
- Builder(
+ Watch.builder(
  builder: (context) {
    return Text('$counter');
  }
)
``` |
| **builder** | `field` | `T Function(BuildContext context) builder` | The widget to rebuild when any signals change |
| **debugLabel** | `field` | `String? debugLabel` | Optional debug label to use for devtools |
| **dependencies** | `field` | `List<core.ReadonlySignal<dynamic>> dependencies` | List of optional dependencies to watch |
| **build** | `method` | `Widget build(BuildContext context)` |  |
