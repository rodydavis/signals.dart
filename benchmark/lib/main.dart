import 'dart:async';

import 'package:benchmarking/benchmarking.dart' hide Benchmark;

// ignore: implementation_imports
import 'package:benchmarking/src/printer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'src/benchmark.dart';
import 'src/libraries/signals.dart';
import 'src/libraries/solidart.dart';
import 'src/libraries/state_beacon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: BenchmarkViewer(
        benchmarks: [
          SignalsBenchmark(),
          SolidartBenchmark(),
          StateBeaconBenchmark(),
        ],
        units: 10000,
      ),
    );
  }
}

class BenchmarkViewer extends StatefulWidget {
  const BenchmarkViewer({
    super.key,
    required this.benchmarks,
    required this.units,
  });

  final List<Benchmark> benchmarks;
  final int units;

  @override
  State<BenchmarkViewer> createState() => _BenchmarkViewerState();
}

class _BenchmarkViewerState extends State<BenchmarkViewer> {
  StringBuffer sb = StringBuffer();
  // final controller = TextEditingController();
  final output = StreamController<String>();
  bool active = false;

  @override
  void initState() {
    super.initState();
    output.stream.listen((event) {
      print(event);
      sb.writeln(event);
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    output.close();
    super.dispose();
  }

  void run() async {
    sb = StringBuffer();
    active = true;
    output.add('Running benchmark...');
    output.add('');
    final numbers = List.generate(widget.units, (i) => i);
    for (final benchmark in widget.benchmarks) {
      output.add('## ${benchmark.name}');
      output.add('');
      {
        final signals = {for (var n in numbers) benchmark.createValue(n)};
        runTest('increment int value', () {
          for (final instance in signals) {
            instance.value++;
          }
        });
      }
      {
        final signals = <(ValueContainer, ComputedValueContainer)>[];
        for (var n in numbers) {
          final source = benchmark.createValue(n);
          final computed = benchmark.createComputed(() => source.value);
          signals.add((source, computed));
        }
        runTest('1 value + 1 computed', () {
          for (final instance in signals) {
            final (source, computed) = instance;
            computed.value;
            source.value++;
            computed.value;
          }
        });
      }
      {
        final signals = <(ValueContainer, List<ComputedValueContainer>)>[];
        const depth = 100;
        for (var n in numbers) {
          final source = benchmark.createValue(n);
          final computed = <ComputedValueContainer>[
            benchmark.createComputed(() => source.value)
          ];
          for (var i = 0; i < depth; i++) {
            final last = computed.last;
            computed.add(benchmark.createComputed(() => last.value));
          }

          signals.add((source, computed));
        }
        runTest('1 value + $depth computed', () {
          for (final instance in signals) {
            final (source, computed) = instance;
            computed.last.value;
            source.value++;
            computed.last.value;
          }
        });
      }
      {
        // 5 x 5 x 5
        const count = 5;
        final layer1 = <ValueContainer>[];
        final layer2 = <ComputedValueContainer>[];
        final layer3 = <ComputedValueContainer>[];
        for (var i = 0; i < count; i++) {
          layer1.add(benchmark.createValue(i));
        }
        for (var i = 0; i < count; i++) {
          layer2.add(benchmark.createComputed(() {
            num sum = 0;
            for (final item in layer1) {
              sum += (item.value as num);
            }
            return sum;
          }));
        }
        for (var i = 0; i < count; i++) {
          layer3.add(benchmark.createComputed(() {
            num sum = 0;
            for (final item in layer2) {
              sum += (item.value as num);
            }
            return sum;
          }));
        }
        runTest('$count value x $count computed x $count computed', () {
          for (var i = 0; i < widget.units; i++) {
            for (final instance in layer3) {
              instance.value;
            }
            for (final instance in layer1) {
              final val = instance.value as num;
              instance.value = val + 1;
            }
            for (final instance in layer2) {
              instance.value;
            }
            for (final instance in layer1) {
              final val = instance.value as num;
              instance.value = val + 1;
            }
            for (final instance in layer3) {
              instance.value;
            }
          }
        });
      }
    }
    active = false;
    output.add('Benchmark complete!');
    output.add('');
  }

  void runTest(
    String name,
    void Function() cb, {
    int? units,
  }) {
    final count = units ?? widget.units;
    final result = syncBenchmark(name, cb);
    output.add('### $name');
    output.add('');
    output.add('| key | value |');
    output.add('| -- | -- |');
    output.add('| total runs | ${result.runs} |');
    output.add(
        '| total time | ${Printer.formatMicroseconds(result.totalRunTime.inMicroseconds)} |');
    output.add(
        '| average run | ${Printer.formatMicroseconds(result.averageRunTime.inMicroseconds)} |');
    output.add('| runs/second | ${result.runsPerSecond} |');
    output.add('| units | $count |');
    output.add('| units/second | ${result.unitsPerSecond(count)} |');
    output.add(
        '| time per unit | ${Printer.formatMicroseconds(result.microsecondsPerUnit(count))} |');
    output.add('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Benchmark'),
        actions: [
          IconButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              await Clipboard.setData(ClipboardData(text: sb.toString()));
              messenger.showSnackBar(
                const SnackBar(content: Text('Benchmark copied to clipboard!')),
              );
            },
            icon: const Icon(Icons.copy),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: SelectionArea(
          child: Markdown(
            data: sb.toString(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: active ? null : run,
        child: Icon(active ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
