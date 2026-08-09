import 'dart:async';

import '../core/signals.dart';
import 'mutation_state.dart';

export 'mutation_state.dart';

/// {@template mutation}
/// A [Signal] for imperative, on-demand asynchronous side effects (mutations).
///
/// Where [futureSignal] models *reading* data that begins loading immediately,
/// a `MutationSignal` models *writing* data triggered by a user action (saving
/// a form, calling a `POST`/`PUT`/`DELETE`, etc). It therefore starts in an
/// extra [MutationIdle] state ("not run yet") on top of the standard
/// pending/success/error lifecycle exposed by [MutationState].
///
/// The mutation function is supplied once at creation and receives a single
/// typed argument `A`. Use a Dart record for multiple arguments, or `void`/a
/// unit type when none are needed.
///
/// ```dart
/// final addTodo = mutationSignal<Todo, void>((todo) async {
///   await api.add(todo);
/// });
///
/// // Fire-and-forget (drive the UI from state):
/// addTodo.mutate(myTodo);
///
/// // Or await the result directly:
/// await addTodo.mutateAsync(myTodo);
///
/// // Reset back to idle:
/// addTodo.reset();
/// ```
///
/// Rendering with pattern matching:
/// ```dart
/// final widget = addTodo.value.map(
///   idle: () => const Text('Ready'),
///   pending: () => const CircularProgressIndicator(),
///   data: (_) => const Text('Saved!'),
///   error: (err, _) => Text('Failed: $err'),
/// );
/// ```
///
/// ### Race protection
/// If [mutate]/[mutateAsync] is called again before a previous run finishes,
/// only the **latest** invocation is allowed to update the signal state. Stale
/// invocations still resolve their own returned future, but they will not
/// overwrite a newer result.
///
/// @link https://dartsignals.dev/async/mutation
/// {@endtemplate}
class MutationSignal<A, T> extends Signal<MutationState<T>> {
  /// Create a [MutationSignal] from an async mutation function.
  MutationSignal(
    this._mutator, {
    SignalOptions<MutationState<T>>? options,
  }) : super(MutationIdle<T>(), options: options);

  final Future<T> Function(A arg) _mutator;

  // Latest-run token; stale runs are ignored.
  Object? _token;
  A? _variables;

  // Recreated after each settled run and on reset.
  Completer<T> _completer = Completer<T>();

  /// The argument passed to the most recent [mutate]/[mutateAsync] call.
  ///
  /// `null` before the first run and after [reset].
  A? get variables => _variables;

  /// Whether the shared [future] has completed with a value or error.
  bool get isCompleted => _completer.isCompleted;

  /// A future that resolves with the result of the in-flight (or next)
  /// mutation, or throws if it fails. A fresh future is created each time a new
  /// mutation is started after the previous one settled, and on [reset].
  Future<T> get future => _completer.future;

  /// Run the mutation and await its result.
  ///
  /// Transitions the state to [MutationPending] synchronously, then to
  /// [MutationSuccess] or [MutationError] once it settles. Returns the result
  /// of *this* invocation (or throws its error) even when a newer mutation
  /// supersedes it; only the latest invocation updates the shared signal state
  /// and [future].
  Future<T> mutateAsync(A arg) async {
    final token = Object();
    _token = token;
    _variables = arg;
    if (_completer.isCompleted) _completer = Completer<T>();
    final completer = _completer;
    value = MutationPending<T>();
    try {
      final result = await _mutator(arg);
      if (identical(_token, token)) {
        batch(() {
          value = MutationSuccess<T>(result);
          if (!completer.isCompleted) completer.complete(result);
        });
      }
      return result;
    } catch (error, stackTrace) {
      if (identical(_token, token)) {
        batch(() {
          value = MutationError<T>(error, stackTrace);
          if (!completer.isCompleted) {
            completer.completeError(error, stackTrace);
            // swallow if [future] is unawaited
            completer.future.then<void>((_) {}, onError: (_) {});
          }
        });
      }
      rethrow;
    }
  }

  /// Run the mutation without awaiting it (fire-and-forget).
  ///
  /// Errors are captured into [MutationError] state rather than thrown, so this
  /// never produces an unhandled async error.
  ///
  /// Optional [onSuccess]/[onError] callbacks fire when *this* invocation
  /// settles, mirroring the per-call result of [mutateAsync]: a stale
  /// (superseded or reset) invocation still invokes its own callback even though
  /// it no longer updates the signal state. Await [mutateAsync] instead when you
  /// need the result inline; it does not take these callbacks.
  void mutate(
    A arg, {
    void Function(T data)? onSuccess,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    mutateAsync(arg).then(
      (data) => onSuccess?.call(data),
      onError: (Object error, StackTrace stackTrace) =>
          onError?.call(error, stackTrace),
    );
  }

  /// Re-run the most recent mutation with the same [variables]
  /// (fire-and-forget).
  ///
  /// Handy for a "retry" affordance after a [MutationError]. Like [mutate], it
  /// never throws the mutation's own error; capture it via [onError] or read
  /// the resulting [MutationError] state. Throws a [StateError] synchronously
  /// when there is nothing to retry (the signal is idle: never run, or [reset]).
  void retry({
    void Function(T data)? onSuccess,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    if (peek().isIdle) {
      throw StateError('Cannot retry a mutation that has not been run');
    }
    mutate(_variables as A, onSuccess: onSuccess, onError: onError);
  }

  /// Reset the signal back to [MutationIdle].
  ///
  /// Any in-flight mutation is detached and will no longer update the state.
  /// A [future] obtained before the reset is settled with a [StateError] so it
  /// never hangs, and a fresh [future] is prepared for the next mutation.
  void reset() {
    _token = null;
    _variables = null;
    if (!_completer.isCompleted) {
      _completer.completeError(
        StateError('MutationSignal was reset before completing'),
      );
      // swallow if the detached future is unawaited
      _completer.future.then<void>((_) {}, onError: (_) {});
    }
    _completer = Completer<T>();
    value = MutationIdle<T>();
  }
}

/// Create a [MutationSignal] from a mutation function.
///
/// The function receives a single typed argument `A` (use a record for multiple
/// values) and returns the mutation result `T`. Configure naming, auto-dispose,
/// and other behavior via [options].
///
/// ```dart
/// final rename = mutationSignal<String, void>((name) => api.rename(name));
/// rename.mutate('New name');
/// ```
///
/// @link https://dartsignals.dev/async/mutation
MutationSignal<A, T> mutationSignal<A, T>(
  Future<T> Function(A arg) mutation, {
  SignalOptions<MutationState<T>>? options,
}) {
  return MutationSignal<A, T>(mutation, options: options);
}
