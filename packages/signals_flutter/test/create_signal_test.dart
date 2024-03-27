import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:signals_flutter/signals_flutter.dart';

void main() {
  testWidgets('createSignal', (tester) async {
    const widget = _SignalWidget();
    expect(_SignalWidgetState.rebuildCount, 0);

    await tester.pumpWidget(widget);
    expect(_SignalWidgetState.rebuildCount, 1);
    expect(find.text('Brightness: light'), findsOneWidget);
    expect(find.text('Count: 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(_SignalWidgetState.rebuildCount, 2);
    expect(find.text('Count: 1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(_SignalWidgetState.rebuildCount, 3);
    expect(find.text('Count: 2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.brightness_auto));
    await tester.pumpAndSettle();
    expect(_SignalWidgetState.rebuildCount, 4);
    expect(find.text('Brightness: dark'), findsOneWidget);
  });
}

class _SignalWidget extends StatefulWidget {
  const _SignalWidget();

  static final labelKey = UniqueKey();

  @override
  State<_SignalWidget> createState() => _SignalWidgetState();
}

class _SignalWidgetState extends State<_SignalWidget> {
  static int rebuildCount = 0;
  late final counter = createSignal(this, 0);
  late final dark = createSignal(this, false);

  @override
  Widget build(BuildContext context) {
    rebuildCount++;
    return MaterialApp(
      theme: ThemeData(
        brightness: dark() ? Brightness.dark : Brightness.light,
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Count: $counter',
              key: _SignalWidget.labelKey,
            ),
            Builder(builder: (context) {
              final theme = Theme.of(context).brightness;
              return Text(
                'Brightness: ${theme.name}',
                key: _SignalWidget.labelKey,
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
