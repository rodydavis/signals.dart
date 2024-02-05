import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  int buildCount = 0;
  final causeRebuild = signal(0);

  void callback() {
    print("listen callback triggered");
  }

  @override
  Widget build(BuildContext context) {
    print("build [${++buildCount}] times");
    causeRebuild.listen(context, () {
      print("listen callback triggered");
    });
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () => causeRebuild.value++,
            child: Text("pressed [${causeRebuild.watch(context)}] times"),
          ),
        ),
      ),
    );
  }
}
