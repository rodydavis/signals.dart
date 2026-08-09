# function `streamSignal`

Stream signals can be created by extension or method.

### streamSignal

```dart
final stream = () async* {
    yield 1;
};
final s = streamSignal(() => stream);
```

### toSignal()

```dart
final stream = () async* {
    yield 1;
};
final s = stream.toSignal();
```

## .value, .peek()

Returns [<code>AsyncState<T></code>](/dart/async/state) for the value and can handle the various states.

The <code>value</code> getter returns the value of the stream if it completed successfully.

> .peek() can also be used to not subscribe in an effect

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
final value = s.value.value; // 1 or null
```

## .reset()

The <code>reset</code> method resets the stream to its initial state to recall on the next evaluation.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.reset();
```

## .refresh()

Refresh the stream value by setting <code>isLoading</code> to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.refresh();
print(s.value.isLoading); // true
```

## .reload()

Reload the stream value by setting the state to <code>AsyncLoading</code> and pass in the value or error as data.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.reload();
print(s.value is AsyncLoading); // true
```

## Dependencies

By default the callback will be called once and the stream will be cached unless a signal is read in the callback.

```dart
final count = signal(0);
final s = streamSignal(() async* {
    final value = count();
    yield value;
});

await s.future; // 0
count.value = 1;
await s.future; // 1
```

If there are signals that need to be tracked across an async gap then use the <code>dependencies</code> when creating the <code>streamSignal</code> to [<code>reset</code>](#.reset()) every time any signal in the dependency array changes.

```dart
final count = signal(0);
final s = streamSignal(
    () async* {
        final value = count();
        yield value;
    },
    dependencies: [count],
);
s.value; // state with count 0
count.value = 1; // resets the future
s.value; // state with count 1
```

---

## Signature

```dart
StreamSignal<T> streamSignal(Stream<T> Function() callback, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(onDone: ...) instead') void Function()? onDone, @Deprecated('Use options: AsyncSignalOptions(cancelOnError: ...) instead') bool? cancelOnError, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```

