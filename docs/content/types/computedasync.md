---
title: "Type: computedAsync"
description: "API reference and details for computedAsync from signals.dart."
---

# computedAsync

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Function: computedAsync

```dart
FutureSignal<T> computedAsync(Future<T> Function() fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```

Create an asynchronous computed signal with implicit dependency tracking.

<code>computedAsync</code> takes an asynchronous **callback** function to compute the value
of the signal. Any signal read *synchronously* inside the callback is automatically
tracked as a dependency, and the computed signal is re-evaluated when any of those
dependencies change.

### ⚠️ The Async Gap Gotcha
Because Dart yields execution at every <code>await</code> expression, the reactive context that
automatically tracks reads is lost after an asynchronous gap.

**Rule:** All signal values MUST be read synchronously *before* the first <code>await</code> statement.

#### ❌ Incorrect Pattern (Signal read after await is NOT tracked):
```dart
final movie = computedAsync(() async {
  await Future.delayed(Duration(milliseconds: 100));
  // BUG: movieId is read AFTER an async gap.
  // Changes to movieId will NOT re-evaluate this computedAsync!
  return fetchMovie(movieId.value);
});
```

####  Correct Pattern (Read dependencies synchronously first):
```dart
final movie = computedAsync(() async {
  // Capture all dependency values synchronously at the start!
  final currentId = movieId.value;

  await Future.delayed(Duration(milliseconds: 100));
  // Use the captured local variable after the async gap
  return fetchMovie(currentId);
});
```

### Advanced Example: Search Query with Debouncing

```dart
final searchQuery = signal('');

final searchResults = computedAsync(() async {
  // Capture dependency synchronously
  final query = searchQuery.value;

  if (query.isEmpty) return <SearchResult>[];

  // Debounce: Wait 300ms before making the API request
  await Future.delayed(Duration(milliseconds: 300));

  return performSearchApiCall(query);
});
```

## References

The **computedAsync** type is referenced and used in the following pages:

* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [AsyncState](/packages/signals_flutter/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Computed](/packages/signals_flutter/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncState](/packages/signals_core/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Computed](/packages/signals_core/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [AsyncState](/packages/signals/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Computed](/packages/signals/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

