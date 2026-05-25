import 'globals.dart';
import 'effect.dart';
import 'action.dart';

/// A wrapper for models constructed with [createModel].
///
/// It holds the instanced model [value] and all the [Effect]s that were captured
/// during its construction. Disposing the [SignalModel] automatically disposes of all
/// nested/captured effects.
class SignalModel<T> {
  /// The instanced model value.
  final T value;

  /// The effects captured during the model's construction.
  final List<Effect> _effects;

  /// Creates a new model instance.
  SignalModel(this.value, this._effects);

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

/// A constructor for models taking 0 arguments.
class SignalModelConstructor0<T> {
  final T Function() _factory;
  /// Creates a new instance of [SignalModelConstructor0].
  SignalModelConstructor0(this._factory);

  /// Instantiates a new [SignalModel] instance.
  SignalModel<T> call() {
    final stop = startCapturingEffects();
    try {
      final res = _factory();
      final effects = stop();
      if (res is Map) {
        final wrapped = _wrapInAction(res);
        try {
          return SignalModel<T>(wrapped as T, effects ?? []);
        } catch (_) {
          return SignalModel<dynamic>(wrapped, effects ?? []) as SignalModel<T>;
        }
      }
      return SignalModel<T>(res, effects ?? []);
    } catch (e) {
      capturedEffects = null;
      rethrow;
    }
  }
}

/// A constructor for models taking 1 argument.
class SignalModelConstructor1<A, T> {
  final T Function(A) _factory;
  /// Creates a new instance of [SignalModelConstructor1].
  SignalModelConstructor1(this._factory);

  /// Instantiates a new [SignalModel] instance.
  SignalModel<T> call(A a) {
    final stop = startCapturingEffects();
    try {
      final res = _factory(a);
      final effects = stop();
      if (res is Map) {
        final wrapped = _wrapInAction(res);
        try {
          return SignalModel<T>(wrapped as T, effects ?? []);
        } catch (_) {
          return SignalModel<dynamic>(wrapped, effects ?? []) as SignalModel<T>;
        }
      }
      return SignalModel<T>(res, effects ?? []);
    } catch (e) {
      capturedEffects = null;
      rethrow;
    }
  }
}

/// A constructor for models taking 2 arguments.
class SignalModelConstructor2<A, B, T> {
  final T Function(A, B) _factory;
  /// Creates a new instance of [SignalModelConstructor2].
  SignalModelConstructor2(this._factory);

  /// Instantiates a new [SignalModel] instance.
  SignalModel<T> call(A a, B b) {
    final stop = startCapturingEffects();
    try {
      final res = _factory(a, b);
      final effects = stop();
      if (res is Map) {
        final wrapped = _wrapInAction(res);
        try {
          return SignalModel<T>(wrapped as T, effects ?? []);
        } catch (_) {
          return SignalModel<dynamic>(wrapped, effects ?? []) as SignalModel<T>;
        }
      }
      return SignalModel<T>(res, effects ?? []);
    } catch (e) {
      capturedEffects = null;
      rethrow;
    }
  }
}

/// Creates a new model constructor taking 0 arguments.
SignalModelConstructor0<T> createModel<T>(T Function() factory) {
  return SignalModelConstructor0(factory);
}

/// Creates a new model constructor taking 1 argument.
SignalModelConstructor1<A, T> createModel1<A, T>(T Function(A) factory) {
  return SignalModelConstructor1(factory);
}

/// Creates a new model constructor taking 2 arguments.
SignalModelConstructor2<A, B, T> createModel2<A, B, T>(T Function(A, B) factory) {
  return SignalModelConstructor2(factory);
}
