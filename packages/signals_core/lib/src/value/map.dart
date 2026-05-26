part of 'value.dart';

/// A reactive [Signal] that holds a [Map] and implements the [Map] interface.
///
/// [MapSignal] lets you listen to changes on a map reactively and mutate it directly using
/// standard map operations (like adding/modifying keys with `operator []=`, `addAll`, `remove`,
/// `clear`, etc.). Any mutations automatically trigger reactive updates to all active listeners
/// (e.g., inside an [effect] or [computed]).
///
/// Additionally, [MapSignal] defines convenient operators:
/// - `<<` injects/adds all entries from another map into the current map.
/// - `&` forks/concatenates the map with another map into a new [MapSignal].
/// - `|` pipes/concatenates the map with another signal holding a map into a new [MapSignal].
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// void main() {
///   final settings = mapSignal<String, dynamic>({
///     'theme': 'light',
///     'notifications': true,
///   });
///
///   effect(() {
///     print('Theme is currently: ${settings['theme']}');
///   }); // Prints: "Theme is currently: light"
///
///   // Update key/value pair directly (triggers updates)
///   settings['theme'] = 'dark'; // Prints: "Theme is currently: dark"
///
///   // Expose standard Map methods
///   settings.remove('notifications');
/// }
/// ```
///
/// :::tip
/// Mutating the collection directly calls the reactive set() routine under the hood automatically. You
/// do not need to assign `settings.value = ...` manually!
/// :::
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
    return other is MapSignal<K, V> && peek() == other.peek();
  }

  @override
  int get hashCode {
    final val = peek();
    return Object.hashAll([
      globalId.hashCode,
      val.hashCode,
      for (final item in val.entries) item.hashCode,
    ]);
  }
}

/// Creates a [MapSignal] initialized with the provided [map].
///
/// This is a convenience helper function for creating reactive map signals.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final settings = mapSignal({'theme': 'dark'});
/// ```
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
  /// Convert this existing [Map] to a reactive [MapSignal].
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final myMap = {'key': 'value'};
  /// final signal = myMap.toSignal();
  /// ```
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
    super.equality = const SignalDeepEquality(),
  });

  @override
  MapSignalOptions<K, V> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
    SignalEquality<Map<K, V>>? equality,
  }) {
    return MapSignalOptions<K, V>(
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
    return other is MapSignalOptions<K, V> &&
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
