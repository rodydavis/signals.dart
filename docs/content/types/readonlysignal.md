---
title: "Type: ReadonlySignal"
description: "API reference and details for ReadonlySignal from signals.dart."
---

# ReadonlySignal

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: ReadonlySignal

An interface for read-only signals.

A [ReadonlySignal](/types/readonlysignal) is a reactive container whose value can be read but not directly mutated.
Under the hood, any [Signal](/types/signal) implements or can be cast/exposed as a [ReadonlySignal](/types/readonlysignal). This
is a core architectural pattern for encapsulating state: classes can modify state internally
using a private mutable <code>Signal</code>, while exposing a public <code>ReadonlySignal</code> to consumers to
enforce unidirectional data flow.

Whenever the underlying value changes, any active [effect](/types/effect) or [computed](/types/computed) signal that reads this
signal's value will automatically be re-evaluated.

### Example Usage

````dart
import 'package:preact_signals/preact_signals.dart';

class CounterController {
  // Keep the mutable state private to the controller
  final _counter = signal(0);

  // Expose a public read-only signal to external consumers
  ReadonlySignal<int> get counter => _counter;

  void increment() {
    _counter.value++;
  }

  void decrement() {
    _counter.value--;
  }
}

void main() {
  final controller = CounterController();

  // React to updates from the read-only signal
  final dispose = effect(() {
    print("The current count is: ${controller.counter.value}");
  });

  // controller.counter.value = 10; // Error: Cannot mutate a ReadonlySignal!

  controller.increment(); // Prints: "The current count is: 1"
  controller.increment(); // Prints: "The current count is: 2"

  dispose();
}
````

<Success>
Use [ReadonlySignal] to prevent consumers of your stores or controllers from modifying state
bypassing the controller's methods. This ensures consistent, predictable, and traceable mutations
throughout your application.
</Success>

### Members of ReadonlySignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **globalId** | <code>method</code> | <code>dart int globalId</code> | Global ID of the signal |
| **value** | <code>method</code> | <code>dart T value</code> | Compute the current value |
| **name** | <code>method</code> | <code>dart String? name</code> | The name of the signal for debugging purposes. |
| **watched** | <code>method</code> | <code>dart void Function()? watched</code> | Callback called when the signal goes from 0 to >=1 listeners. |
| **unwatched** | <code>method</code> | <code>dart void Function()? unwatched</code> | Callback called when the signal goes from >=1 to 0 listeners. |
| **toString** | <code>method</code> | <code>dart String toString()</code> |  |
| **toJson** | <code>method</code> | <code>dart dynamic toJson()</code> | Convert value to JSON |
| **call** | <code>method</code> | <code>dart T call()</code> | Return the value when invoked |
| **get** | <code>method</code> | <code>dart T get()</code> | Helper method to get the current value |
| **peek** | <code>method</code> | <code>dart T peek()</code> | In the rare instance that you have an effect that should write to another signal based on the previous value, but you _don't_ want the effect to be subscribed to that signal, you can read a signals's previous value via <code>signal.peek()</code>. |
| **subscribe** | <code>method</code> | <code>dart void Function() subscribe(void Function(T value) fn)</code> | Subscribe to value changes with a dispose function |

## References

The **ReadonlySignal** type is referenced and used in the following pages:

* [ReadonlySignal](/packages/signals_flutter/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [ValueListenableSignalMixin](/packages/signals_flutter/mixins/value-listenable-signal-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [StreamSignalMixin](/packages/signals_flutter/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [FutureSignal](/packages/signals_flutter/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Stream](/packages/signals_flutter/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [RenderSignalProxyBox](/packages/signals_flutter/render/render-signal-proxy-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/render)</span>
* [RenderSignalBox](/packages/signals_flutter/render/render-signal-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/render)</span>
* [Signal Value Listenable Utils](/packages/signals_flutter/extensions/signal-value-listenable-utils) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalStatefulElement](/packages/signals_flutter/extensions/signal-stateful-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalCustomPainter](/packages/signals_flutter/extensions/signal-custom-painter) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalElement](/packages/signals_flutter/extensions/signal-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Value Listenable To Signal](/packages/signals_flutter/extensions/value-listenable-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalPainterWidget](/packages/signals_flutter/widgets/signal-painter-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [WatchBuilder](/packages/signals_flutter/widgets/watch-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [Watch](/packages/signals_flutter/widgets/watch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalBuilder](/packages/signals_flutter/widgets/signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalProxyWidget](/packages/signals_flutter/widgets/signal-proxy-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalAnimatedBuilder](/packages/signals_flutter/widgets/signal-animated-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [ReadonlySignal](/packages/signals_core/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [StreamSignalMixin](/packages/signals_core/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [FutureSignal](/packages/signals_core/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Stream](/packages/signals_core/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [signals_core](/packages/signals_core)
* [ReadonlySignal](/packages/signals/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [ValueListenableSignalMixin](/packages/signals/mixins/value-listenable-signal-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [StreamSignalMixin](/packages/signals/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [FutureSignal](/packages/signals/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Stream](/packages/signals/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [RenderSignalProxyBox](/packages/signals/render/render-signal-proxy-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals/render)</span>
* [RenderSignalBox](/packages/signals/render/render-signal-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals/render)</span>
* [Signal Value Listenable Utils](/packages/signals/extensions/signal-value-listenable-utils) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalStatefulElement](/packages/signals/extensions/signal-stateful-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalCustomPainter](/packages/signals/extensions/signal-custom-painter) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalElement](/packages/signals/extensions/signal-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Value Listenable To Signal](/packages/signals/extensions/value-listenable-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [signals](/packages/signals)
* [SignalPainterWidget](/packages/signals/widgets/signal-painter-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [WatchBuilder](/packages/signals/widgets/watch-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [Watch](/packages/signals/widgets/watch) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalBuilder](/packages/signals/widgets/signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalProxyWidget](/packages/signals/widgets/signal-proxy-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalAnimatedBuilder](/packages/signals/widgets/signal-animated-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [useValueListenableToSignal](/packages/signals_hooks/hooks/use-value-listenable-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignalValue](/packages/signals_hooks/hooks/use-signal-value) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useExistingSignal](/packages/signals_hooks/hooks/use-existing-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [ReadonlySignal](/packages/preact_signals/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Signal](/packages/preact_signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [preact_signals](/packages/preact_signals)

