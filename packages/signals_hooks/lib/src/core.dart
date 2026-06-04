import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';

import 'base.dart';

/// Subscribes to an existing [ReadonlySignal] (or [Signal]) and returns it.
///
/// This is useful when you have a signal that is defined globally, inside a controller,
/// or provided via a dependency injection framework (like provider, get_it, or riverpod),
/// and you want to reactive-bind the [HookWidget] to rebuild whenever the signal emits
/// a new value.
///
/// <Info>
///   If you only need the value of the signal inside the build method and do not
///   need the signal instance itself, consider using [useSignalValue] instead.
/// </Info>
///
/// ### Parameters
/// - [value]: The existing [ReadonlySignal] or [Signal] instance to subscribe to.
/// - [keys]: A list of objects to watch for changes. If any of the keys change,
///   the hook is re-evaluated, unsubscribing from the old signal and subscribing
///   to the new one.
///
/// ### Returns
/// The same signal instance passed in [value], allowing you to interact with it
/// directly (e.g., read its `.value` or write to it if it is a mutable [Signal]).
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// // A globally defined signal or one located in a service
/// final globalThemeMode = signal(ThemeMode.light);
///
/// class ThemeSelectorWidget extends HookWidget {
///   const ThemeSelectorWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // Bind to the existing global signal
///     final themeMode = useExistingSignal(globalThemeMode);
///
///     return SwitchListTile(
///       title: Text('Dark Mode: ${themeMode.value == ThemeMode.dark ? "On" : "Off"}'),
///       value: themeMode.value == ThemeMode.dark,
///       onChanged: (isDark) {
///         themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
///       },
///     );
///   }
/// }
/// ````
S useExistingSignal<T, S extends ReadonlySignal<T>>(
  S value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the hook will be re-evaluated.
  List<Object?> keys = const <Object>[],
}) {
  return use(SignalHook<T, S>(value, keys: keys));
}

/// Subscribes to an existing [ReadonlySignal] (or [Signal]) and returns its current value.
///
/// This is a convenience hook that is equivalent to invoking `useExistingSignal(signal).value`.
/// It triggers a rebuild of the host [HookWidget] whenever the signal's value changes.
///
/// <Info>
///   This hook is the preferred way to consume external/global signals when you only
///   need read-only access to their values and want standard Flutter Hook ergonomics.
/// </Info>
///
/// ### Parameters
/// - [value]: The existing [ReadonlySignal] or [Signal] instance to retrieve the value from and subscribe to.
/// - [keys]: A list of objects to watch for changes. If any key changes, the hook will be re-evaluated
///   and subscribe to the new signal.
///
/// ### Returns
/// The current value [T] of the signal.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// final cartItemCountSignal = signal(0);
///
/// class CartBadge extends HookWidget {
///   const CartBadge({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // Directly extract and subscribe to the signal's value
///     final itemCount = useSignalValue(cartItemCountSignal);
///
///     return Badge(
///       label: Text('$itemCount'),
///       child: const Icon(Icons.shopping_cart),
///     );
///   }
/// }
/// ````
T useSignalValue<T, S extends ReadonlySignal<T>>(
  S value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the hook will be re-evaluated.
  List<Object?> keys = const <Object>[],
}) {
  return useExistingSignal(value, keys: keys)();
}

