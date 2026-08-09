---
title: "Type: Watch"
description: "API reference and details for Watch from signals.dart."
---

# Watch <span class="deprecated-badge">deprecated</span>

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
  &nbsp;|&nbsp; <span class="deprecated-badge">deprecated</span>
</Info>

## Class: Watch <span class="deprecated-badge">deprecated</span>

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

### Members of Watch

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **Watch** | <code>constructor</code> | <code>dart Watch(this.builder, {super.key, this.debugLabel, this.dependencies = const []})</code> | Minimal builder for signal changes that rerender a widget tree. |
| **Watch.builder** | <code>constructor</code> | <code>dart Watch.builder({super.key, required this.builder, this.debugLabel, this.dependencies = const []})</code> | Drop in replacement for the Flutter builder widget. |
| **builder** | <code>field</code> | <code>dart T Function(BuildContext context) builder</code> | The widget to rebuild when any signals change |
| **debugLabel** | <code>field</code> | <code>dart String? debugLabel</code> | Optional debug label to use for devtools |
| **dependencies** | <code>field</code> | <code>dart List<core.ReadonlySignal<dynamic>> dependencies</code> | List of optional dependencies to watch |
| **build** | <code>method</code> | <code>dart Widget build(BuildContext context)</code> |  |

## References

The **Watch** type is referenced and used in the following pages:

* [Persisted Signals](/guides/persisted-signals) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [Dependency Injection](/guides/dependency-injection) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [ValueNotifier](/guides/value-notifier) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [Flutter Readonly Signal](/packages/signals_flutter/signals/flutter-readonly-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Stateful Element Convert Extension](/packages/signals_flutter/extensions/stateful-element-convert-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Stateless Element Convert Extension](/packages/signals_flutter/extensions/stateless-element-convert-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalEffect](/packages/signals_flutter/effects/signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/effects)</span>
* [WatchBuilder](/packages/signals_flutter/widgets/watch-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [Watch](/packages/signals_flutter/widgets/watch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalWidget](/packages/signals_flutter/widgets/signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalBuilder](/packages/signals_flutter/widgets/signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalAnimatedBuilder](/packages/signals_flutter/widgets/signal-animated-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [SignalsAvoidDeprecatedWatchExtension](/packages/signals_lint/flutter/signals-avoid-deprecated-watch-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsPreferNamedBuilder](/packages/signals_lint/flutter/signals-prefer-named-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [MigrateWatchToSignalBuilder](/packages/signals_lint/flutter/migrate-watch-to-signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [signals_lint](/packages/signals_lint)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [Flutter Readonly Signal](/packages/signals/signals/flutter-readonly-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Stateful Element Convert Extension](/packages/signals/extensions/stateful-element-convert-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Stateless Element Convert Extension](/packages/signals/extensions/stateless-element-convert-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [signals](/packages/signals)
* [SignalEffect](/packages/signals/effects/signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals/effects)</span>
* [WatchBuilder](/packages/signals/widgets/watch-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [Watch](/packages/signals/widgets/watch) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalWidget](/packages/signals/widgets/signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalBuilder](/packages/signals/widgets/signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalAnimatedBuilder](/packages/signals/widgets/signal-animated-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [useIterableSignal](/packages/signals_hooks/hooks/use-iterable-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useLazySignal](/packages/signals_hooks/hooks/use-lazy-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useValueNotifierToSignal](/packages/signals_hooks/hooks/use-value-notifier-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useValueListenableToSignal](/packages/signals_hooks/hooks/use-value-listenable-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useListSignal](/packages/signals_hooks/hooks/use-list-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useQueueSignal](/packages/signals_hooks/hooks/use-queue-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignal](/packages/signals_hooks/hooks/use-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignalValue](/packages/signals_hooks/hooks/use-signal-value) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useStreamSignal](/packages/signals_hooks/hooks/use-stream-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSetSignal](/packages/signals_hooks/hooks/use-set-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useLinkedSignal](/packages/signals_hooks/hooks/use-linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useChangeStackSignal](/packages/signals_hooks/hooks/use-change-stack-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useTrackedSignal](/packages/signals_hooks/hooks/use-tracked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useExistingSignal](/packages/signals_hooks/hooks/use-existing-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useAsyncSignal](/packages/signals_hooks/hooks/use-async-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useComputed](/packages/signals_hooks/hooks/use-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useFutureSignal](/packages/signals_hooks/hooks/use-future-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useAsyncComputed](/packages/signals_hooks/hooks/use-async-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignalEffect](/packages/signals_hooks/hooks/use-signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useMapSignal](/packages/signals_hooks/hooks/use-map-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [SignalHookWidget](/packages/signals_hooks/widgets/signal-hook-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>
* [Signal](/packages/preact_signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [signals-lint AI Skill](/skills/signals-lint) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [Installing](/reference/install) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>
* [AI Integration](/reference/ai) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>

