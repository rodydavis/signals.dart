import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ticker = tickerSignal();

  late final controller = ticker.toAnimationController(
    duration: const Duration(seconds: 3),
  )..repeat(
      reverse: true,
      period: const Duration(seconds: 3),
    );

  late final curve = CurvedAnimation(
    parent: controller,
    curve: Curves.easeInOut,
  );

  final size = signal(const Size(0, 0));

  late final circles = List.generate(
    100,
    (index) {
      final rdm = Random(index);
      final start = Offset(
        rdm.nextInt(this.size.value.width.toInt()).toDouble(),
        rdm.nextInt(this.size.value.height.toInt()).toDouble(),
      );
      final end = Offset(
        rdm.nextInt(this.size.value.width.toInt()).toDouble(),
        rdm.nextInt(this.size.value.height.toInt()).toDouble(),
      );
      final size = Size.square(min(10, rdm.nextInt(100).toDouble()));
      final startRect = start & size;
      final endRect = end & size;
      final animation = RectTween(
        begin: startRect,
        end: endRect,
      ).animate(curve);
      return valueListenableToSignal(animation);
    },
  );

  @override
  Widget build(BuildContext context) {
    size.value = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          for (final rect in circles)
            Watch((context, _) {
              return AnimatedPositioned.fromRect(
                rect: rect.value!,
                duration: kThemeAnimationDuration,
                child: Container(
                  color: Colors.red,
                  child: const SizedBox.expand(),
                ),
              );
            }),
        ],
      ),
    );
  }
}
