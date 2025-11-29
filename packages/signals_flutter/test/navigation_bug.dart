import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  testWidgets(
    'watch with forced hashCode collision demonstrates bug',
    (WidgetTester tester) async {
      final counter = signal(0);
      const collisionHash = 999999;

      await tester.pumpWidget(
        MaterialApp(
          home: _CollisionWidget(
            counter: counter,
            forcedHash: collisionHash,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Count: 0'), findsOneWidget);

      counter.value = 1;
      await tester.pumpAndSettle();
      expect(find.text('Count: 1'), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Text('Away')),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Away'), findsOneWidget);

      await tester.pumpWidget(
        MaterialApp(
          home: _CollisionWidget(
            counter: counter,
            forcedHash: collisionHash,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Count: 1'), findsOneWidget);

      counter.value = 2;
      await tester.pumpAndSettle();

      expect(
        find.text('Count: 2'),
        findsOneWidget,
        reason: 'Widget should rebuild when signal changes after re-navigation',
      );
    },
  );
}

class _CollisionWidget extends StatefulWidget {
  const _CollisionWidget({
    required this.counter,
    required this.forcedHash,
  });

  final Signal<int> counter;
  final int forcedHash;

  @override
  State<_CollisionWidget> createState() => _CollisionWidgetStateWithHash();

  @override
  StatefulElement createElement() => _CollisionElement(this);
}

class _CollisionElement extends StatefulElement {
  _CollisionElement(super.widget);

  @override
  int get hashCode => (widget as _CollisionWidget).forcedHash;
}

class _CollisionWidgetStateWithHash extends State<_CollisionWidget> {
  @override
  Widget build(BuildContext context) {
    final count = widget.counter.watch(context);
    return Scaffold(
      body: Center(
        child: Text('Count: $count'),
      ),
    );
  }
}

class _TestPage extends StatelessWidget {
  const _TestPage({required this.counter, super.key});

  final Signal<int> counter;

  @override
  Widget build(BuildContext context) {
    final count = counter.watch(context);
    return Scaffold(
      body: Center(
        child: Text('Count: $count'),
      ),
    );
  }
}
