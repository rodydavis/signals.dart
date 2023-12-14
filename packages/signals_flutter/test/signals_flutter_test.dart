import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:signals_flutter/signals_flutter.dart';

void main() {
  testWidgets('Watch', (tester) async {
    const widget = SignalWidget();

    await tester.pumpWidget(widget);
    expect(find.text('Count: 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('Count: 1'), findsOneWidget);
  });
}

class SignalWidget extends StatefulWidget {
  const SignalWidget({super.key});

  @override
  State<SignalWidget> createState() => _SignalWidgetState();
}

class _SignalWidgetState extends State<SignalWidget> {
  final counter = signal(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Signal Widget')),
        body: Watch((context) => Text('Count: $counter')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
