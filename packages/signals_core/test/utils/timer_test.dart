import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  void testSignal(
    String message,
    TimerSignal Function(
      Duration, {
      StreamSignalOptions? options,
    }) create,
  ) {
    group('$message test', () {
      test('history', () async {
        final timer = create(Duration(seconds: 1));
        final stream = timer.toStream();

        await Future.delayed(const Duration(seconds: 2));
        timer.dispose();

        final list = await stream.toList();

        expect(list.isNotEmpty, true);
      });
    });
  }

  testSignal(
    'TimerSignal',
    (val, {options}) => TimerSignal(
      val,
      options: options as StreamSignalOptions<TimerSignalEvent>?,
    ),
  );
  testSignal(
    'timerSignal',
    (val, {options}) => timerSignal(
      val,
      options: options as StreamSignalOptions<TimerSignalEvent>?,
    ),
  );
  testSignal(
    'toSignal',
    (val, {options}) => val.toSignal(
      options: options as StreamSignalOptions<TimerSignalEvent>?,
    ),
  );
}
