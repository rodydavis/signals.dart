import 'package:signals/signals.dart';

void main() {
  final s = signal(0);
  // This should trigger signals_prefer_unified_options
  s.subscribe((val) {}, fireImmediately: true);
}
