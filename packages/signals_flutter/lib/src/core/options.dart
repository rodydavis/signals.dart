import 'package:preact_signals/preact_signals.dart' as signals;
import 'package:signals_core/signals_core.dart';

/// Options for creating a flutter signal
class FlutterSignalOptions<T> extends SignalOptions<T> {
  /// Whether to run the callback when the signal is listened to
  final bool runCallbackOnListen;

  /// Options for creating a flutter signal
  const FlutterSignalOptions({
    super.name,
    super.autoDispose,
    super.equalityCheck,
    super.watched,
    super.unwatched,
    this.runCallbackOnListen = false,
  });

  /// Copy the options with new values
  FlutterSignalOptions<T> copyWith({
    String? name,
    bool? autoDispose,
    SignalEquality<T>? equalityCheck,
    signals.SignalCallback<T>? watched,
    signals.SignalCallback<T>? unwatched,
    bool? runCallbackOnListen,
  }) {
    return FlutterSignalOptions(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      equalityCheck: equalityCheck ?? this.equalityCheck,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
      runCallbackOnListen: runCallbackOnListen ?? this.runCallbackOnListen,
    );
  }
}
