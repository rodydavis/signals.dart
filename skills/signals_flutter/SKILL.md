---
name: signals_flutter
description: Highly optimized Flutter UI bindings and GPU rendering for reactive signals.
---

# Flutter Reactive Signals Integration

This skill covers optimizing Flutter UI bindings, element-level reactive tracking, and high-frequency rendering utilizing the `signals_flutter` package.

---

## 1. Widget Rebuild Optimization

### A. `SignalBuilder` (Preferred)
Provides localized, context-isolated widget rebuilding. Wrap only the smallest possible widgets in `SignalBuilder` to keep rendering extremely high-performance.
```dart
SignalBuilder(
  builder: (context, value) => Text('Count: $value'),
)
```

### B. Element-Level `.watch(context)` Extension
Attaches subscriptions safely using VM Expando and a clean Finalizer teardown loop to avoid leaks.
- Avoid mixins like `SignalsMixin`.
- Use `.watch(context)` when context-based subtree scoping is required.

---

## 2. High-Frequency Rendering (`SignalCustomPaint`)

For ultra-high-frequency drawing driven by signals, bypass Flutter's heavy widget layout/rebuild lifecycle entirely.
`SignalCustomPaint` and `SignalPainterWidget` write directly to the GPU via `markNeedsPaint()` calls inside custom proxy render boxes:

```dart
SignalCustomPaint(
  painter: MySignalPainter(progressSignal),
  child: Container(),
)
```

---

## 3. Side Effects in Widget Trees (`SignalEffect`)

Use `SignalEffect` / `SignalListener` to trigger asynchronous side-effects (e.g., showing snackbars, navigation, showing modals) cleanly inside the widget lifecycle.
```dart
SignalEffect(
  callback: (context) {
    if (errorMessage.value != null) {
      showDialog(context: context, builder: (_) => Alert(errorMessage.value!));
    }
  },
  child: ChildWidget(),
)
```
