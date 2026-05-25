import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AutoDisposeStatelessWidget extends SignalWidget {
  final Signal<int> counter;

  const AutoDisposeStatelessWidget({
    super.key,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Count: ${counter.value}');
  }
}

class AutoDisposeStatefulWidget extends SignalStatefulWidget {
  final Signal<int> counter;

  const AutoDisposeStatefulWidget({
    super.key,
    required this.counter,
  });

  @override
  State<AutoDisposeStatefulWidget> createState() => _AutoDisposeStatefulWidgetState();
}

class _AutoDisposeStatefulWidgetState extends State<AutoDisposeStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Text('Count: ${widget.counter.value}');
  }
}

void main() {
  setUp(() {
    SignalsObserver.instance = null;
  });

  group('Flutter autoDispose tests', () {
    testWidgets('SignalWidget (Stateless) triggers autoDispose when unmounted', (tester) async {
      final s = signal(10, autoDispose: true);
      expect(s.disposed, isFalse);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AutoDisposeStatelessWidget(counter: s),
          ),
        ),
      );

      expect(s.disposed, isFalse);

      // Unmount the widget by pumping an empty placeholder
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));

      expect(s.disposed, isTrue);
    });

    testWidgets('SignalStatefulWidget triggers autoDispose when unmounted', (tester) async {
      final s = signal(10, autoDispose: true);
      expect(s.disposed, isFalse);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AutoDisposeStatefulWidget(counter: s),
          ),
        ),
      );

      expect(s.disposed, isFalse);

      // Unmount the widget
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));

      expect(s.disposed, isTrue);
    });

    testWidgets('SignalBuilder triggers autoDispose when unmounted', (tester) async {
      final s = signal(10, autoDispose: true);
      expect(s.disposed, isFalse);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SignalBuilder(
              builder: (context) => Text('Count: ${s.value}'),
            ),
          ),
        ),
      );

      expect(s.disposed, isFalse);

      // Unmount the widget
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));

      expect(s.disposed, isTrue);
    });

    testWidgets('SignalAnimatedBuilder triggers autoDispose when unmounted', (tester) async {
      final s = signal(10, autoDispose: true);
      expect(s.disposed, isFalse);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SignalAnimatedBuilder(
              builder: (context, child) => Text('Count: ${s.value}'),
            ),
          ),
        ),
      );

      expect(s.disposed, isFalse);

      // Unmount the widget
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));

      expect(s.disposed, isTrue);
    });
  });
}
