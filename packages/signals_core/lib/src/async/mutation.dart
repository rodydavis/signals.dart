import '../core/signals.dart';

/// Callback for [MutationPending] state.
typedef MutationOnPendingCallback<T> = void Function();

/// Callback for [MutationSuccess] state.
typedef MutationOnSuccessCallback<T> = void Function(T value);

/// Callback for [MutationError] state.
typedef MutationOnErrorCallback = void Function(
  Object error,
  StackTrace stackTrace,
);

/// Callback for [MutationSettled] state.
///
/// Called when the mutation completes, either successfully or with an error.
/// The [settled] parameter contains either [MutationSuccess] or [MutationError].
typedef MutationOnSettledCallback<T> = void Function(
  MutationSettled<T> settled,
);

/// Callback to determine if the mutation can run.
///
/// The callback receives the current [MutationState] value of the mutation
/// and should return `true` if the mutation is allowed to execute.
///
/// The [MutationSignal.canRun] signal automatically updates whenever:
/// - The mutation value changes (e.g., from idle to pending, or to success).
/// - Any signals read inside this callback change.
///
/// Example:
///
/// ```dart
/// final title = signal('');
/// final createTodoMutation = MutationSignal<Todo>(
///   canRun: (value) => !value.isSuccess && title.value.isNotEmpty,
/// );
/// ```
typedef MutationCanRunCallback<T> = bool Function(MutationState<T> value);

/// {@template signals_core.MutationSignal}
/// [MutationSignal] is a signal designed for managing asynchronous mutations,
/// operations that need to be triggered manually with explicit state tracking.
///
/// Common mutations are create, update, and delete operations.
///
/// A [MutationSignal] tracks the lifecycle of a mutation through four states:
/// [MutationIdle], [MutationPending], [MutationSuccess], and [MutationError].
///
/// State transitions happen automatically when using [run], or can be
/// controlled manually via [setPending], [setSuccess], [setError], or
/// [setIdle].
///
/// Only one async operation can execute at a time. When the state is
/// [MutationPending], [canRun] returns `false`, preventing multiple
/// simultaneous executions. You can also provide a custom `canRun` callback
/// in the constructor to add additional conditions.
///
/// ---
///
/// ## Creating a MutationSignal
///
/// ```dart
/// final createTodoMutation = mutationSignal<Todo>();
/// ```
///
/// ## Running a Mutation
///
/// Use the [run] method to execute an async function and automatically update
/// the mutation state based on the result.
///
/// ```dart
/// Future<void> createTodo({required String title}) => createTodoMutation.run(
///       () => repository.createTodo(title: title),
///     );
/// ```
///
/// You can also provide optional callbacks to handle different states:
///
/// ```dart
/// Future<void> createTodo({required String title}) => createTodoMutation.run(
///       () => repository.createTodo(title: title),
///       onPending: () => logger.info('Creating todo...'),
///       onSuccess: (value) => logger.info('Created: ${value.id}'),
///       onError: (error, stackTrace) =>
///           logger.error('Error creating todo', error, stackTrace),
///       onSettled: (settled) => logger.info('Create todo settled: $settled'),
///     );
/// ```
///
/// ## canRun Signal
///
/// Sometimes you need to control whether a mutation can be executed,
/// for example, allowing execution only until the first success, or based
/// on conditions derived from other signals.
///
/// The [canRun] signal is a computed signal that returns `false` when:
///
/// - The mutation is in [MutationPending] state.
/// - The `canRun` callback provided in the constructor returns `false`.
///
/// By returning `false` when the mutation is [MutationPending], multiple
/// simultaneous executions of the same mutation are prevented.
///
/// The `canRun` callback receives the current [MutationState] value as its
/// parameter, allowing you to make decisions based on the mutation's state.
///
/// The [canRun] signal automatically updates whenever:
/// - The mutation value changes (e.g., from idle to pending, or to success).
/// - Any signals read inside the `canRun` callback change.
///
/// Example:
///
/// ```dart
/// final title = signal('');
///
/// final createTodoMutation = MutationSignal<Todo>(
///   canRun: (value) => !value.isSuccess && title.value.isNotEmpty,
/// );
/// ```
///
/// ## Handling the mutation value manually
///
/// Sometimes you may want to update the mutation value manually, so you
/// should not use the [run] method, and instead use the corresponding
/// methods to update the value:
///
/// ```dart
/// final createTodoMutation = MutationSignal<Todo>();
///
/// Future<void> createTodo({required String title}) async {
///   try {
///     if (!createTodoMutation.canRun.value) return;
///     createTodoMutation.setPending();
///     final todo = await repository.createTodo(title: title);
///     createTodoMutation.setSuccess(todo);
///   } catch (error, stackTrace) {
///     createTodoMutation.setError(error, stackTrace);
///   }
/// }
/// ```
/// {@endtemplate}
class MutationSignal<T> extends Signal<MutationState<T>> {
  /// {@macro signals_core.MutationSignal}
  MutationSignal({
    MutationCanRunCallback<T>? canRun,
    super.debugLabel,
    super.autoDispose,
  })  : _canRunCallback = canRun,
        super(MutationState<T>.idle());

