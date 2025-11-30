import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  
  testWidgets('watch/unwatch', (tester) async {
    final key = GlobalKey();
    final widget = _Example(key: key);

    await tester.pumpWidget(widget);
    final state = key.currentState as _ExampleState;

    expect(state.count.value, 0);
    expect(find.text('Count: 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(state.count.value, 1);
    expect(find.text('Count: 0'), findsOneWidget);

    state.watch();
    await tester.pumpAndSettle();

    expect(state.count.value, 1);
    expect(find.text('Count: 1'), findsOneWidget);

    state.unwatch();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(state.count.value, 2);
    expect(find.text('Count: 1'), findsOneWidget);
  });
}

class _Example extends StatefulWidget {
  const _Example({super.key});

  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example> {
  final count = signal(0);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text('Count: $count'),
        floatingActionButton: FloatingActionButton(
          onPressed: increment,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void watch() => watchSignal(context, count);
  void unwatch() => unwatchSignal(context, count);
  void increment() => count.value++;
}
