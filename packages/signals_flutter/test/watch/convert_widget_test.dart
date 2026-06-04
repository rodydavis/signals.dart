import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

class StandardStatelessCounter extends StatelessWidget {
  final Signal<int> counter;
  final VoidCallback onBuild;

  const StandardStatelessCounter({
    super.key,
    required this.counter,
    required this.onBuild,
  });

  @override
  Widget build(BuildContext context) {
    onBuild();
    return Text('Count: ${counter.value}');
  }
}

class StandardStatefulCounter extends StatefulWidget {
  final Signal<int> counter;
  final VoidCallback onBuild;

  const StandardStatefulCounter({
    super.key,
    required this.counter,
    required this.onBuild,
  });

  @override
  State<StandardStatefulCounter> createState() =>
      _StandardStatefulCounterState();
}

class _StandardStatefulCounterState extends State<StandardStatefulCounter> {
  @override
  Widget build(BuildContext context) {
    widget.onBuild();
    return Text('Count: ${widget.counter.value}');
  }
}

void main() {
  group('Convert Widget Tests', () {
    testWidgets(
        'StatelessWidget toSignalWidget compiles and tracks signals implicitly',
        (tester) async {
      final counter = signal(10);
      int buildCount = 0;

      final statelessWidget = StandardStatelessCounter(
        counter: counter,
        onBuild: () => buildCount++,
      );

      final converted = statelessWidget.toSignalWidget();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: converted,
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Count: 10'), findsOneWidget);

      counter.value = 11;
      await tester.pumpAndSettle();

      expect(buildCount, 2);
      expect(find.text('Count: 11'), findsOneWidget);
    });

    testWidgets(
        'StatefulWidget toSignalStatefulWidget compiles and tracks signals implicitly',
        (tester) async {
      final counter = signal(20);
      int buildCount = 0;

      final statefulWidget = StandardStatefulCounter(
        counter: counter,
        onBuild: () => buildCount++,
      );

      final converted = statefulWidget.toSignalStatefulWidget();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: converted,
          ),
        ),
      );

      expect(buildCount, 1);
      expect(find.text('Count: 20'), findsOneWidget);

      counter.value = 21;
      await tester.pumpAndSettle();

      expect(buildCount, 2);
      expect(find.text('Count: 21'), findsOneWidget);
    });

    testWidgets('StatelessElementConvertExtension watchSignal', (tester) async {
      final counter = signal(100);
      final widget =
          StandardStatelessElementWatch(counter: counter).toSignalWidget();
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
      expect(find.text('Stateless: 100'), findsOneWidget);

      counter.value = 101;
      await tester.pumpAndSettle();
      expect(find.text('Stateless: 101'), findsOneWidget);
    });

    testWidgets('StatefulElementConvertExtension watchSignal', (tester) async {
      final counter = signal(200);
      final widget = StandardStatefulElementWatch(counter: counter)
          .toSignalStatefulWidget();
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
      expect(find.text('Stateful: 200'), findsOneWidget);

      counter.value = 201;
      await tester.pumpAndSettle();
      expect(find.text('Stateful: 201'), findsOneWidget);
    });
  });
}

class StandardStatelessElementWatch extends StatelessWidget {
  final Signal<int> counter;

  const StandardStatelessElementWatch({
    super.key,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    (context as StatelessElement).watchSignal(counter);
    return Text('Stateless: ${counter.peek()}');
  }
}

class StandardStatefulElementWatch extends StatefulWidget {
  final Signal<int> counter;

  const StandardStatefulElementWatch({
    super.key,
    required this.counter,
  });

  @override
  State<StandardStatefulElementWatch> createState() =>
      _StandardStatefulElementWatchState();
}

class _StandardStatefulElementWatchState
    extends State<StandardStatefulElementWatch> {
  @override
  Widget build(BuildContext context) {
    (context as StatefulElement).watchSignal(widget.counter);
    return Text('Stateful: ${widget.counter.peek()}');
  }
}
