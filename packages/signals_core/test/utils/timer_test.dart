import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
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
      options: AsyncSignalOptions(
        autoDispose: autoDispose,
        name: debugLabel,
      ),
    ),
  );
  testSignal(
    'timerSignal',
    (val, {autoDispose = false, debugLabel = 'Timer'}) => timerSignal(
      val,
      options: AsyncSignalOptions(
        autoDispose: autoDispose,
        name: debugLabel,
      ),
    ),
  );
  testSignal(
    'toSignal',
    (val, {autoDispose = false, debugLabel = 'Timer'}) => val.toSignal(
      options: AsyncSignalOptions(
        autoDispose: autoDispose,
        name: debugLabel,
      ),
    ),
  );

  group('TimerSignal fallback and deprecated options', () {
    test('TimerSignal constructor default options', () {
      final timer = TimerSignal(every: Duration(seconds: 1));
      expect(timer.every, Duration(seconds: 1));
      timer.dispose();
    });

    test('TimerSignal constructor deprecated options', () {
      // ignore: deprecated_member_use_from_same_package
      final timer = TimerSignal(
        every: Duration(seconds: 1),
        autoDispose: true,
        debugLabel: 'CustomTimerLabel',
      );
      expect(timer.every, Duration(seconds: 1));
      timer.dispose();
    });

    test('timerSignal function default options', () {
      final timer = timerSignal(Duration(seconds: 1));
      expect(timer.every, Duration(seconds: 1));
      timer.dispose();
    });

    test('timerSignal function deprecated options', () {
      // ignore: deprecated_member_use_from_same_package
      final timer = timerSignal(
        Duration(seconds: 1),
        autoDispose: true,
        debugLabel: 'CustomTimerLabel',
      );
      expect(timer.every, Duration(seconds: 1));
      timer.dispose();
    });

    test('toSignal duration extension default options', () {
      final timer = Duration(seconds: 1).toSignal();
      expect(timer.every, Duration(seconds: 1));
      timer.dispose();
    });

    test('toSignal duration extension deprecated options', () {
      // ignore: deprecated_member_use_from_same_package
      final timer = Duration(seconds: 1).toSignal(
        autoDispose: true,
        debugLabel: 'CustomTimerLabel',
      );
      expect(timer.every, Duration(seconds: 1));
      timer.dispose();
    });
  });
}
