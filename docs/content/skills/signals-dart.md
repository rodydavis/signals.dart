---
title: signals-dart AI Skill
description: Advanced reactive state primitives, collections, mixins, and utilities of signals_core. (v7.0.0)
---

# signals-dart AI Developer Skill

> Advanced reactive state primitives, collections, mixins, and utilities of signals_core. (v7.0.0)

---

### 📥 Installation

To instantly install this AI developer skill into your local workspace under `.agents/skills/`, run:

```bash
npx skills add rodydavis/signals.dart/tree/main/skills/signals-dart
```

---

## 📄 SKILL.md Preview

````plaintext
# signals-dart API Best Practices & Primitive Definitions

This guide outlines advanced state management primitives, reactive collections, async features, and value options semantics in `package:signals-dart` (version `7.0.0`).

---

## 📊 Reactive Primitives Directory

The following table summarizes all available reactive primitives and widgets. Click on any primitive's name to view its detailed documentation, standard usage, and examples.

| Primitive | Category | Description |
| :--- | :--- | :--- |
| [signal](primitives/signal.md) | Primitive | An observable box containing a mutable value. Reading its value registers a dependency implicitly. |
| [Async Signal](primitives/Async Signal.md) | Primitive | An async Signal Object mapping loading, data success, and error failure states cleanly. |
| [Computed](primitives/Computed.md) | Derived | Combine multiple signals into a derived, lazily-cached, read-only signal. |
| [AsyncComputed](primitives/AsyncComputed.md) | Derived | Asynchronous Computed is syntax sugar around FutureSignal for async dependent tasks. |
| [linkedSignal](primitives/linkedSignal.md) | Writable Derived | A writable derived signal that allows manual updates and resets to a source computation on mutation. |
| [ChangeStackSignal](primitives/ChangeStackSignal.md) | Utilities | Track signal values over time, exposing simple, robust undo/redo capabilities. |
| [IterableSignal](primitives/IterableSignal.md) | Collections | Iterable signals wrap collection items lazy-traversals mapped to custom reactivity layer. |
| [ListSignal](primitives/ListSignal.md) | Collections | Optimized list wrapper proxying standard operations to support element-level reactivity. |
| [MapSignal](primitives/MapSignal.md) | Collections | Granular map wrapper supporting isolated dictionary element lookup triggers. |
| [SetSignal](primitives/SetSignal.md) | Collections | Custom set wrapper ignoring duplicate entries and triggering mutations on unique inserts. |
| [FutureSignal](primitives/FutureSignal.md) | Primitive | Bypasses stream subscription overhead and resolves the future-evaluation loop elegantly. |
| [StreamSignal](primitives/StreamSignal.md) | Primitive | Dynamic, lifecycle-safe, self-disposing stream listener mapping to async loading/data/error states. |
| [Signal Container (Read-only)](primitives/Signal Container (Read-only).md) | Utilities | Returns a read-only parameterized caching Signal Container. |
| [Signal Container](primitives/Signal Container.md) | Utilities | Returns a mutable parameterized caching Signal Container. |
| [Value Signal](primitives/Value Signal.md) | Utilities | Custom Value Signal class definition template. |

---

## 📦 Parsed Library API Directory

The following table summarizes all available classes, functions, and extensions exported by the package. Click on any API's name to view its detailed signature, members, and documentation.

