import '../../signals_core.dart';

/// Time event to react to
typedef TimerSignalEvent = ({int iteration, int millis});

/// Emit recurring [TimerSignalEvent] aka [AsyncSignal]
class TimerSignal extends StreamSignal<TimerSignalEvent> {
  /// Trigger an [TimerSignalEvent] every duration
  final Duration every;

  /// Emit recurring [TimerSignalEvent] aka [AsyncSignal]
  TimerSignal({
    required this.every,
    super.cancelOnError,
    AsyncSignalOptions<TimerSignalEvent>? options,
    @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          () => Stream<TimerSignalEvent>.periodic(
            every,
            (c) => _emit(c + 1),
          ),
          initialValue: _emit(0),
          options: options ??
              AsyncSignalOptions<TimerSignalEvent>(
                autoDispose: autoDispose ?? false,
                name: debugLabel ?? 'Timer',
              ),
        );

  static TimerSignalEvent _emit(int count) => (
        iteration: count,
        millis: DateTime.now().millisecondsSinceEpoch,
      );
}

/// Expose Duration as a [TimerSignal]
extension TimerSignalDurationUtils on Duration {
  /// Expose Duration as a [TimerSignal]
  TimerSignal toSignal({
    bool? cancelOnError,
    AsyncSignalOptions<TimerSignalEvent>? options,
    @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
    String? debugLabel,
  }) {
    return TimerSignal(
      every: this,
      cancelOnError: cancelOnError,
      options: options ??
          AsyncSignalOptions<TimerSignalEvent>(
            autoDispose: autoDispose ?? false,
            name: debugLabel ?? 'Timer',
          ),
    );
  }
}

/// Create a [TimerSignal]
TimerSignal timerSignal(
  Duration every, {
  bool? cancelOnError,
  AsyncSignalOptions<TimerSignalEvent>? options,
  @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return TimerSignal(
    every: every,
    cancelOnError: cancelOnError,
    options: options ??
        AsyncSignalOptions<TimerSignalEvent>(
          autoDispose: autoDispose ?? false,
          name: debugLabel ?? 'Timer',
        ),
  );
}
