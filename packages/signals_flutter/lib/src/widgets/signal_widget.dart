import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;

/// A [StatelessWidget] that automatically tracks any signals read during its [build] phase.
///
/// Subclasses of [SignalWidget] do not need to call `.watch(context)` or wrap their build
/// in a builder; any signal value accessed synchronously will automatically trigger rebuilds.
///
/// ```dart
/// final counter = signal(0);
///
/// class MyWidget extends SignalWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Text('Count: ${counter.value}');
///   }
/// }
/// ```
abstract class SignalWidget extends StatelessWidget {
  /// Constructor for [SignalWidget].
  const SignalWidget({super.key});

  @override
  StatelessElement createElement() => SignalElement(this);
}

/// Element for [SignalWidget] that manages implicit signal subscription and handles dynamic branching.
class SignalElement extends StatelessElement {
  /// Constructor for [SignalElement].
  SignalElement(super.widget);

  final _watch = <int, VoidCallback>{};
  bool _initializing = false;

  /// Subscribes to changes of the provided [value] and schedules a rebuild.
  void watchSignal(core.ReadonlySignal value) {
    _watch.putIfAbsent(
      value.globalId,
      () => value.subscribe((val) {
        if (_initializing) return;
        markNeedsBuild();
      }),
    );
  }

  void _updateWatch(Set<core.ReadonlySignal> signals) {
    _initializing = true;
    try {
      final toRemove = <int>[];
      _watch.forEach((id, dispose) {
        if (!signals.any((s) => s.globalId == id)) {
          dispose();
          toRemove.add(id);
        }
      });
      for (final id in toRemove) {
        _watch.remove(id);
      }
      for (final signal in signals) {
        watchSignal(signal);
      }
    } finally {
      _initializing = false;
    }
  }

  @override
  Widget build() {
    final signals = <core.ReadonlySignal>{};
    final oldOnSignalRead = core.onSignalRead;
    core.onSignalRead = (signal) {
      if (signal is core.ReadonlySignal) {
        signals.add(signal);
      }
    };

    try {
      return super.build();
    } finally {
      core.onSignalRead = oldOnSignalRead;
      if (signals.isEmpty) {
        for (final dispose in _watch.values) {
          dispose();
        }
        _watch.clear();
      } else {
        _updateWatch(signals);
      }
    }
  }

  @override
  void unmount() {
    for (final dispose in _watch.values) {
      dispose();
    }
    _watch.clear();
    super.unmount();
  }
}
