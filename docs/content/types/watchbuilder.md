---
title: "Type: WatchBuilder"
description: "API reference and details for WatchBuilder from signals.dart."
---

# WatchBuilder <span class="deprecated-badge">deprecated</span>

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
  &nbsp;|&nbsp; <span class="deprecated-badge">deprecated</span>
</Info>

## Class: WatchBuilder <span class="deprecated-badge">deprecated</span>

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

### Members of WatchBuilder

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **WatchBuilder** | <code>constructor</code> | <code>dart WatchBuilder({super.key, required this.builder, this.debugLabel, this.dependencies = const [], this.child})</code> | Minimal builder for signal changes that rerender a widget tree. |
| **builder** | <code>field</code> | <code>dart T Function(BuildContext context, Widget? child) builder</code> | The widget to rebuild when any signals change |
| **debugLabel** | <code>field</code> | <code>dart String? debugLabel</code> | Optional debug label to use for devtools |
| **child** | <code>field</code> | <code>dart Widget? child</code> | Cached widget to pass in |
| **dependencies** | <code>field</code> | <code>dart List<core.ReadonlySignal<dynamic>> dependencies</code> | List of optional dependencies to watch |
| **build** | <code>method</code> | <code>dart Widget build(BuildContext context)</code> |  |

## References

The **WatchBuilder** type is referenced and used in the following pages:

* [signals_flutter](/packages/signals_flutter)
* [WatchBuilder](/packages/signals_flutter/widgets/watch-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalAnimatedBuilder](/packages/signals_flutter/widgets/signal-animated-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [signals](/packages/signals)
* [WatchBuilder](/packages/signals/widgets/watch-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalAnimatedBuilder](/packages/signals/widgets/signal-animated-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>

