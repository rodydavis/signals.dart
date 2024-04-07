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
import 'src/libraries/value_notifier.dart';

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
          ValueNotifierBenchmark(),
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
    addHeader();
    await Future.delayed(const Duration(milliseconds: 5));

    for (final benchmark in widget.benchmarks) {
      benchmark.setup();
      const counts = [
        0,
        1,
        10,
        100,
        // 1000,
      ];
      for (final count in counts) {
        await testIncrementWithSubsribers(benchmark, count);
      }
      benchmark.teardown();
    }
    active = false;
    output.add('');
  }

  Future<void> runTest(String name, void Function() cb) async {
    final result = syncBenchmark(name, cb);
    addResult(name, result);
    await Future.delayed(const Duration(milliseconds: 5));
  }

  void addHeader() {
    output.add('## Results');
    output.add('Date: ${DateTime.now().toIso8601String()}');
    output.add('');
    const columns = [
      'name',
      'total runs',
      'average run',
      'runs/second',
      'units/second',
      'time per unit',
      'total time',
      'units',
    ];
    output.add('| ${columns.join(' | ')} |');
    output.add('| ${columns.map((e) => '--').join(' | ')} |');
  }

  void addResult(String name, BenchmarkResult result) {
    final row = [
      name,
      '${result.runs}',
      Printer.formatMicroseconds(result.averageRunTime.inMicroseconds),
      (result.runsPerSecond.toStringAsFixed(2)),
      (result.unitsPerSecond(widget.units).toStringAsFixed(2)),
      Printer.formatMicroseconds(result.microsecondsPerUnit(widget.units)),
      Printer.formatMicroseconds(result.totalRunTime.inMicroseconds),
      '${widget.units}',
    ];
    output.add('| ${row.join(' | ')} |');
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

  Future<void> testIncrementWithSubsribers(
    Benchmark benchmark,
    int count,
  ) async {
    var name = '${benchmark.name}: signal => $count subscribers';
    final cleanup = <Function>[];
    final actions = <Function>[];
    final result = syncBenchmark(
      name,
      () {
        for (var i = 0; i < actions.length; i++) {
          final instance = actions.elementAt(i);
          instance();
        }
      },
      setup: () {
        final numbers = List.generate(widget.units, (i) => i);
        final signals = <ValueContainer<int, dynamic>>{};
        for (var n in numbers) {
          signals.add(benchmark.createValue(n));
        }
        final cleanup = <Function>[];
        for (final item in signals) {
          for (var i = 0; i < count; i++) {
            cleanup.add(item.subscribe((_) {}));
          }
        }
        for (var i = 0; i < signals.length; i++) {
          final instance = signals.elementAt(i);
          actions.add(() {
            instance.value++;
          });
        }
      },
      teardown: () {
        for (final cb in cleanup) {
          cb();
        }
      },
    );
    addResult(name, result);
    await Future.delayed(const Duration(milliseconds: 5));
  }
}
