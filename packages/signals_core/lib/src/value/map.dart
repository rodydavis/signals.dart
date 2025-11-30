part of 'value.dart';

/// A [Signal] that holds a [Map].
class MapSignal<K, V> extends Signal<Map<K, V>>
    with MapSignalMixin<K, V, Map<K, V>>
    implements Map<K, V> {
  /// Creates a [MapSignal] with the given [value].
  MapSignal(
    super.value, {
    super.debugLabel,
    super.autoDispose,
  });

  /// Inject: Update current signal value with iterable
  MapSignal<K, V> operator <<(Map<K, V> other) {
    value.addAll(other);
    set(value, force: true);
    return this;
  }

  /// Fork: create a new signal with value is the concatenation of source signal and iterable parameter
  MapSignal<K, V> operator &(Map<K, V> other) {
    final rs = Map<K, V>.from(peek())..addAll(other);
    return MapSignal(rs);
  }

  /// Pipe: create a new signal by sending value from source to other
  MapSignal<K, V> operator |(Signal<Map<K, V>> other) {
    final rs = Map<K, V>.from(peek())..addAll(other.peek());
    return MapSignal(rs);
  }

  @override
  bool operator ==(Object other) {
    return other is MapSignal<K, V> && value == other.value;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      globalId.hashCode,
      value.hashCode,
      for (final item in value.entries) item.hashCode,
    ]);
  }
}

/// Create an [MapSignal] from [Map]
MapSignal<K, V> mapSignal<K, V>(
  Map<K, V> map, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return MapSignal<K, V>(
    map,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalMapUtils<K, V> on Map<K, V> {
  /// Convert an existing list to [MapSignal]
  MapSignal<K, V> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return MapSignal<K, V>(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}
