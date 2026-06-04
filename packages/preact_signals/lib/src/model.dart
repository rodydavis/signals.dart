import 'globals.dart';
import 'effect.dart';
import 'action.dart';

/// Options for configuring a [SignalModel].
///
/// Provides configuration for debug labeling ([name]) and whether to automatically wrap Map functions
/// in transaction-safe, batched actions ([wrapInAction]).
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final options = const SignalModelOptions(
///   name: 'user-profile-model',
///   wrapInAction: true,
/// );
/// ```
class SignalModelOptions {
  /// The name or debug label of the model.
  final String? name;

  /// Whether to automatically wrap returned Map functions in actions.
  /// Defaults to true.
  final bool wrapInAction;

  /// Creates a new instance of [SignalModelOptions].
  const SignalModelOptions({
    this.name,
    this.wrapInAction = true,
  });

  /// Copy options with new values.
  SignalModelOptions copyWith({
    String? name,
    bool? wrapInAction,
  }) {
    return SignalModelOptions(
      name: name ?? this.name,
      wrapInAction: wrapInAction ?? this.wrapInAction,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignalModelOptions &&
        other.name == name &&
        other.wrapInAction == wrapInAction;
  }

  @override
  int get hashCode => Object.hash(name, wrapInAction);
}

/// A premium wrapper for cohesive state packages constructed with [createModel].
///
/// It holds the instanced model [value] and all the [Effect]s that were captured
/// during its construction. Disposing the [SignalModel] automatically disposes of all
/// nested/captured effects, completely avoiding memory leaks.
///
/// ### Premium Pattern: Dart 3+ Extension Type Wrappers
/// To avoid unchecked subscript access like `model['count'].value`, wrap your model in an extension type:
///
/// ```dart
/// extension type TypeSafeCounter(SignalModel<Map<String, dynamic>> _model) {
///   int get count => (_model['count'] as Signal<int>).value;
///   set count(int val) => (_model['count'] as Signal<int>).value = val;
///   void increment() => (_model['increment'] as Function)();
///   void dispose() => _model.dispose();
/// }
/// ```
class SignalModel<T> {
  /// The instanced model value.
  final T value;

  /// The effects captured during the model's construction.
  final List<Effect> _effects;

  /// Options used to configure this model.
  final SignalModelOptions options;

  /// Creates a new model instance.
  SignalModel(
    this.value,
    this._effects, {
    this.options = const SignalModelOptions(),
  });

  /// Access properties dynamically if the underlying [value] is a [Map].
  dynamic operator [](Object? key) {
    if (value is Map) {
      return (value as Map)[key];
    }
    return null;
  }

  /// Set properties dynamically if the underlying [value] is a [Map].
  void operator []=(dynamic key, dynamic val) {
    if (value is Map) {
      (value as Map)[key] = val;
    }
  }

  /// Returns the [value] of this model. Alias for [.value]
  T call() => value;

  /// Disposes of all captured effects.
  void dispose() {
    for (final effect in _effects) {
      effect.dispose();
    }
    _effects.clear();
  }
}

Map _wrapInAction(Map map) {
  for (final key in map.keys.toList()) {
    final val = map[key];
    if (val is Function) {
      map[key] = action(val);
    } else if (val is Map) {
      _wrapInAction(val);
    }
  }
  return map;
}

/// A constructor for models that manages nested effects.
///
/// The model constructor starts capturing effects when called, storing them inside the returned [SignalModel].
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final myModel = SignalModelConstructor(() => 'data');
/// final model = myModel();
/// print(model.value); // Prints: data
/// ```
class SignalModelConstructor<T> {
  final T Function() _factory;

  /// Options used to configure this constructor.
  final SignalModelOptions options;

  /// Creates a new instance of [SignalModelConstructor].
  SignalModelConstructor(
    this._factory, {
    this.options = const SignalModelOptions(),
  });

  /// Instantiates a new [SignalModel] instance.
  SignalModel<T> call() {
    final stop = startCapturingEffects();
    try {
      final res = _factory();
      final effects = stop();
      if (res is Map && options.wrapInAction) {
        final wrapped = _wrapInAction(res);
        try {
          return SignalModel<T>(
            wrapped as T,
            effects ?? [],
            options: options,
          );
        } catch (_) {
          return SignalModel<dynamic>(
            wrapped,
            effects ?? [],
            options: options,
          ) as SignalModel<T>;
        }
      }
      return SignalModel<T>(
        res,
        effects ?? [],
        options: options,
      );
    } catch (e) {
      capturedEffects = null;
      rethrow;
    }
  }
}

/// Creates a new model constructor with an instanced factory.
///
/// A [SignalModel] is a highly powerful architectural primitive designed to manage cohesive packages
/// of related state, business logic, actions, and side effects.
///
/// Under the hood, [SignalModel] automatically tracks, scopes, and manages the lifecycle of any [Effect]s
/// instantiated during its factory execution. When the model is disposed (by calling `model.dispose()`),
/// all nested/captured effects are clean up automatically, ensuring complete prevention of memory leaks.
///
/// Furthermore, if the factory returns a standard Dart [Map], and `wrapInAction` is enabled (default),
/// all nested function properties are automatically wrapped in batched [action] transactions to optimize updates.
///
/// ### 1. Type-Safe Models using Dart 3+ Records (Recommended)
/// The simplest and most built-in way to define a compile-safe model is to return a Dart **record** from your factory.
/// Records provide immediate type safety, autocomplete, and compile-time verification without any wrapper boilerplates.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// // Define the reactive model constructor returning a Record
/// final counterModel = createModel(() {
///   final count = signal(0);
///
///   // Captured nested side-effect (e.g. logging or syncing to local storage)
///   effect(() {
///     print('Nested logger: count is ${count.value}');
///   });
///
///   return (
///     count: count,
///     increment: () => count.value++,
///   );
/// });
///
/// void main() {
///   // Instantiate the model
///   final model = counterModel();
///
///   // Access properties type-safely via .value
///   print(model.value.count.value); // Prints: 0 (and registers effect print: Nested logger: count is 0)
///   model.value.increment();        // Prints: Nested logger: count is 1
///
///   // Dispose when done to clean up all captured nested effects
///   model.dispose();
/// }
/// ```
///
/// ### 2. Object-Oriented Style: Type-Safe Wrappers using Dart 3+ Extension Types
/// While records are great for lightweight structures, you can wrap the returned Map-based `SignalModel` in a standard Dart 3 **extension type** when you prefer a class-like API (e.g. implementing getters/setters or hiding subscript lookups).
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// // 1. Define the reactive model constructor returning a Map
/// final counterModel = createModel(() {
///   final count = signal(0);
///
///   // Captured nested side-effect (e.g. logging or syncing to local storage)
///   effect(() {
///     print('Nested logger: count is ${count.value}');
///   });
///
///   return <String, dynamic>{
///     'count': count,
///     'increment': () => count.value++,
///   };
/// });
///
/// // 2. Create a premium, compile-safe extension type wrapper
/// extension type TypeSafeCounter(SignalModel<Map<String, dynamic>> _model) {
///   int get count => (_model['count'] as Signal<int>).value;
///   set count(int val) => (_model['count'] as Signal<int>).value = val;
///
///   void increment() => (_model['increment'] as Function)();
///   void dispose() => _model.dispose();
/// }
///
/// void main() {
///   // 3. Instantiate and wrap the model
///   final counter = TypeSafeCounter(counterModel());
///
///   // Now you have a beautifully autocomplete-friendly, compile-safe API!
///   print(counter.count); // Prints: 0 (and registers effect print: Nested logger: count is 0)
///   counter.increment();  // Prints: Nested logger: count is 1
///
///   // Dispose when done to clean up all captured nested effects
///   counter.dispose();
/// }
/// ```
///
/// <Info>
///   Favor using Dart 3 records or extension types when defining models. They cost zero runtime overhead
///   while granting complete compile-safe parameters and autocomplete functionality.
/// </Info>
SignalModelConstructor<T> createModel<T>(
  T Function() factory, {
  SignalModelOptions options = const SignalModelOptions(),
}) {
  return SignalModelConstructor(factory, options: options);
}
