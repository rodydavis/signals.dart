import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  testWidgets('SignalProvider.multi', (tester) async {
    final s1 = signal(0);
    final s2 = signal('a');

    await tester.pumpWidget(
      SignalProvider.multi(
        signals: [
          () => s1,
          () => s2,
        ],
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              final v1 = SignalProvider.of<Signal<int>>(context);
              final v2 = SignalProvider.of<Signal<String>>(context);
              return Text('v1: \$v1, v2: \$v2');
            },
          ),
        ),
      ),
    );

    expect(find.text('v1: 0, v2: a'), findsOneWidget);
  });
}
