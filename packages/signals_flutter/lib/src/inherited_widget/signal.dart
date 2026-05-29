import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;

/// A premium dependency-injection / state propagation widget that allows passing
/// reactive signals down the Flutter widget tree using [InheritedNotifier].
///
/// `SignalProvider` makes a signal accessible to all child widgets in the subtree.
/// Any child widget that reads the signal using `SignalProvider.of<T>(context)` will
/// automatically rebuild when the signal's value changes, while parent widgets remain unaffected.
///
/// For version 7, `SignalProvider` is a stateful widget that manages the lifecycle of the created
/// signal, ensuring it is persisted across parent rebuilds and automatically calling `dispose()`
/// when the provider is unmounted to prevent memory leaks.
///
/// ### Example Usage
///
/// #### 1. Standard Constructor (Manages Lifecycle)
/// ```dart
/// SignalProvider<CounterSignal>(
///   create: () => CounterSignal(0),
///   child: const CounterDisplay(),
/// )
/// ```
///
/// #### 2. Value Constructor (Exposes Existing Instance)
/// If the signal is created elsewhere (e.g. in a StatefulWidget's State or globally) and you want
/// to expose it without managing its lifecycle or calling dispose, use [SignalProvider.value]:
/// ```dart
/// SignalProvider<CounterSignal>.value(
///   value: myCounterSignal,
///   child: const CounterDisplay(),
/// )
/// ```
///
/// #### 3. Multi-Providing Multiple Signals
/// Wrap multiple providers in a flat list to avoid deeply nested trees using [SignalProvider.multi]:
/// ```dart
/// SignalProvider.multi(
///   providers: [
///     SignalProvider<Counter>(create: () => Counter()),
///     SignalProvider<User>(create: () => User()),
///   ],
///   child: const MyApp(),
/// )
/// ```
class SignalProvider<T extends core.ReadonlySignal> extends StatefulWidget {
  /// Creates a [SignalProvider] that manages the lifecycle of a created signal.
  ///
  /// The [create] callback is invoked once to instantiate the signal.
  /// When this provider is unmounted, it automatically calls `dispose()` on the signal.
  const SignalProvider({
    super.key,
    required T Function() create,
    this.child,
    this.dispose,
  })  : _create = create,
        _value = null;

  /// Exposes an existing signal [value] to the widget tree.
  ///
  /// Unlike the default constructor, the signal is NOT created by this provider,
  /// and its lifecycle (including disposal) must be managed elsewhere.
  const SignalProvider.value({
    super.key,
    required T value,
    this.child,
  })  : _value = value,
        _create = null,
        dispose = null;

  /// Private constructor for internal cloning and subclass usage.
  const SignalProvider._({
    super.key,
    required T Function()? create,
    required T? value,
    required this.child,
    required this.dispose,
  })  : _create = create,
        _value = value;

  final T Function()? _create;
  final T? _value;

  /// The widget subtree that will have access to the signal.
  final Widget? child;

  /// An optional custom dispose callback.
  final void Function(T)? dispose;

  /// Creates a [SignalProvider] that wraps multiple other [SignalProvider]s.
  ///
  /// This is a convenience constructor to avoid deeply nested trees when
  /// providing multiple signals.
  const factory SignalProvider.multi({
    Key? key,
    required List<SignalProvider> providers,
    required Widget child,
  }) = _MultiSignalProvider<T>;

  /// Returns a clone of this [SignalProvider] with a new [child] widget.
  /// Used internally by [MultiSignalProvider].
  SignalProvider<T> copyWith(Widget child) {
    return SignalProvider<T>._(
      key: key,
      create: _create,
      value: _value,
      dispose: dispose,
      child: child,
    );
  }

  @override
  State<SignalProvider<T>> createState() => _SignalProviderState<T>();

