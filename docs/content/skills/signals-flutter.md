---
title: signals-flutter AI Skill
description: Comprehensive guide and best practices for integrating reactive signals cleanly inside Flutter applications. (v7.1.0)
---

# signals-flutter AI Developer Skill

> Comprehensive guide and best practices for integrating reactive signals cleanly inside Flutter applications. (v7.1.0)

---

### 📥 Installation

To instantly install this AI developer skill into your local workspace under `.agents/skills/`, run:

```bash
npx skills add rodydavis/signals.dart/tree/main/skills/signals-flutter
```

---

## 📄 SKILL.md Preview

````plaintext
# signals-flutter API Best Practices & Primitive Definitions

This guide outlines advanced state management primitives, reactive collections, async features, and value options semantics in `package:signals-flutter` (version `7.1.0`).

---

## 📊 Reactive Primitives Directory

The following table summarizes all available reactive primitives and widgets. Click on any primitive's name to view its detailed documentation, standard usage, and examples.

| Primitive | Category | Description |
| :--- | :--- | :--- |
| [SignalBuilder](primitives/SignalBuilder.md) | Flutter | Subscribes to a single signal, rebuilding only this local builder block when it changes. |
| [SignalEffect](primitives/SignalEffect.md) | Flutter | Executes standard Flutter side effects (Snackbars, dialogs) inside widget lifecycles safely. |

---

## 📦 Parsed Library API Directory

The following table summarizes all available classes, functions, and extensions exported by the package. Click on any API's name to view its detailed signature, members, and documentation.

