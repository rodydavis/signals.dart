import 'package:meta/meta.dart';

import 'effect.dart';
import 'globals.dart';
import 'listenable.dart';
import 'node.dart';
import 'signal.dart';

/// An interface for read-only signals.
abstract class ReadonlySignal<T> {
  /// Global ID of the signal
  int get globalId;

  /// Compute the current value
  T get value;

  @internal
  T get internalValue;

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
  void Function() subscribe(void Function(T value) fn);

  @internal
  void subscribeToNode(Node node);

  @internal
  void unsubscribeFromNode(Node node);

  @internal
  static void internalSubscribe(ReadonlySignal signal, Node node) {
    if (signal.targets != node && node.prevTarget == null) {
      node.nextTarget = signal.targets;
      if (signal.targets != null) {
        signal.targets!.prevTarget = node;
      }
      signal.targets = node;
    }
  }

  /// Version numbers should always be >= 0, because the special value -1 is used
  /// by Nodes to signify potentially unused but recyclable nodes.
  @internal
  int get version;

  @internal
  Node? node;

  @internal
  Node? targets;

  @internal
  bool internalRefresh();

  @internal
  final Symbol brand = BRAND_SYMBOL;
}

@internal
Iterable<Listenable> readonlySignalTargets(ReadonlySignal instance) sync* {
  for (Node? node = instance.targets; node != null; node = node.nextTarget) {
    yield node.target;
  }
}

@internal
Node? addDependency(ReadonlySignal signal) {
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

@internal
void Function() signalSubscribe<T>(
  ReadonlySignal<T> signal,
  void Function(T value) fn,
) {
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

@internal
void signalUnsubscribe(ReadonlySignal signal, Node node) {
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
    }
  }
}

/// Create a new plain readonly signal
ReadonlySignal<T> readonly<T>(
  /// The initial value for the signal
  T value,
) {
  return signal<T>(value);
}
