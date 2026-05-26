---
title: Computed
description: Create an asynchronous computed signal with implicit dependency tracking.
---

## computedAsync

Create an asynchronous computed signal with implicit dependency tracking.

`computedAsync` takes an asynchronous **callback** function to compute the value
of the signal. Any signal read *synchronously* inside the callback is automatically
tracked as a dependency, and the computed signal is re-evaluated when any of those
dependencies change.

### ⚠️ The Async Gap Gotcha
Because Dart yields execution at every `await` expression, the reactive context that
automatically tracks reads is lost after an asynchronous gap.

**Rule:** All signal values MUST be read synchronously *before* the first `await` statement.

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


---

## computedFrom

Create an asynchronous computed signal by explicitly declaring its dependencies.

`computedFrom` takes a list of **signals** and a **callback** function to compute
the value of the signal every time one of the declared **signals** changes.

Unlike [computedAsync](/packages/signals/async/computed), which tracks dependencies implicitly, `computedFrom` is
immune to the **Async Gap Gotcha** because all tracking is declared upfront.

### Why use `computedFrom`?
When writing asynchronous code, Dart yields control at every `await` keyword.
Implicit tracking (in [computedAsync](/packages/signals/async/computed) or [computed](/packages/signals/flutter/computed)) cannot track reads that happen
*after* an asynchronous gap because the active reactive reader context is lost.

`computedFrom` solves this by:
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
