---
title: SignalsMixin
description: A State mixin that automatically handles subscription and cleanup of signals.
---

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


### Methods

<details>
<summary> View Methods </summary>

##### <a name="disposesignal"></a>`void disposeSignal(int id)`

Dispose and remove signal

##### <a name="createcomputedfrom"></a>`FutureSignal<S> createComputedFrom(List<ReadonlySignal<A>> signals, Future<S> Function(List<A> args) fn, {S? initialValue, String? debugLabel, bool lazy = true})`

Async Computed is syntax sugar around [FutureSignal](/types/futuresignal).

_Inspired by [computedFrom](https://ngxtension.netlify.app/utilities/signals/computed-from/) from Angular NgExtension._

computedFrom takes a list of **signals** and a **callback** function to
compute the value of the signal every time one of the **signals** changes.

```dart
final movieId = signal('id');
late final movie = computedFrom(args, ([movieId]) => fetchMovie(args.first));
```

Since all dependencies are passed in as arguments there is no need to worry about calling the signals before any async gaps with await.

##### <a name="createcomputedasync"></a>`FutureSignal<S> createComputedAsync(Future<S> Function() fn, {S? initialValue, String? debugLabel, List<ReadonlySignal<dynamic>> dependencies = const [], bool lazy = true})`

Async Computed is syntax sugar around [FutureSignal](/types/futuresignal).

_Inspired by [computedAsync](https://ngxtension.netlify.app/utilities/signals/computed-async/) from Angular NgExtension._

computedAsync takes a **callback** function to compute the value
of the signal. This callback is converted into a [Computed](/types/computed) signal.

```dart
final movieId = signal('id');
late final movie = computedAsync(() => fetchMovie(movieId()));
```

**It is important that signals are called before any async gaps with await.**

Any signal that is read inside the callback will be tracked as a dependency and the computed signal will be re-evaluated when any of the dependencies change.

##### <a name="createfuturesignal"></a>`FutureSignal<S> createFutureSignal(Future<S> Function() fn, {S? initialValue, String? debugLabel, List<ReadonlySignal<dynamic>> dependencies = const [], bool lazy = true})`

Create a signal from a future

##### <a name="createstreamsignal"></a>`StreamSignal<S> createStreamSignal(Stream<S> Function() callback, {S? initialValue, String? debugLabel, List<ReadonlySignal<dynamic>> dependencies = const [], void Function()? onDone, bool? cancelOnError, bool lazy = true})`

Create a signals from a stream

##### <a name="createasyncsignal"></a>`AsyncSignal<S> createAsyncSignal(AsyncState<S> value, {String? debugLabel})`

Create a signal holding an async value

##### <a name="createsignal"></a>`FlutterSignal<V> createSignal(V val, {String? debugLabel})`

Create a <code>signal<T></code> and watch for changes

##### <a name="createlistsignal"></a>`ListSignal<V> createListSignal(List<V> list, {String? debugLabel})`

Create a [ListSignal](/types/listsignal) <code><T></code> and watch for changes

##### <a name="createsetsignal"></a>`SetSignal<V> createSetSignal(Set<V> set, {String? debugLabel})`

Create a [SetSignal](/types/setsignal) <code><T></code> and watch for changes

##### <a name="createqueuesignal"></a>`QueueSignal<V> createQueueSignal(Queue<V> queue, {String? debugLabel})`

Create a [QueueSignal](/types/queuesignal) <code><T></code> and watch for changes

##### <a name="createmapsignal"></a>`MapSignal<K, V> createMapSignal(Map<K, V> value, {String? debugLabel})`

Create a [MapSignal](/types/mapsignal) <code><K, V></code> and watch for changes

##### <a name="createcomputed"></a>`FlutterComputed<V> createComputed(V Function() cb, {String? debugLabel})`

Create a <code>computed<T></code> and watch for changes

##### <a name="bindsignal"></a>`S bindSignal(S val)`

Bind an existing <code>signal<T></code> and watch for changes

##### <a name="unbindsignal"></a>`S unbindSignal(S val)`

Unbind an existing <code>signal<T></code> changes

##### <a name="watchsignal"></a>`V watchSignal(S val)`

Watch signal value

##### <a name="unwatchsignal"></a>`V unwatchSignal(S val)`

Unwatch an existing <code>signal<T></code> value changes

##### <a name="listensignal"></a>`void listenSignal(ReadonlySignal<dynamic> target, void Function() callback, {String? debugLabel})`

Watch signal value

##### <a name="unlistensignal"></a>`void unlistenSignal(ReadonlySignal<dynamic> target, void Function() callback)`

Stop listening to a signal value

##### <a name="createeffect"></a>`EffectCleanup createEffect(dynamic Function() cb, {String? debugLabel, dynamic Function()? onDispose})`

Create a effect.

Do not call inside the build method.

Calling this method in build() will create a new
effect every render.

##### <a name="clearsignalsandeffects"></a>`void clearSignalsAndEffects()`

Reset all stored signals and effects

##### <a name="dispose"></a>`void dispose()`

</details>
