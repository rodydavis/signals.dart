---
title: "Type: SignalsMixin"
description: "API reference and details for SignalsMixin from signals.dart."
---

# SignalsMixin <span class="deprecated-badge">deprecated</span>

<Info>
  <strong>Kind:</strong> <code>mixin</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
  &nbsp;|&nbsp; <span class="deprecated-badge">deprecated</span>
</Info>

## Mixin: SignalsMixin <span class="deprecated-badge">deprecated</span>

A State mixin that automatically handles subscription and cleanup of signals
and effects created locally within a **StatefulWidget**.

<Warning>
<strong>DEPRECATED</strong>: This mixin is deprecated. While fully supported for backward compatibility,
it adds extra stateful widget lifecycle overhead and manual binding.

For superior, self-contained reactivity without mixin overhead, migrate to modern, high-performance APIs:
- Use <a href="/types/signalwidget">SignalWidget</a> for stateless reactive widgets.
- Use <a href="/types/signalstatefulwidget">SignalStatefulWidget</a> for stateful reactive widgets.
- Use <a href="/types/signalbuilder">SignalBuilder</a> for surgical, localized rebuilding.
</Warning>

### Legacy Usage Example
```dart
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> with SignalsMixin {
  late final count = createSignal(0);
  late final doubled = createComputed(() => count.value * 2);

  @override
  void initState() {
    super.initState();
    createEffect(() {
      print('Count: ${count.value}, Doubled: ${doubled.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: ${count.value}'),
        Text('Doubled: ${doubled.value}'),
        ElevatedButton(
          onPressed: () => count.value++,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

### Modern Migration Example
```dart
// Modern alternative using SignalStatefulWidget:
class CounterWidget extends SignalStatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final count = signal(0);
  late final doubled = computed(() => count.value * 2);

  @override
  void initState() {
    super.initState();
    // For non-widget effects, use the standard `effect` function:
    effect(() {
      print('Count: ${count.value}, Doubled: ${doubled.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Implicitly tracks both signals and rebuilds on change:
    return Column(
      children: [
        Text('Count: ${count.value}'),
        Text('Doubled: ${doubled.value}'),
        ElevatedButton(
          onPressed: () => count.value++,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

### Members of SignalsMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **disposeSignal** | <code>method</code> | <code>dart void disposeSignal(int id)</code> | Dispose and remove signal |
| **createComputedFrom** | <code>method</code> | <code>dart FutureSignal<S> createComputedFrom(List<ReadonlySignal<A>> signals, Future<S> Function(List<A> args) fn, {S? initialValue, String? debugLabel, bool lazy = true})</code> | Async Computed is syntax sugar around [FutureSignal](/types/futuresignal). |
| **createComputedAsync** | <code>method</code> | <code>dart FutureSignal<S> createComputedAsync(Future<S> Function() fn, {S? initialValue, String? debugLabel, List<ReadonlySignal<dynamic>> dependencies = const [], bool lazy = true})</code> | Async Computed is syntax sugar around [FutureSignal](/types/futuresignal). |
| **createFutureSignal** | <code>method</code> | <code>dart FutureSignal<S> createFutureSignal(Future<S> Function() fn, {S? initialValue, String? debugLabel, List<ReadonlySignal<dynamic>> dependencies = const [], bool lazy = true})</code> | Create a signal from a future |
| **createStreamSignal** | <code>method</code> | <code>dart StreamSignal<S> createStreamSignal(Stream<S> Function() callback, {S? initialValue, String? debugLabel, List<ReadonlySignal<dynamic>> dependencies = const [], void Function()? onDone, bool? cancelOnError, bool lazy = true})</code> | Create a signals from a stream |
| **createAsyncSignal** | <code>method</code> | <code>dart AsyncSignal<S> createAsyncSignal(AsyncState<S> value, {String? debugLabel})</code> | Create a signal holding an async value |
| **createSignal** | <code>method</code> | <code>dart FlutterSignal<V> createSignal(V val, {String? debugLabel})</code> | Create a <code>signal<T></code> and watch for changes |
| **createListSignal** | <code>method</code> | <code>dart ListSignal<V> createListSignal(List<V> list, {String? debugLabel})</code> | Create a [ListSignal](/types/listsignal) <code><T></code> and watch for changes |
| **createSetSignal** | <code>method</code> | <code>dart SetSignal<V> createSetSignal(Set<V> set, {String? debugLabel})</code> | Create a [SetSignal](/types/setsignal) <code><T></code> and watch for changes |
| **createQueueSignal** | <code>method</code> | <code>dart QueueSignal<V> createQueueSignal(Queue<V> queue, {String? debugLabel})</code> | Create a [QueueSignal](/types/queuesignal) <code><T></code> and watch for changes |
| **createMapSignal** | <code>method</code> | <code>dart MapSignal<K, V> createMapSignal(Map<K, V> value, {String? debugLabel})</code> | Create a [MapSignal](/types/mapsignal) <code><K, V></code> and watch for changes |
| **createComputed** | <code>method</code> | <code>dart FlutterComputed<V> createComputed(V Function() cb, {String? debugLabel})</code> | Create a <code>computed<T></code> and watch for changes |
| **bindSignal** | <code>method</code> | <code>dart S bindSignal(S val)</code> | Bind an existing <code>signal<T></code> and watch for changes |
| **unbindSignal** | <code>method</code> | <code>dart S unbindSignal(S val)</code> | Unbind an existing <code>signal<T></code> changes |
| **watchSignal** | <code>method</code> | <code>dart V watchSignal(S val)</code> | Watch signal value |
| **unwatchSignal** | <code>method</code> | <code>dart V unwatchSignal(S val)</code> | Unwatch an existing <code>signal<T></code> value changes |
| **listenSignal** | <code>method</code> | <code>dart void listenSignal(ReadonlySignal<dynamic> target, void Function() callback, {String? debugLabel})</code> | Watch signal value |
| **unlistenSignal** | <code>method</code> | <code>dart void unlistenSignal(ReadonlySignal<dynamic> target, void Function() callback)</code> | Stop listening to a signal value |
| **createEffect** | <code>method</code> | <code>dart EffectCleanup createEffect(dynamic Function() cb, {String? debugLabel, dynamic Function()? onDispose})</code> | Create a effect. |
| **clearSignalsAndEffects** | <code>method</code> | <code>dart void clearSignalsAndEffects()</code> | Reset all stored signals and effects |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> |  |

## References

The **SignalsMixin** type is referenced and used in the following pages:

* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SignalStatefulWidget](/packages/signals_flutter/extensions/signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalsAvoidDeprecatedSignalsMixin](/packages/signals_lint/flutter/signals-avoid-deprecated-signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [MigrateSignalsMixinToSignalStatefulWidget](/packages/signals_lint/flutter/migrate-signals-mixin-to-signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SignalStatefulWidget](/packages/signals/extensions/signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [signals](/packages/signals)
* [signals-lint AI Skill](/skills/signals-lint) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