| API | Type | Description |
| :--- | :--- | :--- |
| [FlutterSignal](api/FlutterSignal.md) | `class` | A mutable, reactive state cell that exposes both standard Signals and Flutter |
| [signal](api/signal.md) | `function` | Creates a mutable, reactive [FlutterSignal](/types/fluttersignal) initialized with the given value. |
| [lazySignal](api/lazySignal.md) | `function` | Creates a lazy, mutable [FlutterSignal](/types/fluttersignal) of type T whose value can be assigned later. |
| [FlutterReadonlySignal](api/FlutterReadonlySignal.md) | `class` | Simple writeable single |
| [readonly](api/readonly.md) | `function` | Create a new plain readonly signal |
| [FlutterComputed](api/FlutterComputed.md) | `class` | A read-only reactive signal whose value is automatically computed and cached |
| [computed](api/computed.md) | `function` | Creates a new [FlutterComputed](/types/fluttercomputed) signal that recalculates its value dynamically |
| [FlutterReadonlySignalUtils](api/FlutterReadonlySignalUtils.md) | `extension` | Signal extensions for watching value changes on BuildContext. |
| [SignalValueListenableUtils](api/SignalValueListenableUtils.md) | `extension` | Extension on ValueListenable to seamlessly bridge standard Flutter values to reactive signals. |
| [valueListenableToSignal](api/valueListenableToSignal.md) | `function` | A global helper function to convert a Flutter ValueListenable to a [ReadonlySignal](/types/readonlysignal). |
| [SignalValueNotifierUtils](api/SignalValueNotifierUtils.md) | `extension` | Extension on ValueNotifier to seamlessly bridge standard Flutter mutable values to reactive signals. |
| [valueNotifierToSignal](api/valueNotifierToSignal.md) | `function` | A global helper function to convert a Flutter ValueNotifier to a mutable [Signal](/types/signal). |
| [SignalWidget](api/SignalWidget.md) | `class` | A reactive StatelessWidget that implicitly tracks and rebuilds on signal changes. |
| [SignalElement](api/SignalElement.md) | `class` | Element for [SignalWidget](/types/signalwidget) that manages implicit signal subscription and handles dynamic branching. |
| [SignalStatefulWidget](api/SignalStatefulWidget.md) | `class` | A reactive StatefulWidget that implicitly tracks and rebuilds on signal changes. |
| [SignalStatefulElement](api/SignalStatefulElement.md) | `class` | Element for [SignalStatefulWidget](/types/signalstatefulwidget) that manages implicit signal subscription and handles dynamic branching. |
| [SignalBuilder](api/SignalBuilder.md) | `class` | A premium, surgical builder widget that rebuilds locally on signal changes. |
| [SignalAnimatedBuilder](api/SignalAnimatedBuilder.md) | `class` | A reactive builder widget designed for performance optimizations using child caching. |
| [SignalEffect](api/SignalEffect.md) | `class` | A widget that enables executing scoped reactive side-effects inline within the widget tree. |
| [StatelessWidgetConvertWidgetExtension](api/StatelessWidgetConvertWidgetExtension.md) | `extension` | Extension to convert standard Flutter widgets to reactive Signal widgets. |
| [StatefulWidgetConvertWidgetExtension](api/StatefulWidgetConvertWidgetExtension.md) | `extension` | Extension to convert standard Flutter widgets to reactive Signal stateful widgets. |
| [StatelessElementConvertExtension](api/StatelessElementConvertExtension.md) | `extension` | Extension to convert standard Flutter elements to their reactive counterparts. |
| [StatefulElementConvertExtension](api/StatefulElementConvertExtension.md) | `extension` | Extension to convert standard Flutter elements to their reactive counterparts. |
| [ConvertedSignalWidget](api/ConvertedSignalWidget.md) | `class` | A wrapper [SignalWidget](/types/signalwidget) that wraps a StatelessWidget. |
| [ConvertedSignalStatefulWidget](api/ConvertedSignalStatefulWidget.md) | `class` | A wrapper [SignalStatefulWidget](/types/signalstatefulwidget) that wraps a StatefulWidget. |
| [ConvertedSignalStatefulElement](api/ConvertedSignalStatefulElement.md) | `class` | Element for [ConvertedSignalStatefulWidget](/types/convertedsignalstatefulwidget) that overrides the widget getter |
| [TickerSignal](api/TickerSignal.md) | `class` | Ticker signal used to drive animations and can create animation controllers |
| [tickerSignal](api/tickerSignal.md) | `function` | Ticker signal used to drive animations and can create animation controllers |
| [ValueListenableSignalMixin](api/ValueListenableSignalMixin.md) | `class` | ValueListenable implementation for [ReadonlySignal](/types/readonlysignal) |
| [ValueNotifierSignalMixin](api/ValueNotifierSignalMixin.md) | `class` | ValueNotifier implementation for [Signal](/types/signal) |
| [SignalProvider](api/SignalProvider.md) | `class` | A premium dependency-injection / state propagation widget that allows passing |
| [MultiSignalProvider](api/MultiSignalProvider.md) | `class` | A dependency-injection / state propagation widget that allows passing |
| [SignalCustomPainter](api/SignalCustomPainter.md) | `class` | A premium custom painter that automatically repaints when any observed signal changes, |
| [SignalCustomPaint](api/SignalCustomPaint.md) | `class` | A high-performance canvas painting widget that subscribes to signals and renders |
| [RenderSignalCustomPaint](api/RenderSignalCustomPaint.md) | `class` | The RenderObject for [SignalCustomPaint](/types/signalcustompaint) that delegates drawing to [SignalCustomPainter](/types/signalcustompainter). |
| [RenderSignalProxyBox](api/RenderSignalProxyBox.md) | `class` | A low-level RenderProxyBox that subscribes to multiple reactive signals |
| [SignalProxyWidget](api/SignalProxyWidget.md) | `class` | A low-level widget wrapper around [RenderSignalProxyBox](/types/rendersignalproxybox) for custom painting / sizing needs. |
| [SignalPainterWidget](api/SignalPainterWidget.md) | `class` | A high-performance, leaf render-object widget driven by a double progress signal. |
| [RenderSignalBox](api/RenderSignalBox.md) | `class` | The low-level RenderBox used by [SignalPainterWidget](/types/signalpainterwidget) to directly subscribe to a progress signal and paint. |
````
