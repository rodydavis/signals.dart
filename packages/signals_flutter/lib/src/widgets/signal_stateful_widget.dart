import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;

/// A [StatefulWidget] that automatically tracks any signals read during its [build] phase.
///
/// Subclasses of [SignalStatefulWidget] do not need to call `.watch(context)` or wrap their build
/// in a builder; any signal value accessed synchronously inside State's [build] will automatically trigger rebuilds.
///
/// ```dart
/// final counter = signal(0);
///
/// class MyWidget extends SignalStatefulWidget {
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> {
///   @override
///   Widget build(BuildContext context) {
///     return Text('Count: ${counter.value}');
///   }
/// }
/// ```
abstract class SignalStatefulWidget extends StatefulWidget {
  /// Constructor for [SignalStatefulWidget].
  const SignalStatefulWidget({super.key});

  @override
  StatefulElement createElement() => SignalStatefulElement(this);
}

/// Element for [SignalStatefulWidget] that manages implicit signal subscription and handles dynamic branching.
class SignalStatefulElement extends StatefulElement {
  /// Constructor for [SignalStatefulElement].
  SignalStatefulElement(super.widget);

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