  /// The callback to determine if the mutation can run.
  final MutationCanRunCallback<T>? _canRunCallback;

  /// The computed signal for [canRun].
  Computed<bool>? _canRunSignal;

  /// The current run version to manage which function inside [run] is active
  /// and can update the state.
  int _runVersion = 0;

  /// Whether the mutation can currently be executed.
  ///
  /// Sometimes you need to control whether a mutation can be executed,
  /// for example, allowing execution only until the first success, or based
  /// on conditions derived from other signals.
  ///
  /// [canRun] is a computed signal that returns `false` when:
  ///
  /// - The mutation is in [MutationPending] state.
  /// - The `canRun` callback provided in the constructor returns `false`.
  ///
  /// By returning `false` when the mutation is [MutationPending], multiple
  /// simultaneous executions of the same mutation are prevented.
  ///
  /// The `canRun` callback receives the current [MutationState] value as its
  /// parameter, allowing you to make decisions based on the mutation's state.
  ///
  /// The [canRun] signal automatically updates whenever:
  /// - The mutation value changes (e.g., from idle to pending, or to success).
  /// - Any signals read inside the `canRun` callback change.
  ///
  /// Example:
  ///
  /// ```dart
  /// final title = signal('');
  ///
  /// final createTodoMutation = MutationSignal<Todo>(
  ///   canRun: (value) => !value.isSuccess && title.value.isNotEmpty,
  /// );
  /// ```
  ReadonlySignal<bool> get canRun {
    _canRunSignal ??= computed(
      () {
        if (value.isPending) {
          return false;
        }

        if (_canRunCallback != null) {
          return _canRunCallback.call(value);
        }

        return true;
      },
      autoDispose: autoDispose,
    );

    return _canRunSignal!;
  }

  /// Executes the [fn] function and updates the state accordingly.
  ///
  /// Before executing [fn] it checks [canRun], and if it returns `false` it
  /// ignores the call.
  ///
  /// If [canRun] returns `true`, it follows the next flow:
  ///
  /// - Sets the state to [MutationPending].
  /// - Calls the [onPending] callback if provided.
  /// - Executes the async function [fn].
  /// - When the future completes:
  ///   - If [fn] completes successfully, sets the state to [MutationSuccess]
  ///     with the result and calls the [onSuccess] callback if provided.
  ///   - If [fn] throws an error, sets the state to [MutationError]
  ///     with the error and calls the [onError] callback if provided.
  ///   - Calls the [onSettled] callback if provided.
  ///
  /// ```dart
  /// Future<void> createTodo({required String title}) =>
  ///   createTodoMutation.run(
  ///     () => repository.createTodo(title: title),
  ///   );
  /// ```
  Future<void> run(
    Future<T> Function() fn, {
    MutationOnPendingCallback<T>? onPending,
    MutationOnSuccessCallback<T>? onSuccess,
    MutationOnErrorCallback? onError,
    MutationOnSettledCallback<T>? onSettled,
  }) async {
    if (disposed) {
      return;
    }

    if (!canRun.value) {
      return;
    }

    final runVersion = ++_runVersion;

    _updateValue(MutationState<T>.pending());

    onPending?.call();

    bool canUpdateValue() {
      if (disposed) {
        return false;
      }

      return runVersion == _runVersion;
    }

    try {
      final result = await fn();

      if (!canUpdateValue()) {
        return;
      }

      final successState = MutationState<T>.success(result);
      _updateValue(successState);
      onSuccess?.call(result);
      onSettled?.call(successState as MutationSettled<T>);
    } catch (error, stackTrace) {
      if (!canUpdateValue()) {
        return;
      }

      final errorState = MutationState<T>.error(error, stackTrace);
      _updateValue(errorState);
      onError?.call(error, stackTrace);
      onSettled?.call(errorState as MutationSettled<T>);
    }
  }