/// Creates a new [Signal] that persists across widget rebuilds and subscribes to it.
///
/// The signal is instantiated once using [useMemoized] and automatically disposed of or cleaned up
/// if necessary (signals created in this manner are managed by the Hook lifetime). The widget
/// will automatically rebuild whenever this signal's value changes.
///
/// <Warning>
///   If you want the signal to survive widget disposal (e.g. shared state), do not use [useSignal].
///   Instead, define your signal globally or in a controller, and subscribe to it using [useExistingSignal]
///   or [useSignalValue].
/// </Warning>
///
/// ### Parameters
/// - [value]: The initial value of the signal.
/// - [keys]: A list of objects to watch for changes. If any key in this list changes, the signal is
///   re-created with the current [value] as its initial value.
/// - [debugLabel]: An optional debug label to identify the signal in developer tools.
///
/// ### Returns
/// A local [FlutterSignal] instance representing the reactive state.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class CounterHookWidget extends HookWidget {
///   const CounterHookWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // Create a local signal managed by this HookWidget's lifecycle
///     final count = useSignal(0, keys: const [], options: SignalOptions(name: 'localCounter'));
///
///     return Scaffold(
///       body: Center(
///         child: Text(
///           'Count: ${count.value}',
///           style: Theme.of(context).textTheme.headlineMedium,
///         ),
///       ),
///       floatingActionButton: FloatingActionButton(
///         onPressed: () => count.value++,
///         tooltip: 'Increment',
///         child: const Icon(Icons.add),
///       ),
///     );
///   }
/// }
/// ````
FlutterSignal<T> useSignal<T>(
  T value, {
  List<Object?> keys = const <Object>[],
  SignalOptions<T>? options,
}) {
  final s = useMemoized(() => signal(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [Computed] signal and subscribes to it.
///
/// This hook is useful for deriving state within a [HookWidget] based on other signals or values.
/// The callback [value] is evaluated lazily and cached. It is recomputed only when the dependent
/// signals inside the callback change, or if any of the hook [keys] change.
///
/// The host widget will rebuild whenever the derived value changes.
///
/// <Info>
///   Use computed signals to keep build methods clean and prevent unnecessary re-computations
///   of expensive operations (e.g., filtering, sorting, or formatting data).
/// </Info>
///
/// ### Parameters
/// - [value]: The computation callback that derives the computed value.
/// - [keys]: A list of objects to watch for changes. If any key changes, the computed signal is re-created.
/// - [debugLabel]: An optional debug label to identify the computed signal in developer tools.
///
/// ### Returns
/// A [FlutterComputed] signal containing the derived value.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class DerivedStateWidget extends HookWidget {
///   const DerivedStateWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final firstName = useSignal('John');
///     final lastName = useSignal('Doe');
///
///     // Derived full name computed from the individual signals
///     final fullName = useComputed(
///       () => '${firstName.value} ${lastName.value}',
///       keys: [firstName, lastName],
///     );
///
///     return Column(
///       children: [
///         Text('Full Name: ${fullName.value}'),
///         ElevatedButton(
///           onPressed: () => firstName.value = 'Jane',
///           child: const Text('Change First Name'),
///         ),
///       ],
///     );
///   }
/// }
/// ````
FlutterComputed<T> useComputed<T>(
  T Function() value, {
  List<Object?> keys = const <Object>[],
  ComputedOptions<T>? options,
}) {
  final s = useMemoized(() => computed(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new reactive [effect] and registers it with the widget's lifecycle.
///
/// The effect is automatically created on build and is disposed of when the widget is unmounted.
/// Any reactive signal accessed inside the callback [cb] is tracked as a dependency, and the effect
/// is executed automatically whenever those signals change.
///
/// <Warning>
///   Avoid modifying signals inside the effect callback that could trigger infinite loops or
///   unintentional side effects.
/// </Warning>
///
/// ### Parameters
/// - [cb]: The effect callback to execute when tracked dependencies change.
/// - [keys]: A list of objects to watch. If any key changes, the effect is disposed and re-created.
/// - [onDispose]: An optional callback executed when the effect itself is disposed.
/// - [debugLabel]: An optional debug label to identify the effect in developer tools.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class LoggerWidget extends HookWidget {
///   const LoggerWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     final count = useSignal(0);
///
///     // Set up a side effect to log value changes
///     useSignalEffect(
///       () {
///         debugPrint('The counter value is now: ${count.value}');
///       },
///       keys: [count],
///       onDispose: () => debugPrint('Logger effect disposed'),
///     );
///
///     return TextButton(
///       onPressed: () => count.value++,
///       child: Text('Count: ${count.value}'),
///     );
///   }
/// }
/// ````
void useSignalEffect(
  dynamic Function() cb, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the effect will be re-created.
  List<Object?> keys = const <Object>[],

  /// A callback that is executed when the effect is disposed.
  dynamic Function()? onDispose,

  /// The debug label for the effect.
  String? debugLabel,
}) {
  useEffect(
    () => effect(cb, onDispose: onDispose, debugLabel: debugLabel),
    keys,
  );
  return;
}

/// Creates a new [LinkedSignal] that resets its value whenever its source computation changes.
///
/// A [LinkedSignal] is a specialized signal that "links" to another reactive source or computed value,
/// automatically updating or resetting itself based on a custom computation function when the source changes.
///
/// <Info>
///   This is perfect for situations like editing a form field where the default value is derived from a
///   dynamic source (e.g. an item index, a fetched database record) but the user can also edit the value locally.
/// </Info>
///
/// ### Parameters
/// - [source]: A computation function that yields the source value of type [S].
/// - [options]: Configuration options for the linked signal, detailing how the source value [S] maps to
///   the signal's inner value [T].
/// - [keys]: A list of objects to watch. If any key changes, the signal is re-created.
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class ProfileEditor extends HookWidget {
///   final String initialUsername;
///   const ProfileEditor({required this.initialUsername, super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // LinkedSignal resets to initialUsername if the prop initialUsername changes,
///     // but allows local modifications in the meantime.
///     final usernameSignal = useLinkedSignal(
///       () => initialUsername,
///       keys: [initialUsername],
///       options: LinkedSignalOptions(
///         computation: (source, previous) => source,
///       ),
///     );
///
///     return Column(
///       children: [
///         TextField(
///           controller: useTextEditingController(text: usernameSignal.value)
///             ..addListener(() {
///               // Local modifications allowed
///               usernameSignal.value = usernameSignal.value;
///             }),
///         ),
///         Text('Live Username Signal: ${usernameSignal.value}'),
///       ],
///     );
///   }
/// }
/// ````
LinkedSignal<T, S> useLinkedSignal<T, S>(
  S Function() source, {
  List<Object?> keys = const <Object>[],
  LinkedSignalOptions<T, S>? options,
}) {
  final s = useMemoized(
    () => linkedSignal<T, S>(source, options: options),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [Signal] that starts uninitialized and subscribes to it.
///
/// A lazy signal is a signal that doesn't have an initial value on creation. Reading its `.value`
/// before setting it will throw a [LazySignalInitializationError].
///
/// <Info>
///   Ideal for binding late-initialized state, such as data fetched in a lifecycle effect
///   or passed asynchronously from platform channels.
/// </Info>
///
/// ### Parameters
/// - [keys]: A list of objects to watch. If any key changes, the signal is re-created.
/// - [options]: Optional configuration options for standard signals (e.g. name, autoDispose).
///
/// ### Example
///
/// ````dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_hooks/flutter_hooks.dart';
/// import 'package:signals_hooks/signals_hooks.dart';
///
/// class LateSetupWidget extends HookWidget {
///   const LateSetupWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // Starts uninitialized safely
///     final dataSignal = useLazySignal<String>();
///
///     useEffect(() {
///       Future.delayed(const Duration(seconds: 1), () {
///         dataSignal.value = 'Initialized Data';
///       });
///       return null;
///     }, []);
///
///     return Text(dataSignal.value.isEmpty ? 'Uninitialized' : dataSignal.value);
///   }
/// }
/// ````
Signal<T> useLazySignal<T>({
  SignalOptions<T>? options,
  List<Object?> keys = const <Object>[],
}) {
  final state = useState(0);
  final s = useMemoized(
    () => _LazySignalHookInstance<T>(
      options: options,
      onChanged: () => state.value++,
    ),
    keys,
  );
  if (s.isInitialized) {
    useExistingSignal(s, keys: keys);
  }
  return s;
}

class _LazySignalHookInstance<T> extends Signal<T> {
  _LazySignalHookInstance({
    super.options,
    required this.onChanged,
  }) : super.lazy();

  final void Function() onChanged;

  @override
  bool set(T val, {bool force = false}) {
    final wasInitialized = isInitialized;
    final updated = super.set(val, force: force);
    if (updated || !wasInitialized) {
      onChanged();
    }
    return updated;
  }
}
