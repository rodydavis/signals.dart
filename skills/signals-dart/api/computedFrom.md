# function `computedFrom`

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

---

## Signature

```dart
FutureSignal<T> computedFrom(List<ReadonlySignal<A>> signals, Future<T> Function(List<A> args) fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```