  /// Sets the state to [MutationIdle].
  ///
  /// When called, if there is an async function running from [run],
  /// its result or error will be ignored.
  ///
  /// See also:
  /// - [setIdle]: An alternative way to set the state to idle.
  void reset() {
    setIdle();
  }

  /// Sets the state to [MutationIdle].
  ///
  /// When called, if there is an async function running from [run],
  /// its result or error will be ignored.
  ///
  /// See also:
  /// - [reset]: An alternative way to set the state to idle.
  void setIdle() {
    _runVersion++;
    _updateValue(MutationState<T>.idle());
  }

  /// Sets the state to [MutationPending].
  void setPending() {
    _updateValue(MutationState<T>.pending());
  }

  /// Sets the state to [MutationSuccess] with the given [value].
  ///
  /// When called, if there is an async function running from [run],
  /// its result or error will be ignored.
  void setSuccess(T value) {
    _runVersion++;
    _updateValue(MutationState<T>.success(value));
  }

  /// Sets the [value] to [MutationError] with the given [error] and
  /// [stackTrace].
  ///
  /// When called, if there is an async function running from [run],
  /// its result or error will be ignored.
  void setError(Object error, [StackTrace? stackTrace]) {
    _runVersion++;
    _updateValue(
      MutationState<T>.error(error, stackTrace ?? StackTrace.current),
    );
  }

  /// Updates the [value] only if not disposed.
  void _updateValue(MutationState<T> newValue) {
    if (disposed) {
      return;
    }
    super.value = newValue;
  }

  @override
  set value(MutationState<T> newValue) {
    _runVersion++;
    _updateValue(newValue);
  }

  @override
  void dispose() {
    _canRunSignal?.dispose();
    super.dispose();
  }
}

