import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  SignalsObserver.instance = null;
  testWidgets('listen/unlisten', (tester) async {
    final key = GlobalKey();
    int calls = 0;
    final widget = _Example(key: key, callback: () => calls++);

    await tester.pumpWidget(widget);
    final state = key.currentState as _ExampleState;

    expect(state.count.value, 0);
    expect(calls, 0);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(state.count.value, 1);
    expect(calls, 0);

    state.listen();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(state.count.value, 2);
    expect(calls, 2);

    state.unlisten();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(state.count.value, 3);
    expect(calls, 2);
  });
}

class _Example extends StatefulWidget {
  const _Example({super.key, required this.callback});
  final VoidCallback callback;

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

  void listen() => count.listen(context, widget.callback);
  void unlisten() => count.unlisten(context, widget.callback);
  void increment() => count.value++;
}
