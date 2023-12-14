import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:signals_flutter/signals_flutter.dart';

void main() {
  testWidgets('Watch', (tester) async {
    const widget = SignalWidget();
    expect(_SignalWidgetState.rebuildCount, 0);
    expect(_SignalWidgetState.watchCount, 0);

    await tester.pumpWidget(widget);
    expect(_SignalWidgetState.rebuildCount, 1);
    expect(_SignalWidgetState.watchCount, 1);
    expect(find.text('Count: 0|1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('Count: 1|1'), findsOneWidget);
    expect(_SignalWidgetState.rebuildCount, 1);
    expect(_SignalWidgetState.watchCount, 2);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('Count: 2|1'), findsOneWidget);
    expect(_SignalWidgetState.rebuildCount, 1);
    expect(_SignalWidgetState.watchCount, 3);

    await tester.tap(find.byIcon(Icons.brightness_auto));
    await tester.pumpAndSettle();
    expect(find.text('Count: 2|0'), findsOneWidget);
    expect(_SignalWidgetState.rebuildCount, 2);
    expect(_SignalWidgetState.watchCount, 5);
  });
}

class SignalWidget extends StatefulWidget {
  const SignalWidget({super.key});

  @override
  State<SignalWidget> createState() => _SignalWidgetState();
}

class _SignalWidgetState extends State<SignalWidget> {
  static int rebuildCount = 0;
  static int watchCount = 0;
  final counter = signal(0);
  final dark = signal(false);

  @override
  Widget build(BuildContext context) {
    rebuildCount++;
    final isDark = dark.watch(context);
    return MaterialApp(
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Signal Widget'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_auto),
              onPressed: () => dark.value = !dark.value,
            ),
          ],
        ),
        body: Watch((context) {
          watchCount++;
          final theme = Theme.of(context).brightness;
          return Text('Count: $counter|${theme.index}');
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
