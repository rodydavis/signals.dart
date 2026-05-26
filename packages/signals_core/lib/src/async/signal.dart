import 'dart:async';

import 'package:meta/meta.dart';

import '../core/signals.dart';
import '../mixins/event_sink.dart';
import 'state.dart';

/// {@template signal}
/// A [Signal] specifically designed for manual asynchronous state management.
///
/// `AsyncSignal<T>` wraps an [AsyncState<T>] (which can be loading, data, or error)
/// and provides utility getters like [.future] to easily await its completion.
///
/// ### Simple Example
/// ```dart
/// // Create an AsyncSignal starting in a loading state
/// final weather = asyncSignal<double>(AsyncState.loading());
///
/// // Update the value with data
/// weather.value = AsyncState.data(72.5); // or AsyncData(72.5)
///
/// // Or set an error
/// weather.value = AsyncState.error('Failed to fetch weather', null);
/// ```
///
/// ### Awaiting Completion with `.future`
/// Sometimes you need to await the signal until it completes with a value.
/// You can await the [.future] getter, which returns a `Future<T>` that resolves
/// when a data value is pushed, or throws when an error is set.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
///
/// // Start a background task
/// Future.delayed(Duration(seconds: 1), () => s.setValue(42));
///
/// // Await the completion of the signal!
/// final result = await s.future; // Waits and resolves to 42
/// ```
///
/// ### Direct Mutators: `setValue`, `setError`, and `setLoading`
/// Instead of manually instantiating [AsyncData] or [AsyncError], you can use
/// helper methods directly on `AsyncSignal`:
/// - `s.setValue(value)` wraps the value in `AsyncData` and notifies listeners.
/// - `s.setError(error, [stackTrace])` wraps the error in `AsyncError` and notifies.
/// - `s.setLoading()` puts the signal back into a clean `AsyncLoading` state.
///
/// ### EventSink Integration
/// `AsyncSignal` implements the standard [EventSink] interface. You can pass it directly
/// to stream listeners or use it to pipeline event streams:
/// ```dart
/// final numbers = Stream.periodic(Duration(seconds: 1), (i) => i).take(5);
/// final counter = asyncSignal<int>(AsyncState.loading());
///
/// // Pipe the stream directly into the signal!
/// numbers.listen(
///   (val) => counter.add(val),
///   onError: (err) => counter.addError(err),
///   onDone: () => counter.close(),
/// );
/// ```
///
/// @link https://dartsignals.dev/async/signal
/// {@endtemplate}
class AsyncSignal<T> extends Signal<AsyncState<T>>
    with EventSinkSignalMixin<T> {
  /// A [Signal] that stores value in [AsyncState]
  AsyncSignal(
    super.value, {
    super.options,
  }) : _initialValue = value;

  final AsyncState<T> _initialValue;
  bool _initialized = false;

  /// Internal Completer for values
  @internal
  Completer<T> completer = Completer<T>();

  /// The future of the signal completer
  Future<T> get future async {
    untracked(() => value);
    return completer.future;
  }

  /// Returns true if the signal is completed an error or data
  bool get isCompleted {
    value;
    return completer.isCompleted;
  }

  /// Set the error with optional stackTrace to [AsyncError]
  void setError(Object error, [StackTrace? stackTrace]) {
    batch(() {
      value = AsyncState.error(error, stackTrace);
      if (completer.isCompleted) completer = Completer<T>();
      completer.completeError(error, stackTrace);
      completer.future.then<void>((_) {}, onError: (_) {});
    });
  }

  /// Set the value to [AsyncData]
  void setValue(T value) {
    batch(() {
      this.value = AsyncState.data(value);
      if (completer.isCompleted) completer = Completer<T>();
      completer.complete(value);
    });
  }

  /// Set the loading state to [AsyncLoading]
  void setLoading([AsyncState<T>? state]) {
    batch(() {
      value = state ?? AsyncState.loading();
      completer = Completer<T>();
    });
  }

  /// Reset the signal to the initial value
  void reset([AsyncState<T>? value]) {
    batch(() {
      final val = value ?? _initialValue;
      this.value = val;
      _initialized = false;
      if (completer.isCompleted) completer = Completer<T>();
    });
  }

  /// Initialize the signal
  void init() async {
    if (_initialized) return;
    _initialized = true;
  }

  /// Reload the future
  Future<void> reload() async {
    value = switch (value) {
      AsyncData<T> data => AsyncDataReloading<T>(data.value),
      AsyncError<T> err => AsyncErrorReloading<T>(err.error, err.stackTrace),
      AsyncLoading<T>() => AsyncLoading<T>(),
    };
  }

  /// Refresh the future
  Future<void> refresh() async {
    value = switch (value) {
      AsyncData<T> data => AsyncDataRefreshing<T>(data.value),
      AsyncError<T> err => AsyncErrorRefreshing<T>(err.error, err.stackTrace),
      AsyncLoading<T>() => AsyncLoading<T>(),
    };
  }

  @override
  AsyncState<T> get value {
    init();
    return super.value;
  }

  /// Returns the value of the signal
  T get requireValue => super.value.requireValue;
}

