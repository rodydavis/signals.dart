import '../async/state.dart';
import '../core/signals.dart';
import '../extensions/signal.dart';

/// Extensions for [Signal<AsyncState<T>>]
extension AsyncSignalState<T> on Signal<AsyncState<T>> {
  /// Select from data when available, preserving async state
  Computed<AsyncState<R>> selectData<R>(R Function(T data) selector) {
    return select(
      (asyncState) {
        return switch (asyncState()) {
          AsyncData(:final value) => AsyncState.data(selector(value)),
          AsyncLoading() => AsyncState.loading(),
          AsyncError(:final error, :final stackTrace) =>
            AsyncState.error(error, stackTrace),
        };
      },
    );
  }
}
