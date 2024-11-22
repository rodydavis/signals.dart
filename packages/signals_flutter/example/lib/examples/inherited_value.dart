import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final signal$ = signal(0);
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: InheritedValue(
            value: value,
            child: Column(
              children: [
                Example(signal$: signal$),
                ElevatedButton(
                  onPressed: () {
                    signal$.value++;
                  },
                  child: const Text('Signal++'),
                ),
                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      final model = InheritedValue.of(context);
                      if (mounted) {
                        setState(() {
                          value = model.value + 1;
                        });
                      }
                    },
                    child: const Text('Value++'),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Example extends StatelessWidget {
  const Example({
    super.key,
    required this.signal$,
  });

  final ReadonlySignal<int> signal$;

  @override
  Widget build(BuildContext context) {
    final value = InheritedValue.of(context);
    return Watch((context, _) {
      final other = signal$.value;
      return Text('value: $value, other: $other');
    });
  }
}

class InheritedValue extends InheritedWidget {
  const InheritedValue({
    super.key,
    required super.child,
    required this.value,
  });

  final int value;

  static InheritedValue of(BuildContext context) {
    final widget = context //
        .dependOnInheritedWidgetOfExactType<InheritedValue>()!;
    return widget;
  }

  @override
  bool updateShouldNotify(covariant InheritedValue oldWidget) {
    return oldWidget.value != value;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return value.toString();
  }
}
