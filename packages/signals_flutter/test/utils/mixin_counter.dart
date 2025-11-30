import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class MixinCounter extends StatefulWidget {
  const MixinCounter({
    required this.createSource,
    this.createReader,
    this.rebuilds,
    super.key,
    this.watch = true,
    this.builder = false,
    this.init,
  });

  final ValueChanged<int>? rebuilds;
  final void Function(BuildContext)? init;
  final bool watch;
  final bool builder;
  final Signal<int> Function(BuildContext context, MixinCounterState self) createSource;
  final ReadonlySignal<int> Function(BuildContext context, MixinCounterState self)? createReader;

  @override
  State<MixinCounter> createState() => MixinCounterState();
}

class MixinCounterState extends State<MixinCounter> with SignalsMixin {
  late final source = widget.createSource(context, this);
  late final display = widget.createReader?.call(context, this) ?? source;
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
        body: Text('Count: $display'),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => source.value++,
        ),
      ),
    );
  }
}
