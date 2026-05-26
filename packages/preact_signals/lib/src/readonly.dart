import 'package:meta/meta.dart';

import 'effect.dart';
import 'globals.dart';
import 'listenable.dart';
import 'node.dart';
import 'signal.dart';
import 'options.dart';
import 'untracked.dart';

/// An interface for read-only signals.
///
/// A [ReadonlySignal] is a reactive container whose value can be read but not directly mutated.
/// Under the hood, any [Signal] implements or can be cast/exposed as a [ReadonlySignal]. This
/// is a core architectural pattern for encapsulating state: classes can modify state internally
/// using a private mutable `Signal`, while exposing a public `ReadonlySignal` to consumers to
/// enforce unidirectional data flow.
///
/// Whenever the underlying value changes, any active [effect] or [computed] signal that reads this
/// signal's value will automatically be re-evaluated.
///
/// ### Example Usage
///
/// ````dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// class CounterController {
///   // Keep the mutable state private to the controller
///   final _counter = signal(0);
///
///   // Expose a public read-only signal to external consumers
///   ReadonlySignal<int> get counter => _counter;
///
///   void increment() {
///     _counter.value++;
///   }
///
///   void decrement() {
///     _counter.value--;
///   }
/// }
///
/// void main() {
///   final controller = CounterController();
///
///   // React to updates from the read-only signal
///   final dispose = effect(() {
///     print("The current count is: ${controller.counter.value}");
///   });
///
///   // controller.counter.value = 10; // Error: Cannot mutate a ReadonlySignal!
///
///   controller.increment(); // Prints: "The current count is: 1"
///   controller.increment(); // Prints: "The current count is: 2"
///
///   dispose();
/// }
/// ````
///
/// :::tip
/// Use [ReadonlySignal] to prevent consumers of your stores or controllers from modifying state
/// bypassing the controller's methods. This ensures consistent, predictable, and traceable mutations
/// throughout your application.
/// :::
mixin class ReadonlySignal<T> {
  /// Global ID of the signal
  int get globalId => throw UnimplementedError();

  /// Compute the current value
  T get value => throw UnimplementedError();

  /// The name of the signal for debugging purposes.
  String? get name => null;

  /// Callback called when the signal goes from 0 to >=1 listeners.
  void Function()? get watched => null;

  /// Callback called when the signal goes from >=1 to 0 listeners.
  void Function()? get unwatched => null;

  /// @internal
  /// Internal getter for the raw value without subscription tracking.
  @internal
  T get internalValue => throw UnimplementedError();

  @override
  String toString() => value.toString();

  /// Convert value to JSON
  dynamic toJson() => value;

  /// Return the value when invoked
  T call() => value;

  /// Helper method to get the current value
  T get() => value;

  /// In the rare instance that you have an effect that should write to another signal based on the previous value, but you _don't_ want the effect to be subscribed to that signal, you can read a signals's previous value via `signal.peek()`.
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final effectCount = signal(0);
  ///
  /// effect(() {
  /// 	print(counter.value);
  ///
  /// 	// Whenever this effect is triggered, increase `effectCount`.
  /// 	// But we don't want this signal to react to `effectCount`
  /// 	effectCount.value = effectCount.peek() + 1;
  /// });
  /// ```
  ///
  /// Note that you should only use `signal.peek()` if you really need it. Reading a signal's value via `signal.value` is the preferred way in most scenarios.
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  T peek() {
    final prevContext = evalContext;
    evalContext = null;
    try {
      return value;
    } finally {
      evalContext = prevContext;
    }
  }

  /// Subscribe to value changes with a dispose function
  void Function() subscribe(void Function(T value) fn) =>
      throw UnimplementedError();

  /// @internal
  /// Subscribes this signal to notifications from a given dependency [node].
  @internal
  void subscribeToNode(Node node) => throw UnimplementedError();

  /// @internal
  /// Unsubscribes this signal from notifications from a given dependency [node].
  @internal
  void unsubscribeFromNode(Node node) => throw UnimplementedError();

  /// @internal
  /// Internal subscription mechanism for targets.
  @internal
  void internalSubscribe(Node node) {
    final signal = this;
    if (signal.targets != node && node.prevTarget == null) {
      node.nextTarget = signal.targets;
      if (signal.targets != null) {
        signal.targets!.prevTarget = node;
      } else {
        untracked(() {
          signal.watched?.call();
        });
      }
      signal.targets = node;
    }
  }

  /// Version numbers should always be >= 0, because the special value -1 is used
  /// by Nodes to signify potentially unused but recyclable nodes.
  /// @internal
  /// The current mutation version of the signal.
  @internal
  int get version => throw UnimplementedError();

  /// @internal
  /// Node representing the dependency hook of this signal.
  @internal
  Node? node;

  /// @internal
  /// A linked list of subscription nodes pointing to targets.
  @internal
  Node? targets;

  /// @internal
  /// Refreshes the signal's value internally.
  @internal
  bool internalRefresh() => throw UnimplementedError();

  /// @internal
  /// Brand symbol to uniquely distinguish signals.
  @internal
  final Symbol brand = BRAND_SYMBOL;

  /// @internal
  /// Returns target listeners currently subscribing to this signal.
  @internal
  Iterable<Listenable> readonlySignalTargets() sync* {
    final instance = this;
    for (Node? node = instance.targets; node != null; node = node.nextTarget) {
      yield node.target;
    }
  }

  /// @internal
  /// Adds this signal as a dependency of the current execution context.
  @internal
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  Node? addDependency() {
    final signal = this;
    if (evalContext == null) {
      return null;
    }

    var node = signal.node;
    if (node == null || node.target != evalContext) {
      /**
		 * `signal` is a new dependency. Create a new dependency node, and set it
		 * as the tail of the current context's dependency list. e.g:
		 *
		 * { A <-> B       }
		 *         ↑     ↑
		 *        tail  node (new)
		 *               ↓
		 * { A <-> B <-> C }
		 *               ↑
		 *              tail (evalContext._sources)
		 */
      node = Node()
        ..version = 0
        ..source = signal
        ..prevSource = evalContext!.sources
        ..nextSource = null
        ..target = evalContext!
        ..prevTarget = null
        ..nextTarget = null
        ..rollbackNode = node;

      if (evalContext!.sources != null) {
        evalContext!.sources!.nextSource = node;
      }
      evalContext!.sources = node;
      signal.node = node;

      // Subscribe to change notifications from this dependency if we're in an effect
      // OR evaluating a computed signal that in turn has subscribers.
      if ((evalContext!.flags & TRACKING) != 0) {
        signal.subscribeToNode(node);
      }
      return node;
    } else if (node.version == -1) {
      // `signal` is an existing dependency from a previous evaluation. Reuse it.
      node.version = 0;

      /**
		 * If `node` is not already the current tail of the dependency list (i.e.
		 * there is a next node in the list), then make the `node` the new tail. e.g:
		 *
		 * { A <-> B <-> C <-> D }
		 *         ↑           ↑
		 *        node   ┌─── tail (evalContext._sources)
		 *         └─────│─────┐
		 *               ↓     ↓
		 * { A <-> C <-> D <-> B }
		 *                     ↑
		 *                    tail (evalContext._sources)
		 */
      if (node.nextSource != null) {
        node.nextSource!.prevSource = node.prevSource;

        if (node.prevSource != null) {
          node.prevSource!.nextSource = node.nextSource;
        }

        node.prevSource = evalContext!.sources;
        node.nextSource = null;

        evalContext!.sources!.nextSource = node;
        evalContext!.sources = node;
      }

      // We can assume that the currently evaluated effect / computed signal is already
      // subscribed to change notifications from `signal` if needed.
      return node;
    }
    return null;
  }

  /// @internal
  /// Registers a subscription callback [fn] on value changes.
  @internal
  void Function() signalSubscribe(
    void Function(T value) fn,
  ) {
    final signal = this;
    return effect(() {
      final value = signal.value;
      final prevContext = evalContext;
      evalContext = null;
      try {
        fn(value);
      } finally {
        evalContext = prevContext;
      }
    });
  }

  /// @internal
  /// Unregisters a subscription node.
  @internal
  void signalUnsubscribe(Node node) {
    final signal = this;
    // Only run the unsubscribe step if the signal has any subscribers to begin with.
    if (signal.targets != null) {
      final prev = node.prevTarget;
      final next = node.nextTarget;
      if (prev != null) {
        prev.nextTarget = next;
        node.prevTarget = null;
      }
      if (next != null) {
        next.prevTarget = prev;
        node.nextTarget = null;
      }
      if (node == signal.targets) {
        signal.targets = next;
        if (next == null) {
          untracked(() {
            signal.unwatched?.call();
          });
        }
      }
    }
  }
}

/// Creates a new read-only signal initialized with [value].
///
/// This function returns a [ReadonlySignal] containing [value]. Under the hood, a mutable [Signal]
/// is created, but it is returned under the [ReadonlySignal] interface to prevent modification by clients.
///
/// This is particularly useful when you need to expose a constant reactive value, or bridge some external,
/// immutable value source into the signals reactivity system.
///
/// Parameters:
/// - [value]: The initial value held by the read-only signal.
/// - [options]: Optional configuration options (e.g., custom debug name or lifecycle callbacks like `watched`/`unwatched`).
///
/// Returns:
/// - A [ReadonlySignal] containing the initial value.
///
/// ### Example Usage
///
/// ````dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final configUrl = readonly('https://api.example.com');
///
/// void main() {
///   effect(() {
///     print("Connecting to: ${configUrl.value}");
///   });
/// }
/// ````
///
/// :::caution
/// If you are trying to derive a value from other signals, do not use [readonly]. Use [computed] instead
/// to ensure the derived signal automatically re-evaluates when its source signals change.
/// :::
ReadonlySignal<T> readonly<T>(
  /// The initial value for the signal.
  T value, [
  ReadonlySignalOptions<T>? options,
]) {
  return Signal<T>(value, options: options);
}
