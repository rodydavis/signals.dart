---
name: signals-flutter
description: Comprehensive guide and best practices for integrating reactive signals cleanly inside Flutter applications. (v7.1.0)
---

# signals-flutter API Best Practices & Primitive Definitions

This guide outlines advanced state management primitives, reactive collections, async features, and value options semantics in `package:signals-flutter` (version `7.1.0`).

---

## 📊 Reactive Primitives Directory

The following table summarizes all available reactive primitives and widgets. Click on any primitive's name to view its detailed documentation, standard usage, and examples.

| Primitive | Category | Description |
| :--- | :--- | :--- |
| [SignalBuilder](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/primitives/SignalBuilder.md) | Flutter | Subscribes to a single signal, rebuilding only this local builder block when it changes. |
| [SignalEffect](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/primitives/SignalEffect.md) | Flutter | Executes standard Flutter side effects (Snackbars, dialogs) inside widget lifecycles safely. |

---

## 📦 Parsed Library API Directory

The following table summarizes all available classes, functions, and extensions exported by the package. Click on any API's name to view its detailed signature, members, and documentation.

| API | Type | Description |
| :--- | :--- | :--- |
| [FlutterSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/FlutterSignal.md) | `class` | A mutable, reactive state cell that exposes both standard Signals and Flutter |
| [signal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/signal.md) | `function` | Creates a mutable, reactive [FlutterSignal](/types/fluttersignal) initialized with the given value. |
| [lazySignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/lazySignal.md) | `function` | Creates a lazy, mutable [FlutterSignal](/types/fluttersignal) of type T whose value can be assigned later. |
| [FlutterReadonlySignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/FlutterReadonlySignal.md) | `class` | Simple writeable single |
| [readonly](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/readonly.md) | `function` | Create a new plain readonly signal |
| [FlutterComputed](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/FlutterComputed.md) | `class` | A read-only reactive signal whose value is automatically computed and cached |
| [computed](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/computed.md) | `function` | Creates a new [FlutterComputed](/types/fluttercomputed) signal that recalculates its value dynamically |
| [FlutterReadonlySignalUtils](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/FlutterReadonlySignalUtils.md) | `extension` | Signal extensions for watching value changes on BuildContext. |
| [SignalValueListenableUtils](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalValueListenableUtils.md) | `extension` | Extension on ValueListenable to seamlessly bridge standard Flutter values to reactive signals. |
| [valueListenableToSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/valueListenableToSignal.md) | `function` | A global helper function to convert a Flutter ValueListenable to a [ReadonlySignal](/types/readonlysignal). |
| [SignalValueNotifierUtils](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalValueNotifierUtils.md) | `extension` | Extension on ValueNotifier to seamlessly bridge standard Flutter mutable values to reactive signals. |
| [valueNotifierToSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/valueNotifierToSignal.md) | `function` | A global helper function to convert a Flutter ValueNotifier to a mutable [Signal](/types/signal). |
| [SignalWidget](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalWidget.md) | `class` | A reactive StatelessWidget that implicitly tracks and rebuilds on signal changes. |
| [SignalElement](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalElement.md) | `class` | Element for [SignalWidget](/types/signalwidget) that manages implicit signal subscription and handles dynamic branching. |
| [SignalStatefulWidget](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalStatefulWidget.md) | `class` | A reactive StatefulWidget that implicitly tracks and rebuilds on signal changes. |
| [SignalStatefulElement](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalStatefulElement.md) | `class` | Element for [SignalStatefulWidget](/types/signalstatefulwidget) that manages implicit signal subscription and handles dynamic branching. |
| [SignalBuilder](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalBuilder.md) | `class` | A premium, surgical builder widget that rebuilds locally on signal changes. |
| [SignalAnimatedBuilder](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalAnimatedBuilder.md) | `class` | A reactive builder widget designed for performance optimizations using child caching. |
| [SignalEffect](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalEffect.md) | `class` | A widget that enables executing scoped reactive side-effects inline within the widget tree. |
| [StatelessWidgetConvertWidgetExtension](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/StatelessWidgetConvertWidgetExtension.md) | `extension` | Extension to convert standard Flutter widgets to reactive Signal widgets. |
| [StatefulWidgetConvertWidgetExtension](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/StatefulWidgetConvertWidgetExtension.md) | `extension` | Extension to convert standard Flutter widgets to reactive Signal stateful widgets. |
| [StatelessElementConvertExtension](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/StatelessElementConvertExtension.md) | `extension` | Extension to convert standard Flutter elements to their reactive counterparts. |
| [StatefulElementConvertExtension](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/StatefulElementConvertExtension.md) | `extension` | Extension to convert standard Flutter elements to their reactive counterparts. |
| [ConvertedSignalWidget](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/ConvertedSignalWidget.md) | `class` | A wrapper [SignalWidget](/types/signalwidget) that wraps a StatelessWidget. |
| [ConvertedSignalStatefulWidget](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/ConvertedSignalStatefulWidget.md) | `class` | A wrapper [SignalStatefulWidget](/types/signalstatefulwidget) that wraps a StatefulWidget. |
| [ConvertedSignalStatefulElement](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/ConvertedSignalStatefulElement.md) | `class` | Element for [ConvertedSignalStatefulWidget](/types/convertedsignalstatefulwidget) that overrides the widget getter |
| [TickerSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/TickerSignal.md) | `class` | Ticker signal used to drive animations and can create animation controllers |
| [tickerSignal](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/tickerSignal.md) | `function` | Ticker signal used to drive animations and can create animation controllers |
| [ValueListenableSignalMixin](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/ValueListenableSignalMixin.md) | `class` | ValueListenable implementation for [ReadonlySignal](/types/readonlysignal) |
| [ValueNotifierSignalMixin](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/ValueNotifierSignalMixin.md) | `class` | ValueNotifier implementation for [Signal](/types/signal) |
| [SignalProvider](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalProvider.md) | `class` | A premium dependency-injection / state propagation widget that allows passing |
| [MultiSignalProvider](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/MultiSignalProvider.md) | `class` | A dependency-injection / state propagation widget that allows passing |
| [SignalCustomPainter](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalCustomPainter.md) | `class` | A premium custom painter that automatically repaints when any observed signal changes, |
| [SignalCustomPaint](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalCustomPaint.md) | `class` | A high-performance canvas painting widget that subscribes to signals and renders |
| [RenderSignalCustomPaint](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/RenderSignalCustomPaint.md) | `class` | The RenderObject for [SignalCustomPaint](/types/signalcustompaint) that delegates drawing to [SignalCustomPainter](/types/signalcustompainter). |
| [RenderSignalProxyBox](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/RenderSignalProxyBox.md) | `class` | A low-level RenderProxyBox that subscribes to multiple reactive signals |
| [SignalProxyWidget](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalProxyWidget.md) | `class` | A low-level widget wrapper around [RenderSignalProxyBox](/types/rendersignalproxybox) for custom painting / sizing needs. |
| [SignalPainterWidget](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/SignalPainterWidget.md) | `class` | A high-performance, leaf render-object widget driven by a double progress signal. |
| [RenderSignalBox](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/update-vscode-signals-extension/skills/signals-flutter/api/RenderSignalBox.md) | `class` | The low-level RenderBox used by [SignalPainterWidget](/types/signalpainterwidget) to directly subscribe to a progress signal and paint. |