/// {@macro signals_core.MutationSignal}
MutationSignal<T> mutationSignal<T>({
  MutationCanRunCallback<T>? canRun,
  String? debugLabel,
  bool autoDispose = false,
}) {
  return MutationSignal<T>(
    canRun: canRun,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

/// [MutationState] is a sealed class representing the states of a mutation
/// operation.
///
/// Common mutations include create, update, and delete operations.
///
/// [MutationState] has four explicit states designed for mutation operations:
///
/// - [MutationIdle]: Initial state, no mutation has been triggered
/// - [MutationPending]: Mutation is in progress
/// - [MutationSettled]: Base class for completed states (success or error)
///   - [MutationSuccess]: Mutation completed successfully with a value
///   - [MutationError]: Mutation failed with an error
///
/// ## Creating States
///
/// ```dart
/// final idle = MutationState<int>.idle();
/// final pending = MutationState<int>.pending();
/// final success = MutationState<int>.success(1);
/// final error = MutationState<int>.error(Exception('Failed'), StackTrace.current);
/// ```
///
/// ## Pattern Matching
///
/// ```dart
/// switch (state) {
///   MutationIdle() => print('Ready to submit'),
///   MutationPending() => print('Submitting...'),
///   MutationSuccess(:final value) => print('Success: $value'),
///   MutationError(:final error) => print('Error: $error'),
/// }
/// ```
sealed class MutationState<T> {
  const MutationState();

  /// Creates an idle state.
  factory MutationState.idle() {
    return MutationIdle<T>();
  }

  /// Creates a pending state.
  factory MutationState.pending() {
    return MutationPending<T>();
  }

  /// Creates a success state with a value.
  factory MutationState.success(T value) {
    return MutationSuccess<T>(value);
  }

  /// Creates an error state.
  factory MutationState.error(Object error, [StackTrace? stackTrace]) {
    return MutationError<T>(error, stackTrace ?? StackTrace.current);
  }

  /// Returns `true` if the state is [MutationIdle].
  bool get isIdle;

  /// Returns `true` if the state is [MutationPending].
  bool get isPending;

  /// Returns `true` if the state is [MutationSuccess].
  bool get isSuccess;

  /// Returns `true` if the state is [MutationError].
  bool get isError;

  /// Returns `true` if the state is [MutationSuccess] with a value.
  bool get hasValue;

  /// Returns `true` if the state is [MutationError] with an error.
  bool get hasError;

  /// Returns `true` if the state is [MutationSettled].
  bool get isSettled;

  /// Returns the value of the [MutationSuccess] or `null` otherwise.
  T? get value;

  /// Returns the error of the [MutationError] or `null` otherwise.
  Object? get error;

  /// Returns the stack trace of the [MutationError] or `null` otherwise.
  StackTrace? get stackTrace;

  /// Force unwrap the value of the [MutationSuccess].
  ///
  /// This will throw an error if the state is not [MutationSuccess].
  T get requireValue;

  @override
  bool operator ==(covariant MutationState<T> other);

  @override
  int get hashCode;
}

/// State for a [MutationState] that is idle.
class MutationIdle<T> extends MutationState<T> {
  /// Creates an idle state.
  const MutationIdle();

  @override
  bool get isIdle => true;

  @override
  bool get isPending => false;

  @override
  bool get isSuccess => false;

  @override
  bool get isError => false;

  @override
  bool get hasValue => false;

  @override
  bool get hasError => false;

  @override
  bool get isSettled => false;

  @override
  T? get value => null;

  @override
  Object? get error => null;

  @override
  StackTrace? get stackTrace => null;

  @override
  T get requireValue =>
      throw UnsupportedError('Idle state does not have a value');

  @override
  bool operator ==(covariant MutationState<T> other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MutationIdle<T>;
  }

  @override
  int get hashCode => 0;

  @override
  String toString() {
    return 'MutationIdle<$T>()';
  }
}

/// State for a [MutationState] that is pending.
class MutationPending<T> extends MutationState<T> {
  /// Creates a pending state.
  const MutationPending();

  @override
  bool get isIdle => false;

  @override
  bool get isPending => true;

  @override
  bool get isSuccess => false;

  @override
  bool get isError => false;

  @override
  bool get hasValue => false;

  @override
  bool get hasError => false;

  @override
  bool get isSettled => false;

  @override
  T? get value => null;

  @override
  Object? get error => null;

  @override
  StackTrace? get stackTrace => null;

  @override
  T get requireValue =>
      throw UnsupportedError('Pending state does not have a value');

  @override
  bool operator ==(covariant MutationState<T> other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MutationPending<T>;
  }

  @override
  int get hashCode => 1;

  @override
  String toString() {
    return 'MutationPending<$T>()';
  }
}

/// State for a [MutationState] that has completed.
///
/// [MutationSettled] is the base class for states representing a completed
/// mutation, either successfully ([MutationSuccess]) or with an error
/// ([MutationError]).
sealed class MutationSettled<T> extends MutationState<T> {
  /// Creates a settled state.
  const MutationSettled();

  @override
  bool get isIdle => false;

  @override
  bool get isPending => false;

  @override
  bool get isSettled => true;
}

/// State for a [MutationState] that completed successfully.
class MutationSuccess<T> extends MutationSettled<T> {
  /// Creates a success state with the given [value].
  const MutationSuccess(this.value);

  @override
  final T value;

  @override
  bool get isSuccess => true;

  @override
  bool get isError => false;

  @override
  bool get hasValue => true;

  @override
  bool get hasError => false;

  @override
  Object? get error => null;

  @override
  StackTrace? get stackTrace => null;

  @override
  T get requireValue => value;

  @override
  bool operator ==(covariant MutationState<T> other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MutationSuccess<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'MutationSuccess<$T>($value)';
  }
}

/// State for a [MutationState] that failed with an error.
class MutationError<T> extends MutationSettled<T> {
  /// Creates an error state with the given [error] and [stackTrace].
  const MutationError(this.error, this.stackTrace);

  @override
  final Object error;

  @override
  final StackTrace stackTrace;

  @override
  bool get isSuccess => false;

  @override
  bool get isError => true;

  @override
  bool get hasValue => false;

  @override
  bool get hasError => true;

  @override
  T? get value => null;

  @override
  T get requireValue =>
      throw UnsupportedError('Error state does not have a value');

  @override
  bool operator ==(covariant MutationState<T> other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MutationError<T> &&
        other.error == error &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode => Object.hashAll([error, stackTrace]);

  @override
  String toString() {
    return 'MutationError<$T>($error, $stackTrace)';
  }
}