| API | Type | Description |
| :--- | :--- | :--- |
| [TimerSignal](api/TimerSignal.md) | `class` | Emit recurring TimerSignalEvent aka [AsyncSignal](/types/asyncsignal) |
| [TimerSignalDurationUtils](api/TimerSignalDurationUtils.md) | `extension` | Expose Duration as a [TimerSignal](/types/timersignal) |
| [timerSignal](api/timerSignal.md) | `function` | Create a [TimerSignal](/types/timersignal) |
| [ListSignal](api/ListSignal.md) | `class` | A reactive [Signal](/types/signal) that holds a List and implements the List interface. |
| [listSignal](api/listSignal.md) | `function` | Creates a [ListSignal](/types/listsignal) initialized with the provided list. |
| [SignalListUtils](api/SignalListUtils.md) | `extension` | Utility extension methods on List to convert them to [ListSignal](/types/listsignal)s. |
| [ListSignalOptions](api/ListSignalOptions.md) | `class` | Configuration options for a [ListSignal](/types/listsignal). |
| [MapSignal](api/MapSignal.md) | `class` | A reactive [Signal](/types/signal) that holds a Map and implements the Map interface. |
| [mapSignal](api/mapSignal.md) | `function` | Creates a [MapSignal](/types/mapsignal) initialized with the provided map. |
| [SignalMapUtils](api/SignalMapUtils.md) | `extension` | Utility extension methods on Map to convert them to [MapSignal](/types/mapsignal)s. |
| [MapSignalOptions](api/MapSignalOptions.md) | `class` | Configuration options for a [MapSignal](/types/mapsignal). |
| [SetSignal](api/SetSignal.md) | `class` | A reactive [Signal](/types/signal) that holds a Set and implements the Set interface. |
| [setSignal](api/setSignal.md) | `function` | Creates a [SetSignal](/types/setsignal) initialized with the provided set. |
| [SignalSetUtils](api/SignalSetUtils.md) | `extension` | Utility extension methods on Set to convert them to [SetSignal](/types/setsignal)s. |
| [SetSignalOptions](api/SetSignalOptions.md) | `class` | Configuration options for a [SetSignal](/types/setsignal). |
| [QueueSignal](api/QueueSignal.md) | `class` | A [Signal](/types/signal) that holds a Queue. |
| [queueSignal](api/queueSignal.md) | `function` | Creates a [QueueSignal](/types/queuesignal) with the given list (Queue). |
| [SignalQueueUtils](api/SignalQueueUtils.md) | `extension` | Utility extension methods on Queue to convert them to [QueueSignal](/types/queuesignal)s. |
| [QueueSignalOptions](api/QueueSignalOptions.md) | `class` | Configuration options for a [QueueSignal](/types/queuesignal). |
| [IterableSignal](api/IterableSignal.md) | `class` | A reactive [Signal](/types/signal) that holds an Iterable and implements the Iterable interface. |
| [iterableSignal](api/iterableSignal.md) | `function` | Creates an [IterableSignal](/types/iterablesignal) holding the provided iterable. |
| [SignalIterableUtils](api/SignalIterableUtils.md) | `extension` | Utility extension methods on Iterable to convert them to [IterableSignal](/types/iterablesignal)s. |
| [IterableSignalOptions](api/IterableSignalOptions.md) | `class` | Configuration options for a [IterableSignal](/types/iterablesignal). |
| [ChangeStackSignal](api/ChangeStackSignal.md) | `class` | A reactive [Signal](/types/signal) that records its history of values, allowing undo and redo operations. |
| [changeStack](api/changeStack.md) | `function` | Creates a [ChangeStackSignal](/types/changestacksignal) initialized with the provided value. |
| [ChangeSignalOptions](api/ChangeSignalOptions.md) | `class` | Configuration options for a [ChangeStackSignal](/types/changestacksignal). |
| [TrackedSignal](api/TrackedSignal.md) | `class` | A signal that stores the initial and previous value |
| [trackedSignal](api/trackedSignal.md) | `function` | Create a signal that stores the initial and previous value |
| [TrackedSignalOptions](api/TrackedSignalOptions.md) | `class` | Configuration options for a [TrackedSignal](/types/trackedsignal). |
| [SignalContainer](api/SignalContainer.md) | `class` | Signal container used to create signals based on args |
| [readonlySignalContainer](api/readonlySignalContainer.md) | `function` | Create a signal container used to instance signals based on args |
| [signalContainer](api/signalContainer.md) | `function` | Create a signal container used to instance signals based on args |
| [computedContainer](api/computedContainer.md) | `function` | Create a signal container for computed signals based on args. |
| [futureSignalContainer](api/futureSignalContainer.md) | `function` | Create a signal container for FutureSignals based on args. |
| [streamSignalContainer](api/streamSignalContainer.md) | `function` | Create a signal container for StreamSignals based on args. |
| [SignalsError](api/SignalsError.md) | `class` | Signal usage error |
| [SignalsReadAfterDisposeError](api/SignalsReadAfterDisposeError.md) | `class` | Error to throw if a signal is read after it is disposed |
| [LazySignalInitializationError](api/LazySignalInitializationError.md) | `class` | Lazy signal must value value set before it is read |
| [SignalsWriteAfterDisposeError](api/SignalsWriteAfterDisposeError.md) | `class` | Error to throw if a signal is written to after it is disposed |
| [EffectCycleDetectionError](api/EffectCycleDetectionError.md) | `class` | Cycle detection usually means you have updated |
| [EffectOptions](api/EffectOptions.md) | `class` | Configuration options for reactive [Effect](/types/effect)s extending signals.EffectOptions. |
| [ReadonlySignalOptions](api/ReadonlySignalOptions.md) | `class` | Configuration options for a [ReadonlySignal](/types/readonlysignal) extending signals.ReadonlySignalOptions. |
| [SignalOptions](api/SignalOptions.md) | `class` | Configuration options for a [Signal](/types/signal) extending signals.SignalOptions. |
| [ComputedOptions](api/ComputedOptions.md) | `class` | Configuration options for a [Computed](/types/computed) extending signals.ComputedOptions. |
| [SignalsObserver](api/SignalsObserver.md) | `class` | You can observe all signal values in the dart application by providing an implementation of <code>SignalsObserver</code>: |
| [LoggingSignalsObserver](api/LoggingSignalsObserver.md) | `class` | Logs all signals and computed changes to the console. |
| [Effect](api/Effect.md) | `class` | An <code>Effect</code> is the passive consumer of the reactive model. It allows you to run arbitrary side-effects (such as logging, database writes, or UI rendering updates) whenever any of its tracked dependencies mutate. |
| [effect](api/effect.md) | `function` | The <code>effect</code> function is the last piece that makes everything reactive. When you access a signal inside its callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [<code>computed(fn)</code>](/core/computed). By default all updates are lazy, so nothing will update until you access a signal inside <code>effect</code>. |
| [Computed](api/Computed.md) | `class` | A <code>Computed</code> signal represents derived reactive state. It combines the values of multiple dependency signals into a new read-only signal, automatically re-evaluating whenever any of its dependencies mutate. |
| [computed](api/computed.md) | `function` | Data is often derived from other pieces of existing data. The <code>computed</code> function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value. |
| [Signal](api/Signal.md) | `class` | Simple writeable signal |
| [signal](api/signal.md) | `function` | A <code>Signal</code> is a reactive container for a value that changes over time. It forms the bedrock of the reactive framework, allowing fine-grained, glitch-free propagation of state updates to dependent computeds and effects. |
| [lazySignal](api/lazySignal.md) | `function` | Lazy signal that can be created with type T that |
| [batch](api/batch.md) | `function` | The <code>batch</code> function allows you to combine multiple signal writes into one single update that is triggered at the end when the callback completes. |
| [untracked](api/untracked.md) | `function` | In case when you're receiving a callback that can read some signals, but you don't want to subscribe to them, you can use <code>untracked</code> to prevent any subscriptions from happening. |
| [onSignalRead](api/onSignalRead.md) | `variable` | Global callback when any signal is read. |
| [ReadonlySignalMixin](api/ReadonlySignalMixin.md) | `mixin` | Readonly signal mixin for adding addition helper methods |
| [readonly](api/readonly.md) | `function` | Creates a new read-only signal initialized with value. |
| [SignalsAutoDisposeMixin](api/SignalsAutoDisposeMixin.md) | `mixin` | Mixin to enable autodispose on a signal |
| [LinkedSignalPreviousState](api/LinkedSignalPreviousState.md) | `class` | Previous state of a [LinkedSignal](/types/linkedsignal), containing both the source value |
| [LinkedSignalOptions](api/LinkedSignalOptions.md) | `class` | Options for creating a [LinkedSignal](/types/linkedsignal). |
| [LinkedSignal](api/LinkedSignal.md) | `class` | A highly powerful, mutable computed signal that derives its default value from an underlying source, |
| [linkedSignal](api/linkedSignal.md) | `function` | {@macro linked_signal} |
| [Connect](api/Connect.md) | `class` | A highly powerful connector utility that allows you to dynamically stream and pipe multiple asynchronous streams directly into a single reactive [Signal](/types/signal). |
| [connect](api/connect.md) | `function` | The idea for <code>connect</code> comes from Anguar Signals with RxJS: |
| [AsyncState](api/AsyncState.md) | `class` | A sealed union representing the lifecycle states of an asynchronous operation. |
| [AsyncDataReloading](api/AsyncDataReloading.md) | `class` | A loading state with a value. Signals the query conditions that led to the data |
| [AsyncDataRefreshing](api/AsyncDataRefreshing.md) | `class` | A loading state with a value. Signals the query conditions that led to the data |
| [AsyncData](api/AsyncData.md) | `class` | State for an [AsyncState](/types/asyncstate) with a value |
| [AsyncErrorReloading](api/AsyncErrorReloading.md) | `class` | A loading state with an error. Signal the query conditions that led to the error |
| [AsyncErrorRefreshing](api/AsyncErrorRefreshing.md) | `class` | A loading state with an error. Signal the query conditions that led to the error |
| [AsyncError](api/AsyncError.md) | `class` | State for an [AsyncState](/types/asyncstate) with an error |
| [AsyncLoading](api/AsyncLoading.md) | `class` | State for an [AsyncState](/types/asyncstate) with a loading state |
| [AsyncSignal](api/AsyncSignal.md) | `class` | A highly powerful [Signal](/types/signal) specifically designed for manual, imperative asynchronous state management. |
| [asyncSignal](api/asyncSignal.md) | `function` | Helper function to create an [AsyncSignal](/types/asyncsignal) initialized with an [AsyncState](/types/asyncstate). |
| [AsyncSignalOptions](api/AsyncSignalOptions.md) | `class` | Configuration options for an [AsyncSignal](/types/asyncsignal). |
| [StreamSignal](api/StreamSignal.md) | `class` | Stream signals wrap a standard asynchronous Stream and bridge it into the reactive state framework, exposing its emissions as a reactive [AsyncState](/types/asyncstate). |
| [streamSignal](api/streamSignal.md) | `function` | Stream signals can be created by extension or method. |
| [FutureSignal](api/FutureSignal.md) | `class` | Future signals wrap a standard asynchronous Future and bridge it into the reactive state framework, exposing its lifecycle and value as a reactive [AsyncState](/types/asyncstate). |
| [futureSignal](api/futureSignal.md) | `function` | Future signals can be created by extension or method. |
| [computedFrom](api/computedFrom.md) | `function` | Create an asynchronous computed signal by explicitly declaring its dependencies. |
| [computedAsync](api/computedAsync.md) | `function` | Create an asynchronous computed signal with implicit dependency tracking. |
| [SignalObjectUtils](api/SignalObjectUtils.md) | `extension` | Connivent methods for signal values |
| [SignalFutureUtils](api/SignalFutureUtils.md) | `extension` | Extension on future to provide helpful methods for signals |
| [SignalStreamUtils](api/SignalStreamUtils.md) | `extension` | Extension on Stream to provide convenient utilities to convert streams into reactive signals. |
| [ReadonlySignalUtils](api/ReadonlySignalUtils.md) | `extension` | Utility extensions on [ReadonlySignal](/types/readonlysignal) to bridge reactive programming with asynchronous streams and select sub-states. |
| [WriteableSignalUtils](api/WriteableSignalUtils.md) | `extension` | Utility extensions on [Signal](/types/signal) providing functional programming wrappers like React-style hooks destructuring. |
| [AsyncSignalState](api/AsyncSignalState.md) | `extension` | Extensions for [Signal<AsyncState<T>>] |
| [BoolSignalExtension](api/BoolSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<bool>](/types/readonlysignal), enabling direct reactive logical conjunction (&), disjunction (|), and exclusive or (^) operations. |
| [SignalBoolExtensions](api/SignalBoolExtensions.md) | `extension` | Utility extension on bool to easily lift a boolean into a reactive [Signal](/types/signal). |
| [ComparableSignalExtension](api/ComparableSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<Comparable<T>>] |
| [SignalComparableExtensions](api/SignalComparableExtensions.md) | `extension` | Extensions for Comparable<T> |
| [DoubleSignalExtension](api/DoubleSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<double>](/types/readonlysignal), enabling direct reactive arithmetic and rounding operations on double signals. |
| [SignalDoubleExtensions](api/SignalDoubleExtensions.md) | `extension` | Utility extension on double to easily lift a double into a reactive [Signal](/types/signal). |
| [IntSignalExtension](api/IntSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<int>](/types/readonlysignal) |
| [SignalIntExtensions](api/SignalIntExtensions.md) | `extension` | Extensions for int |
| [ReadonlyIterableSignalExtension](api/ReadonlyIterableSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<Iterable>](/types/readonlysignal) |
| [SignalIterableExtensions](api/SignalIterableExtensions.md) | `extension` | Extensions for Iterable<E> |
| [ReadonlyListSignalExtension](api/ReadonlyListSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<List>](/types/readonlysignal) |
| [ListSignalExtension](api/ListSignalExtension.md) | `extension` | Helper extensions for [Signal<List>](/types/signal) |
| [SignalListExtensions](api/SignalListExtensions.md) | `extension` | Extensions for List<E> |
| [ReadonlyMapSignalExtension](api/ReadonlyMapSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<Map>](/types/readonlysignal) |
| [MapSignalExtension](api/MapSignalExtension.md) | `extension` | Helper extensions for [Signal<Map>](/types/signal) |
| [SignalMapExtensions](api/SignalMapExtensions.md) | `extension` | Extensions for Map<E> |
| [NumSignalExtension](api/NumSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<num>](/types/readonlysignal), providing convenient reactive math and comparison operations without needing to manually unwrap <code>.value</code>. |
| [SignalNumExtensions](api/SignalNumExtensions.md) | `extension` | Utility extension on num to easily lift a number into a reactive [Signal](/types/signal). |
| [PatternSignalExtension](api/PatternSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<Pattern>](/types/readonlysignal) |
| [SignalPatternExtensions](api/SignalPatternExtensions.md) | `extension` | Extensions for Pattern |
| [ReadonlySetSignalExtension](api/ReadonlySetSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<Set<E>>], providing delegators to compute set operations reactively. |
| [SetSignalExtension](api/SetSignalExtension.md) | `extension` | Helper extensions for [Signal<Set<E>>] to perform mutation operations that automatically notify downstreams. |
| [SignalSetExtensions](api/SignalSetExtensions.md) | `extension` | Utility extension on Set to easily lift a set into a reactive [Signal](/types/signal). |
| [StringSignalExtension](api/StringSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<String>](/types/readonlysignal) |
| [SignalStringExtensions](api/SignalStringExtensions.md) | `extension` | Extensions for String |
| [EnumSignalExtension](api/EnumSignalExtension.md) | `extension` | Helper extensions for [ReadonlySignal<Enum>](/types/readonlysignal) |
| [SignalEnumExtensions](api/SignalEnumExtensions.md) | `extension` | Extensions for Enum |
| [SignalFunctionExtensions](api/SignalFunctionExtensions.md) | `extension` | Utility extension on a getter function <code>T Function()</code> to instantly convert it into a [Computed](/types/computed) signal. |
| [EventSinkSignalMixin](api/EventSinkSignalMixin.md) | `class` | A mixin that implements the standard EventSink interface for a [Signal](/types/signal) |
| [SinkSignalMixin](api/SinkSignalMixin.md) | `class` | A mixin that implements the standard Sink interface for a [Signal](/types/signal). |
| [StreamSignalMixin](api/StreamSignalMixin.md) | `class` | A mixin that implements the standard Stream interface for a [ReadonlySignal](/types/readonlysignal). |
| [ChangeStackSignalMixin](api/ChangeStackSignalMixin.md) | `mixin` | A mixin that adds undo, redo, and state history replay capabilities to a [Signal](/types/signal). |
| [IterableSignalMixin](api/IterableSignalMixin.md) | `class` | A mixin that adds reactive <code>Iterable</code> methods and properties to a [Signal](/types/signal) |
| [ListSignalMixin](api/ListSignalMixin.md) | `class` | A mixin that adds reactive <code>List</code> methods and operators to a [Signal](/types/signal) |
| [SetSignalMixin](api/SetSignalMixin.md) | `class` | A mixin that adds reactive <code>Set</code> methods and operations to a [Signal](/types/signal) |
| [MapSignalMixin](api/MapSignalMixin.md) | `class` | A mixin that adds reactive <code>Map</code> methods and operators directly to a [Signal](/types/signal). |
| [QueueSignalMixin](api/QueueSignalMixin.md) | `class` | A mixin that adds reactive <code>Queue</code> methods and operations to a [Signal](/types/signal) |
| [TrackedSignalMixin](api/TrackedSignalMixin.md) | `mixin` | A mixin that adds tracking for the initial and previous values to a [Signal](/types/signal). |
| [PersistedSignal](api/PersistedSignal.md) | `class` | A <code>Signal</code> whose value is persistently stored in a key-value database. |
| [PersistedSignalMixin](api/PersistedSignalMixin.md) | `mixin` | A mixin that adds local persistence capabilities to a standard [Signal](/types/signal). |
| [PersistedSignalOptions](api/PersistedSignalOptions.md) | `class` | Configuration options for a [PersistedSignal](/types/persistedsignal). |
| [PersistedBoolSignal](api/PersistedBoolSignal.md) | `class` | A <code>PersistedSignal</code> that stores a boolean value. |
| [PersistedNullableBoolSignal](api/PersistedNullableBoolSignal.md) | `class` | A <code>PersistedSignal</code> that stores a nullable string value. |
| [SignalsKeyValueStore](api/SignalsKeyValueStore.md) | `class` | An abstract class defining the persistence adapter contract for [PersistedSignal](/types/persistedsignal). |
| [SignalsInMemoryKeyValueStore](api/SignalsInMemoryKeyValueStore.md) | `class` | An in-memory, volatile implementation of [SignalsKeyValueStore](/types/signalskeyvaluestore). |
| [PersistedEnumSignal](api/PersistedEnumSignal.md) | `class` | A <code>PersistedSignal</code> that stores an enum value. |
| [PersistedNullableEnumSignal](api/PersistedNullableEnumSignal.md) | `class` | A <code>PersistedSignal</code> that stores a nullable enum value. |
| [PersistedNumSignal](api/PersistedNumSignal.md) | `class` | A <code>PersistedSignal</code> that stores a numeric value. |
| [PersistedNullableNumSignal](api/PersistedNullableNumSignal.md) | `class` | A <code>PersistedSignal</code> that stores a nullable numeric value. |
| [PersistedIntSignal](api/PersistedIntSignal.md) | `class` | A <code>PersistedSignal</code> that stores an integer value. |
| [PersistedNullableIntSignal](api/PersistedNullableIntSignal.md) | `class` | A <code>PersistedSignal</code> that stores a nullable integer value. |
| [PersistedStringSignal](api/PersistedStringSignal.md) | `class` | A <code>PersistedSignal</code> that stores a string value. |
| [PersistedNullableStringSignal](api/PersistedNullableStringSignal.md) | `class` | A <code>PersistedSignal</code> that stores a nullable string value. |
| [PersistedDoubleSignal](api/PersistedDoubleSignal.md) | `class` | A <code>PersistedSignal</code> that stores an double value. |
| [PersistedNullableDoubleSignal](api/PersistedNullableDoubleSignal.md) | `class` | A <code>PersistedSignal</code> that stores a nullable double value. |
````