  /// Retrieves the [_InheritedSignalProvider] instance of the specified type [T] from the [BuildContext].
  static _InheritedSignalProvider<T>?
      _inheritedProviderOf<T extends core.ReadonlySignal>(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<_InheritedSignalProvider<T>>();
    } else {
      final element = context.getElementForInheritedWidgetOfExactType<
          _InheritedSignalProvider<T>>();
      return element?.widget as _InheritedSignalProvider<T>?;
    }
  }

  /// Retrieves the [SignalProvider] widget itself from the ancestor path.
  ///
  /// Note: Prefer using `SignalProvider.of<T>(context)` to retrieve the reactive
  /// signal directly.
  static SignalProvider<T>? providerOf<T extends core.ReadonlySignal>(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      context.dependOnInheritedWidgetOfExactType<_InheritedSignalProvider<T>>();
    }
    return context.findAncestorWidgetOfExactType<SignalProvider<T>>();
  }

  /// Retrieves the reactive signal instance of type [T] directly from the nearest [SignalProvider].
  ///
  /// - If [listen] is true (default), the calling widget will automatically subscribe
  ///   to the signal and rebuild whenever the signal's value changes.
  /// - If [listen] is false, the signal is returned without establishing a subscription.
  ///   Use `listen: false` when mutating the signal inside action callbacks.
  static T? of<T extends core.ReadonlySignal>(
    BuildContext context, {
    bool listen = true,
  }) {
    final provider = _inheritedProviderOf<T>(context, listen: listen);
    return provider?.signal;
  }
}

class _SignalProviderState<T extends core.ReadonlySignal>
    extends State<SignalProvider<T>> {
  late T _signal;
  bool _isCreated = false;
  Listenable? _notifier;
  _SignalListenableAdapter? _adapter;

  @override
  void initState() {
    super.initState();
    _initSignal();
  }

  void _initSignal() {
    _adapter?.dispose();
    _adapter = null;

    if (widget._create != null) {
      _signal = widget._create!();
      _isCreated = true;
    } else {
      _signal = widget._value!;
      _isCreated = false;
    }

    if (_signal is Listenable) {
      _notifier = _signal as Listenable;
    } else {
      _adapter = _SignalListenableAdapter(_signal);
      _notifier = _adapter;
    }
  }

  @override
  void didUpdateWidget(SignalProvider<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._value != null && widget._value != oldWidget._value) {
      _signal = widget._value!;
      _isCreated = false;
      _initSignal();
    }
  }

  @override
  void dispose() {
    _adapter?.dispose();
    if (_isCreated) {
      if (widget.dispose != null) {
        widget.dispose!(_signal);
      } else {
        try {
          (_signal as dynamic).dispose();
        } catch (_) {}
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedSignalProvider<T>(
      notifier: _notifier!,
      signal: _signal,
      child: widget.child ?? const SizedBox.shrink(),
    );
  }
}

/// A custom Listenable adapter to bridge standard signals that do not implement Listenable.
class _SignalListenableAdapter extends ChangeNotifier {
  _SignalListenableAdapter(core.ReadonlySignal signal) {
    _cleanup = signal.subscribe((_) => notifyListeners());
  }

  late final VoidCallback _cleanup;

  @override
  void dispose() {
    _cleanup();
    super.dispose();
  }
}

/// Internal inherited widget implementation for [SignalProvider].
class _InheritedSignalProvider<T extends core.ReadonlySignal>
    extends InheritedNotifier<Listenable> {
  const _InheritedSignalProvider({
    super.key,
    required super.notifier,
    required this.signal,
    required super.child,
  });

  final T signal;
}

/// A dependency-injection / state propagation widget that allows passing
/// multiple reactive signals down the Flutter widget tree.
///
/// This avoids the deeply nested trees that result from nesting multiple
/// single [SignalProvider] widgets.
class MultiSignalProvider extends StatelessWidget {
  /// Exposes multiple [SignalProvider] widgets inside a flat list.
  const MultiSignalProvider({
    super.key,
    required this.providers,
    required this.child,
  });

  /// The list of single [SignalProvider] widgets to nest.
  final List<SignalProvider> providers;

  /// The widget subtree that will have access to the provided signals.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget tree = child;
    for (final provider in providers.reversed) {
      tree = provider.copyWith(tree);
    }
    return tree;
  }
}

/// Private implementation of generic MultiSignalProvider returned by factory constructor.
class _MultiSignalProvider<T extends core.ReadonlySignal>
    extends SignalProvider<T> {
  const _MultiSignalProvider({
    super.key,
    required this.providers,
    required Widget child,
  }) : super._(
          create: null,
          value: null,
          child: child,
          dispose: null,
        );

  final List<SignalProvider> providers;

  @override
  State<SignalProvider<T>> createState() => _MultiSignalProviderState<T>();
}

class _MultiSignalProviderState<T extends core.ReadonlySignal>
    extends State<_MultiSignalProvider<T>> {
  @override
  Widget build(BuildContext context) {
    Widget tree = widget.child!;
    for (final provider in widget.providers.reversed) {
      tree = provider.copyWith(tree);
    }
    return tree;
  }
}
