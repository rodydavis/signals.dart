// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

// Test SignalWidget using Dart 3.13+ Primary Constructor syntax
class PrimaryConstructorSignalWidget({
  super.key,
  required final ReadonlySignal<int> counter,
}) extends SignalWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Count: ${counter.value}', textDirection: TextDirection.ltr);
  }
}

// Test SignalStatefulWidget using Dart 3.13+ Primary Constructor syntax
class PrimaryConstructorStatefulWidget({
  super.key,
  required final Signal<int> counter,
}) extends SignalStatefulWidget {
  @override
  State<PrimaryConstructorStatefulWidget> createState() =>
      _PrimaryConstructorStatefulWidgetState();
}

class _PrimaryConstructorStatefulWidgetState
    extends State<PrimaryConstructorStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Stateful Count: ${widget.counter.value}',
      textDirection: TextDirection.ltr,
    );
  }
}

void main() {
  SignalsObserver.instance = null;

  group('Primary Constructor with SignalWidget', () {
    testWidgets('Stateless SignalWidget tracks signal updates correctly',
        (tester) async {
      final counter = signal(0);

      await tester.pumpWidget(
        PrimaryConstructorSignalWidget(counter: counter),
      );

      expect(find.text('Count: 0'), findsOneWidget);

      counter.value = 5;
      await tester.pump();

      expect(find.text('Count: 5'), findsOneWidget);

      counter.value = 10;
      await tester.pump();

      expect(find.text('Count: 10'), findsOneWidget);
    });

    testWidgets('Stateful SignalStatefulWidget tracks signal updates correctly',
        (tester) async {
      final counter = signal(100);

      await tester.pumpWidget(
        PrimaryConstructorStatefulWidget(counter: counter),
      );

      expect(find.text('Stateful Count: 100'), findsOneWidget);

      counter.value = 200;
      await tester.pump();

      expect(find.text('Stateful Count: 200'), findsOneWidget);
    });

    testWidgets('Multiple primary constructor widgets update independently',
        (tester) async {
      final counterA = signal(1);
      final counterB = signal(2);

      await tester.pumpWidget(
        Column(
          textDirection: TextDirection.ltr,
          children: [
            PrimaryConstructorSignalWidget(
              key: const ValueKey('widgetA'),
              counter: counterA,
            ),
            PrimaryConstructorSignalWidget(
              key: const ValueKey('widgetB'),
              counter: counterB,
            ),
          ],
        ),
      );

      expect(find.text('Count: 1'), findsOneWidget);
      expect(find.text('Count: 2'), findsOneWidget);

      counterA.value = 10;
      await tester.pump();

      expect(find.text('Count: 10'), findsOneWidget);
      expect(find.text('Count: 2'), findsOneWidget);

      counterB.value = 20;
      await tester.pump();

      expect(find.text('Count: 10'), findsOneWidget);
      expect(find.text('Count: 20'), findsOneWidget);
    });
  });
}
