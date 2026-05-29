---
title: "Type: computedFrom"
description: "API reference and details for computedFrom from signals.dart."
---

# computedFrom

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Function: computedFrom

```dart
FutureSignal<T> computedFrom(List<ReadonlySignal<A>> signals, Future<T> Function(List<A> args) fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```

Create an asynchronous computed signal by explicitly declaring its dependencies.

<code>computedFrom</code> takes a list of **signals** and a **callback** function to compute
the value of the signal every time one of the declared **signals** changes.

Unlike [computedAsync](/types/computedasync), which tracks dependencies implicitly, <code>computedFrom</code> is
immune to the **Async Gap Gotcha** because all tracking is declared upfront.

### Why use <code>computedFrom</code>?
When writing asynchronous code, Dart yields control at every <code>await</code> keyword.
Implicit tracking (in [computedAsync](/types/computedasync) or [computed](/types/computed)) cannot track reads that happen
*after* an asynchronous gap because the active reactive reader context is lost.

<code>computedFrom</code> solves this by:
1. Subscribing to the list of input **signals** synchronously.
2. Reading their latest values synchronously.
3. Passing those resolved values into your callback as an ordered list of arguments.

### Example: Fetching user details when an ID signal changes

```dart
final userId = signal(123);

// The callback receives the current values of the declared signals
final userProfile = computedFrom([userId], (args) async {
  final currentId = args.first; // Type-safe list of dependencies
  return fetchUserProfileFromServer(currentId);
});

// userProfile is a FutureSignal<UserProfile> which can be pattern-matched
effect(() {
  userProfile.value.map(
    data: (profile) => print('Loaded profile: ${profile.name}'),
    error: (err, stack) => print('Error: $err'),
    loading: () => print('Fetching profile...'),
  );
});

// Updating userId automatically triggers a new asynchronous fetch
userId.value = 456;
```

## References

The **computedFrom** type is referenced and used in the following pages:

* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [AsyncState](/packages/signals_flutter/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Computed](/packages/signals_flutter/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncState](/packages/signals_core/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Computed](/packages/signals_core/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [AsyncState](/packages/signals/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Computed](/packages/signals/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

