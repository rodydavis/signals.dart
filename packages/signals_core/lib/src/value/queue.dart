part of 'value.dart';

/// A [Signal] that holds a [Queue].
class QueueSignal<T> extends Signal<Queue<T>>
    with QueueSignalMixin<T, Queue<T>>
    implements Queue<T> {
  /// Creates a [QueueSignal] with the given [value].
  QueueSignal(
    super.value, {
    QueueSignalOptions<T>? options,
    @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: QueueSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              QueueSignalOptions<T>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        );
}

/// Creates a [QueueSignal] with the given [list] (Queue).
QueueSignal<T> queueSignal<T>(
  Queue<T> list, {
  QueueSignalOptions<T>? options,
  @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: QueueSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return QueueSignal<T>(
    list,
    options: options ??
        QueueSignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Utility extension methods on [Queue] to convert them to [QueueSignal]s.
extension SignalQueueUtils<T> on Queue<T> {
  /// Convert an existing list to [QueueSignal]
  QueueSignal<T> toSignal({
    QueueSignalOptions<T>? options,
    @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: QueueSignalOptions(name: ...) instead')
    String? debugLabel,
  }) {
    return QueueSignal(
      this,
      options: options ??
          QueueSignalOptions<T>(
            autoDispose: autoDispose ?? false,
            name: debugLabel,
          ),
    );
  }
}

/// Configuration options for a [QueueSignal].
class QueueSignalOptions<T> extends SignalOptions<Queue<T>> {
  /// Creates a new [QueueSignalOptions] instance.
  const QueueSignalOptions({
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
    super.equality = const SignalDeepEquality(),
  });

  @override
  QueueSignalOptions<T> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
    SignalEquality<Queue<T>>? equality,
  }) {
    return QueueSignalOptions<T>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
      equality: equality ?? equalityCheck,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QueueSignalOptions<T> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched &&
        other.equalityCheck == equalityCheck;
  }

  @override
  int get hashCode =>
      Object.hash(name, autoDispose, watched, unwatched, equalityCheck);
}
