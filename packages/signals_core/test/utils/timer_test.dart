import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  
  void testSignal(
    String message,
    TimerSignal Function(
      Duration, {
      bool autoDispose,
      String debugLabel,
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
    (val, {autoDispose = false, debugLabel = 'Timer'}) => TimerSignal(
      every: val,
      autoDispose: autoDispose,
      debugLabel: debugLabel,
    ),
  );
  testSignal(
    'timerSignal',
    (val, {autoDispose = false, debugLabel = 'Timer'}) => timerSignal(
      val,
      autoDispose: autoDispose,
      debugLabel: debugLabel,
    ),
  );
  testSignal(
    'toSignal',
    (val, {autoDispose = false, debugLabel = 'Timer'}) => val.toSignal(
      autoDispose: autoDispose,
      debugLabel: debugLabel,
    ),
  );
}
