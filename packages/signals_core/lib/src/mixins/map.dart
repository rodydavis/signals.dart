import '../core/signals.dart';

/// Mixin to upgrade an map signal with reactive properties
mixin MapSignalMixin<K, V, T extends Map<K, V>> on Signal<T>
    implements Map<K, V> {
  @override
  V? operator [](Object? key) {
    return value[key];
  }

  @override
  void operator []=(K key, V value) {
    this.value[key] = value;
    set(this.value, force: true);
  }

  @override
  void addAll(Map<K, V> other) {
    value.addAll(other);
    set(value, force: true);
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    value.addEntries(newEntries);
    set(value, force: true);
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return value.cast<RK, RV>();
  }

  @override
  void clear() {
    value.clear();
    set(value, force: true);
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
    set(value, force: true);
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
    set(value, force: true);
    return result;
  }

  @override
  V? remove(Object? key) {
    final result = value.remove(key);
    set(value, force: true);
    return result;
  }

  @override
  void removeWhere(bool Function(K key, V value) test) {
    value.removeWhere(test);
    set(value, force: true);
  }

  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    final result = value.update(key, update, ifAbsent: ifAbsent);
    set(value, force: true);
    return result;
  }

  @override
  void updateAll(V Function(K key, V value) update) {
    value.updateAll(update);
    set(value, force: true);
  }

  @override
  Iterable<V> get values => value.values;

  /// Snapshot of [MapEntries]
  Map<K, V> toMap() => Map.fromIterables(keys, values);
}
