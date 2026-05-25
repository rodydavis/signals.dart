part of 'value.dart';

/// A [Signal] that holds a [Map].
class MapSignal<K, V> extends Signal<Map<K, V>>
    with MapSignalMixin<K, V, Map<K, V>>
    implements Map<K, V> {
  /// Creates a [MapSignal] with the given [value].
  MapSignal(
    super.value, {
    MapSignalOptions<K, V>? options,
    @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: MapSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              MapSignalOptions<K, V>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        );

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
  MapSignalOptions<K, V>? options,
  @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: MapSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return MapSignal<K, V>(
    map,
    options: options ??
        MapSignalOptions<K, V>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Utility extension methods on [Map] to convert them to [MapSignal]s.
extension SignalMapUtils<K, V> on Map<K, V> {
  /// Convert an existing list to [MapSignal]
  MapSignal<K, V> toSignal({
    MapSignalOptions<K, V>? options,
    @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: MapSignalOptions(name: ...) instead')
    String? debugLabel,
  }) {
    return MapSignal<K, V>(
      this,
      options: options ??
          MapSignalOptions<K, V>(
            autoDispose: autoDispose ?? false,
            name: debugLabel,
          ),
    );
  }
}

/// Configuration options for a [MapSignal].
class MapSignalOptions<K, V> extends SignalOptions<Map<K, V>> {
  /// Creates a new [MapSignalOptions] instance.
  const MapSignalOptions({
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
  });

  @override
  MapSignalOptions<K, V> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return MapSignalOptions<K, V>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MapSignalOptions<K, V> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(name, autoDispose, watched, unwatched);
}
