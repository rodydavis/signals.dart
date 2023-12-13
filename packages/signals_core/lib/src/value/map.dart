import '../core/signals.dart';

/// A [Signal] that holds a [Map].
class MapSignal<K, V> extends ValueSignal<Map<K, V>> implements Map<K, V> {
  /// Creates a [MapSignal] with the given [value].
  MapSignal(super.value, {super.debugLabel});

  @override
  V? operator [](Object? key) {
    return value[key];
  }

  @override
  void operator []=(K key, V value) {
    this.value[key] = value;
    forceUpdate(this.value);
  }

  /// Inject: Update current signal value with iterable
  MapSignal<K, V> operator <<(Map<K, V> other) {
    value.addAll(other);
    forceUpdate(value);
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
  void addAll(Map<K, V> other) {
    value.addAll(other);
    forceUpdate(value);
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    value.addEntries(newEntries);
    forceUpdate(value);
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return value.cast<RK, RV>();
  }

  @override
  void clear() {
    value.clear();
    forceUpdate(value);
  }

  @override
  bool containsKey(Object? key) {
    return value.containsKey(key);
  }

  @override
  bool containsValue(Object? value) {
    return this.value.containsValue(value);
  }

  @override
  Iterable<MapEntry<K, V>> get entries => value.entries;

  @override
  void forEach(void Function(K key, V value) action) {
    value.forEach(action);
    forceUpdate(value);
  }

  @override
  bool get isEmpty => value.isEmpty;

  @override
  bool get isNotEmpty => value.isNotEmpty;

  @override
  Iterable<K> get keys => value.keys;

  @override
  int get length => value.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) {
    return value.map<K2, V2>(convert);
  }

  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    final result = value.putIfAbsent(key, ifAbsent);
    forceUpdate(value);
    return result;
  }

  @override
  V? remove(Object? key) {
    final result = value.remove(key);
    forceUpdate(value);
    return result;
  }

  @override
  void removeWhere(bool Function(K key, V value) test) {
    value.removeWhere(test);
    forceUpdate(value);
  }

  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    final result = value.update(key, update, ifAbsent: ifAbsent);
    forceUpdate(value);
    return result;
  }

  @override
  void updateAll(V Function(K key, V value) update) {
    value.updateAll(update);
    forceUpdate(value);
  }

  @override
  Iterable<V> get values => value.values;

  @override
  bool operator ==(Object other) {
    return other is MapSignal<K, V> && value == other.value;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      globalId.hashCode,
      value.hashCode,
      for (final item in value.entries) item.hashCode
    ]);
  }
}

/// Create an [MapSignal] from [Map]
MapSignal<K, V> mapSignal<K, V>(
  Map<K, V> map, {
  String? debugLabel,
}) {
  return MapSignal<K, V>(
    map,
    debugLabel: debugLabel,
  );
}