/// Helper function to create an [AsyncSignal] initialized with an [AsyncState].
///
/// ### Example
/// ```dart
/// // Create an AsyncSignal initialized to a loading state
/// final counter = asyncSignal<int>(AsyncState.loading());
///
/// // Create an AsyncSignal initialized with initial data
/// final status = asyncSignal<String>(AsyncState.data('Active'));
/// ```
///
/// @link https://dartsignals.dev/async/signal
AsyncSignal<T> asyncSignal<T>(
  AsyncState<T> value, {
  AsyncSignalOptions<T>? options,
  @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
  String? debugLabel,
  @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
}) {
  return AsyncSignal<T>(
    value,
    options: options ??
        AsyncSignalOptions<T>(
          name: debugLabel,
          autoDispose: autoDispose ?? false,
        ),
  );
}

/// Configuration options for an [AsyncSignal].
class AsyncSignalOptions<T> extends SignalOptions<AsyncState<T>> {
  /// The initial value of the async signal.
  final T? initialValue;

  /// The list of dependencies to watch/listen to.
  final List<ReadonlySignal<dynamic>> dependencies;

  /// Optional function called when a stream completes.
  final void Function()? onDone;

  /// Whether to cancel the stream subscription on error.
  final bool? cancelOnError;

  /// Whether the execution is lazy.
  final bool lazy;

  /// Creates a new [AsyncSignalOptions] instance.
  const AsyncSignalOptions({
    this.initialValue,
    this.dependencies = const [],
    this.onDone,
    this.cancelOnError,
    this.lazy = true,
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
  });

  /// Creates a copy of this options with custom overrides.
  @override
  AsyncSignalOptions<T> copyWith({
    T? initialValue,
    List<ReadonlySignal<dynamic>>? dependencies,
    void Function()? onDone,
    bool? cancelOnError,
    bool? lazy,
    bool? autoDispose,
    String? name,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return AsyncSignalOptions<T>(
      initialValue: initialValue ?? this.initialValue,
      dependencies: dependencies ?? this.dependencies,
      onDone: onDone ?? this.onDone,
      cancelOnError: cancelOnError ?? this.cancelOnError,
      lazy: lazy ?? this.lazy,
      autoDispose: autoDispose ?? this.autoDispose,
      name: name ?? this.name,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AsyncSignalOptions<T>) return false;
    if (other.name != name ||
        other.autoDispose != autoDispose ||
        other.watched != watched ||
        other.unwatched != unwatched ||
        other.initialValue != initialValue ||
        other.onDone != onDone ||
        other.cancelOnError != cancelOnError ||
        other.lazy != lazy) {
      return false;
    }
    if (other.dependencies.length != dependencies.length) return false;
    for (var i = 0; i < dependencies.length; i++) {
      if (other.dependencies[i] != dependencies[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    var depHash = 0;
    for (final dep in dependencies) {
      depHash = Object.hash(depHash, dep);
    }
    return Object.hash(
      name,
      autoDispose,
      watched,
      unwatched,
      initialValue,
      onDone,
      cancelOnError,
      lazy,
      depHash,
    );
  }
}
