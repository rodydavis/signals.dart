part of 'signals.dart';

/// Read only signals can just retrieve a value but not update or cause mutations
abstract class ReadonlySignal<T> {
  ReadonlySignal._({
    required this.globalId,
    this.debugLabel,
    this.autoDispose = false,
  });

  /// Throws and error if read after dispose and can be
  /// disposed on last unsubscribe.
  final bool autoDispose;

  /// Returns true if dispose has been called and will throw and
  /// error on value read
  bool disposed = false;

  Iterable<_Listenable> get _allTargets sync* {
    for (var node = _targets; node != null; node = node._nextTarget) {
      yield node._target;
    }
  }

  void _notifyAllTargets() {
    for (var node = _targets; node != null; node = node._nextTarget) {
      node._target._notify();
    }
  }

  /// Debug label for Debug Mode
  final String? debugLabel;

  /// Global ID of the signal
  final int globalId;

  /// Compute the current value
  T get value;

  @override
  String toString() => '$value';

  /// Convert value to JSON
  T toJson() => value;

  /// Return the value when invoked
  T call() => value;

  /// Get the current value
  T get() => value;

  /// In the rare instance that you have an effect that should write to
  /// another signal based on the previous value, but you _don't_ want the
  /// effect to be subscribed to that signal, you can read a signals's
  /// previous value via `signal.peek()`.
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
  /// Note that you should only use `signal.peek()` if you really need it.
  /// Reading a signal's value via `signal.value` is the preferred way in most scenarios.
  T peek();

  /// Subscribe to value changes
  EffectCleanup subscribe(void Function(T value) fn) {
    return effect(() {
      final effect = _currentEffect!;
      final val = this.value;
      final flag = effect._flags & TRACKING;
      effect._flags &= ~TRACKING;
      try {
        fn(val);
      } finally {
        effect._flags |= flag;
      }
    });
  }

  /// @internal
  /// Version numbers should always be >= 0, because the special value -1 is used
  /// by Nodes to signify potentially unused but recyclable nodes.
  int _version = 0;

  // @internal
  _Node? _node;

  // @internal
  _Node? _targets;

  bool _refresh();

  final _disposeCallbacks = <void Function()>{};

  /// Add a cleanup function to be called when the signal is disposed
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final effectCount = signal(0);
  ///
  /// final cleanup = counter.onDispose(() {
  ///  print('Counter has been disposed');
  /// });
  ///
  /// // Remove the cleanup function
  /// cleanup();
  /// ```
  EffectCleanup onDispose(void Function() cleanup) {
    _disposeCallbacks.add(cleanup);
    return () {
      _disposeCallbacks.remove(cleanup);
    };
  }

  /// Dispose the signal
  void dispose() {
    if (disposed) return;
    for (final cleanup in _disposeCallbacks) {
      cleanup();
    }
    disposed = true;
  }

  /// Value that the signal was created with
  T get initialValue;

  /// Previous value that was set before the current
  T? get previousValue => _previousValue;
  T? _previousValue;

  // @override
  // bool operator ==(Object other) {
  //   return other is ReadonlySignal<T> && value == other.value;
  // }

  // @override
  // int get hashCode {
  //   return Object.hashAll([
  //     globalId.hashCode,
  //     value.hashCode,
  //   ]);
  // }

  void _subscribe(_Node node) {
    if (_targets != node && node._prevTarget == null) {
      node._nextTarget = _targets;
      if (_targets != null) {
        _targets!._prevTarget = node;
      }
      _targets = node;
    }
  }

  void _unsubscribe(_Node node) {
    // Only run the unsubscribe step if the signal has any subscribers to begin with.
    if (_targets != null) {
      final prev = node._prevTarget;
      final next = node._nextTarget;
      if (prev != null) {
        prev._nextTarget = next;
        node._prevTarget = null;
      }
      if (next != null) {
        next._prevTarget = prev;
        node._nextTarget = null;
      }
      if (node == _targets) {
        _targets = next;
      }
    }
  }
}
