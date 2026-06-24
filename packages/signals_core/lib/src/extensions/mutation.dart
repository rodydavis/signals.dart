import '../async/mutation.dart';
import '../core/signals.dart';
import 'signal.dart';

/// Extension on a mutation function `Future<T> Function(A)` to convert it into
/// a [MutationSignal].
extension SignalMutationFunctionUtils<A, T> on Future<T> Function(A) {
  /// Convert this mutation function into a [MutationSignal].
  ///
  /// ```dart
  /// import 'package:signals_core/signals_core.dart';
  ///
  /// Future<void> save(Todo todo) => api.add(todo);
  /// final addTodo = save.toMutationSignal();
  ///
  /// addTodo.mutate(myTodo);
  /// ```
  MutationSignal<A, T> toMutationSignal({
    SignalOptions<MutationState<T>>? options,
  }) {
    return mutationSignal<A, T>(this, options: options);
  }
}

/// Extensions for [Signal<MutationState<T>>].
extension MutationSignalState<T> on Signal<MutationState<T>> {
  /// Select from the success data when available, preserving the surrounding
  /// mutation state (idle, pending, error).
  ///
  /// ```dart
  /// final mutation = mutationSignal<Todo, Todo>((t) => api.add(t));
  /// final name = mutation.selectData((todo) => todo.name);
  /// ```
  Computed<MutationState<R>> selectData<R>(R Function(T data) selector) {
    return select<MutationState<R>>((state) {
      return switch (state()) {
        MutationSuccess(:final value) => MutationState<R>.data(selector(value)),
        MutationPending() => MutationState<R>.pending(),
        MutationIdle() => MutationState<R>.idle(),
        MutationError(:final error, :final stackTrace) =>
          MutationState<R>.error(error, stackTrace),
      };
    });
  }
}
