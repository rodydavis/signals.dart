import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final backgroundColorSignal = Signal(Colors.white);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Watch(
        (_) {
          final backgroundColor = backgroundColorSignal.value;

          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      backgroundColorSignal.value =
                          backgroundColor == Colors.white
                              ? Colors.teal
                              : Colors.white;
                    },
                    child: const Text('Change background color'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
