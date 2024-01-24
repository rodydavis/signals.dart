import 'package:flutter/scheduler.dart';

import '../../../signals_flutter.dart';

final onPersistentFrameSignal = signal<Duration>(Duration.zero);

final onScheduleFrameSignal = signal<Duration>(Duration.zero);

final timingsSignal = listSignal<FrameTiming>([]);

bool _setup = false;

/// Call this method in main to setup the signals to
/// react to the SchedulerBinding instance
///
/// ```dart
/// void main() {
///   ...
///   initSchedulerBindingSignals();
///   runApp(...);
/// }
/// ```
///
/// Then in your application you can react to the timings,
/// onFrame and onScheduleFrame signals. This is useful for
/// driving animation outside of widgets.
///
/// ```dart
/// effect(() {
///   print('on persistent frame: $onPersistentFrameSignal');
/// });
///
/// effect(() {
///   print('on schedule frame: $onScheduleFrameSignal');
/// });
///
/// effect(() {
///   print('on timings: $timingsSignal');
/// });
/// ```
void initSchedulerBindingSignals([SchedulerBinding? binding]) {
  if (_setup) return;
  _setup = true;

  final schedulerBinding = binding ?? SchedulerBinding.instance;

  schedulerBinding
    ..addPersistentFrameCallback(onPersistentFrameSignal.set)
    ..addTimingsCallback(timingsSignal.set)
    ..scheduleFrameCallback(onScheduleFrameSignal.set, rescheduling: false);
}
