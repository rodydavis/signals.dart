import 'globals.dart';
import 'effect.dart';
import 'action.dart';

/// Options for configuring a [SignalModel].
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

/// A constructor for models.
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

/// Creates a new model constructor.
SignalModelConstructor<T> createModel<T>(
  T Function() factory, {
  SignalModelOptions options = const SignalModelOptions(),
}) {
  return SignalModelConstructor(factory, options: options);
}
