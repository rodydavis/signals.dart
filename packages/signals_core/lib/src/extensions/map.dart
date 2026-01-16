import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<Map>]
extension ReadonlyMapSignalExtension<K, V> on ReadonlySignal<Map<K, V>> {
  /// Get value at key
  V? operator [](Object? key) {
    return value[key];
  }

  /// Cast map
  Map<RK, RV> cast<RK, RV>() {
    return value.cast<RK, RV>();
  }

  /// Check if map contains key
  bool containsKey(Object? key) {
    return value.containsKey(key);
  }

  /// Check if map contains value
  bool containsValue(Object? value) {
    return this.value.containsValue(value);
  }

  /// Get entries
  Iterable<MapEntry<K, V>> get entries => value.entries;

  /// Check if map is empty
  bool get isEmpty => value.isEmpty;

  /// Check if map is not empty
  bool get isNotEmpty => value.isNotEmpty;

  /// Get keys
  Iterable<K> get keys => value.keys;

  /// Get length
  int get length => value.length;

  /// Map
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) {
    return value.map<K2, V2>(convert);
  }

  /// Get values
  Iterable<V> get values => value.values;
}

/// Helper extensions for [Signal<Map>]
extension MapSignalExtension<K, V> on Signal<Map<K, V>> {
  /// Set value at key
  void operator []=(K key, V value) {
    this.value[key] = value;
    set(this.value, force: true);
  }

  /// Add all
  void addAll(Map<K, V> other) {
    value.addAll(other);
    set(value, force: true);
  }

  /// Add entries
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    value.addEntries(newEntries);
    set(value, force: true);
  }

  /// Clear map
  void clear() {
    value.clear();
    set(value, force: true);
  }

  /// For each
  void forEach(void Function(K key, V value) action) {
    value.forEach(action);
    set(value, force: true);
  }

  /// Put if absent
  V putIfAbsent(K key, V Function() ifAbsent) {
    final result = value.putIfAbsent(key, ifAbsent);
    set(value, force: true);
    return result;
  }

  /// Remove
  V? remove(Object? key) {
    final result = value.remove(key);
    set(value, force: true);
    return result;
  }

  /// Remove where
  void removeWhere(bool Function(K key, V value) test) {
    value.removeWhere(test);
    set(value, force: true);
  }

  /// Update
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    final result = value.update(key, update, ifAbsent: ifAbsent);
    set(value, force: true);
    return result;
  }

  /// Update all
  void updateAll(V Function(K key, V value) update) {
    value.updateAll(update);
    set(value, force: true);
  }
}

/// Extensions for [Map<E>]
extension SignalMapExtensions<K, V> on Map<K, V> {
  /// Return a signal from a Map value
  Signal<Map<K, V>> get $ => signal<Map<K, V>>(this);
}
