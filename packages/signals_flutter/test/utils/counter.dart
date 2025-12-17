import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class Counter extends StatefulWidget {
  const Counter({
    required this.createSource,
    this.createReader,
    required this.callback,
    this.rebuilds,
    super.key,
    this.watch = true,
    this.builder = false,
    this.init,
  });

  final ValueChanged<int>? rebuilds;
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
  int calls = 0;

  @override
  void initState() {
    super.initState();
    widget.init?.call(context);
  }

  @override
  Widget build(BuildContext context) {
    widget.rebuilds?.call(++calls);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: () {
          if (widget.watch) {
            if (widget.builder) {
              return Watch.builder(
                builder: (context) {
                  widget.callback();
                  return Text('Count: $display');
                },
              );
            } else {
              return Watch((context) {
                widget.callback();
                return Text('Count: $display');
              });
            }
          } else {
            return Builder(
              builder: (context) {
                widget.callback();
                return Text('Count: ${display.watch(context)}');
              },
            );
          }
        }(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => source.value++,
        ),
      ),
    );
  }
}
