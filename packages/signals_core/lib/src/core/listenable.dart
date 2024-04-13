part of 'signals.dart';

/// Signal listenable that both [Computed] and [Effect] extend
abstract class SignalListenable {
  _Node? _sources;

  int get _flags;

  /// Debug label for Debug Mode
  String? get debugLabel;

  /// Global ID of the signal
  int get globalId;

  void _notify();

  /// Dispose of the instance
  void dispose();
}
