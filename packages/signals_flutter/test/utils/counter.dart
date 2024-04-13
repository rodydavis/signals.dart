import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class Counter extends StatefulWidget {
  const Counter({
    required this.createSource,
    this.createReader,
    required this.callback,
    super.key,
    this.watch = true,
    this.builder = false,
    this.init,
  });

  final VoidCallback callback;
  final void Function(BuildContext)? init;
  final bool watch;
  final bool builder;
  final Signal<int> Function(BuildContext context) createSource;
  final ReadonlySignal<int> Function(BuildContext context)? createReader;

  @override
  State<Counter> createState() => CounterState();
}

class CounterState extends State<Counter> {
  late final source = widget.createSource(context);
  late final display = widget.createReader?.call(context) ?? source;

  @override
  void initState() {
    super.initState();
    widget.init?.call(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: widget.watch
            ? widget.builder
                ? Watch.builder(builder: (context) {
                    widget.callback();
                    return Text('Count: $display');
                  })
                : Watch((context) {
                    widget.callback();
                    return Text('Count: $display');
                  })
            : () {
                widget.callback();
                return Text('Count: ${display.watch(context)}');
              }(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => source.value++,
        ),
      ),
    );
  }
}
