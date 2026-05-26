import 'package:meta/meta.dart';

import 'batch.dart';
import 'globals.dart';
import 'listenable.dart';
import 'node.dart';
import 'options.dart';
import 'readonly.dart';

/// Represents a derived reactive state value computed from one or more other signals.
///
/// Computed signals are read-only, lazily evaluated, and cached (memoized).
/// Their values automatically update when any dependency signals accessed inside the
/// callback function change.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final count = signal(2);
/// final doubleCount = Computed(() => count.value * 2);
///
/// void main() {
///   print(doubleCount.value); // Prints: 4
///   count.value = 5;
///   print(doubleCount.value); // Prints: 10
/// }
/// ```
class Computed<T> with Listenable, ReadonlySignal<T> {
  /// @internal
  /// The computation callback function.
  @internal
  T Function() fn;

  @override
  final int globalId;

  @override
  final String? name;

  @override
  final void Function()? watched;

  @override
  final void Function()? unwatched;

  /// @internal
  /// The internal global version of the computed signal.
  @internal
  int internalGlobalVersion;

  @override
  int flags;

  /// @internal
  /// The captured exception from the latest computation run, if any.
  @internal
  SignalEffectException? error;

  bool _isInitialized = false;

  /// Check if the value has been computed
  bool get isInitialized => _isInitialized;

  late T _internalValue;

  @override
  T get internalValue => _internalValue;

  /// @internal
  /// Set the internal value.
  @internal
  set internalValue(T value) {
    _internalValue = value;
    _isInitialized = true;
  }

  /// Creates a new [Computed] signal instance with the computation callback [fn].
  Computed(
    this.fn, {
    String? name,
    void Function()? watched,
    void Function()? unwatched,
    ComputedOptions<T>? options,
  })  : name = options?.name ?? name,
        watched = options?.watched ?? watched,
        unwatched = options?.unwatched ?? unwatched,
        internalGlobalVersion = globalVersion - 1,
        flags = OUTDATED,
        version = 0,
        globalId = ++lastGlobalId;

  @override
  bool internalRefresh() {
    flags &= ~NOTIFIED;

    if ((flags & RUNNING) != 0) {
      return false;
    }

    // If this computed signal has subscribed to updates from its dependencies
    // (TRACKING flag set) and none of them have notified about changes (OUTDATED
    // flag not set), then the computed value can't have changed.
    if ((flags & (OUTDATED | TRACKING)) == TRACKING) {
      return true;
    }
    flags &= ~OUTDATED;

    if (internalGlobalVersion == globalVersion) {
      return true;
    }
    internalGlobalVersion = globalVersion;

    // Mark this computed signal running before checking the dependencies for value
    // changes, so that the RUNNING flag can be used to notice cyclical dependencies.
    flags |= RUNNING;
    if (version > 0 && !needsToRecompute()) {
      flags &= ~RUNNING;
      return true;
    }

    final prevContext = evalContext;
    try {
      prepareSources();
      evalContext = this;
      final val = fn();
      if (!_isInitialized ||
          (flags & HAS_ERROR) != 0 ||
          _internalValue != val ||
          version == 0) {
        internalValue = val;
        flags &= ~HAS_ERROR;
        version++;
      }
    } catch (err, stack) {
      error = SignalEffectException(err, stack);
      flags |= HAS_ERROR;
      version++;
    }
    evalContext = prevContext;
    cleanupSources();
    flags &= ~RUNNING;
    return true;
  }

  @override
  void subscribeToNode(Node node) {
    if (targets == null) {
      flags |= OUTDATED | TRACKING;

      // A computed signal subscribes lazily to its dependencies when it
      // gets its first subscriber.
      for (var node = sources; node != null; node = node.nextSource) {
        node.source.subscribeToNode(node);
      }
    }
    internalSubscribe(node);
  }

  @override
  void unsubscribeFromNode(Node node) {
    // Only run the unsubscribe step if the computed signal has any subscribers.
    if (targets != null) {
      signalUnsubscribe(node);

      // Computed signal unsubscribes from its dependencies when it loses its last subscriber.
      // This makes it possible for unreferences subgraphs of computed signals to get garbage collected.
      if (targets == null) {
        flags &= ~TRACKING;

        for (var node = sources; node != null; node = node.nextSource) {
          node.source.unsubscribeFromNode(node);
        }
      }
    }
  }

  @override
  void notify() {
    if (!((flags & NOTIFIED) != 0)) {
      flags |= OUTDATED | NOTIFIED;

      for (var node = targets; node != null; node = node.nextTarget) {
        node.target.notify();
      }
    }
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  T get value {
    if ((flags & RUNNING) != 0) {
      throwCycleDetected();
    }

    final node = addDependency();
    internalRefresh();
    if (node != null) {
      node.version = version;
    }
    if ((flags & HAS_ERROR) != 0) {
      throwSignalEffectException(error!);
    }
    return _internalValue;
  }

  @override
  int version;

  @override
  void Function() subscribe(void Function(T value) fn) {
    return signalSubscribe(fn);
  }
}

/// Convenient global constructor for creating a derived computed signal.
///
/// Computed signals are lazily evaluated and cached (memoized). Their values
/// automatically update when any dependency signals accessed inside the callback function change.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final firstName = signal('Jane');
/// final lastName = signal('Doe');
///
/// final fullName = computed(() => '${firstName.value} ${lastName.value}');
///
/// void main() {
///   print(fullName.value); // Prints: Jane Doe
/// }
/// ```
ReadonlySignal<T> computed<T>(
  T Function() fn, [
  ComputedOptions<T>? options,
]) {
  return Computed<T>(
    fn,
    options: options,
  );
}
