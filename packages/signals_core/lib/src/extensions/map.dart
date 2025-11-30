// ignore_for_file: public_member_api_docs

import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<Map>]
extension ReadonlyMapSignalExtension<K, V> on ReadonlySignal<Map<K, V>> {
  V? operator [](Object? key) {
    return value[key];
  }

  Map<RK, RV> cast<RK, RV>() {
    return value.cast<RK, RV>();
  }

  bool containsKey(Object? key) {
    return value.containsKey(key);
  }

  bool containsValue(Object? value) {
    return this.value.containsValue(value);
  }

  Iterable<MapEntry<K, V>> get entries => value.entries;

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;

  Iterable<K> get keys => value.keys;

  int get length => value.length;

  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) {
    return value.map<K2, V2>(convert);
  }

  Iterable<V> get values => value.values;
}

/// Helper extensions for [Signal<Map>]
extension MapSignalExtension<K, V> on Signal<Map<K, V>> {
  void operator []=(K key, V value) {
    this.value[key] = value;
    set(this.value, force: true);
  }

  void addAll(Map<K, V> other) {
    value.addAll(other);
    set(value, force: true);
  }

  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    value.addEntries(newEntries);
    set(value, force: true);
  }

  void clear() {
    value.clear();
    set(value, force: true);
  }

  void forEach(void Function(K key, V value) action) {
    value.forEach(action);
    set(value, force: true);
  }

  V putIfAbsent(K key, V Function() ifAbsent) {
    final result = value.putIfAbsent(key, ifAbsent);
    set(value, force: true);
    return result;
  }

  V? remove(Object? key) {
    final result = value.remove(key);
    set(value, force: true);
    return result;
  }

  void removeWhere(bool Function(K key, V value) test) {
    value.removeWhere(test);
    set(value, force: true);
  }

  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    final result = value.update(key, update, ifAbsent: ifAbsent);
    set(value, force: true);
    return result;
  }

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
