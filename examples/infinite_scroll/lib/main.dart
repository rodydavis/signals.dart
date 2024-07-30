import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  ThemeData createTheme(BuildContext context, Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: brightness,
      ),
      brightness: brightness,
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite Scroll Demo',
      debugShowCheckedModeBanner: false,
      theme: createTheme(context, Brightness.light),
      darkTheme: createTheme(context, Brightness.dark),
      themeMode: ThemeMode.system,
      home: InfiniteScroll(source: StringListSource([])),
    );
  }
}

abstract class DataSource<T> extends AsyncSignal<List<T>> {
  final int totalPages;
  final page = signal(0);

  late final hasMore = computed(() => page.value < totalPages);

  DataSource(List<T> data, this.totalPages) : super(AsyncState.data(data));

  Future<List<T>> _fetch(int page) async {
    batch(() {
      setLoading(value);
    });

    await Future.delayed(const Duration(seconds: 1));

    try {
      final result = await getData(page);

      batch(() {
        this.page.value = page;
        final current = value.value ?? [];
        setValue(current + result);
      });

      return result;
    } catch (err, trace) {
      setError(err, trace);
      return [];
    }
  }

  Future<void> checkForMore() async {
    if (value.isLoading) return;
    if (!hasMore()) return;
    await _fetch(page.value + 1);
  }

  Future<List<T>> getData(int page);
}

class StringListSource extends DataSource<String> {
  StringListSource(List<String> data) : super(data, 100);

  @override
  Future<List<String>> getData(int page) async {
    final rdm = Random();
    final count = rdm.nextInt(100);
    final values = List.generate(count, (index) {
      const letters = 'abcdefghijklmnopqrstuvwxyz1234567890';
      var s = '';
      for (var i = 0; i < 20; i++) {
        final t = rdm.nextInt(letters.length);
        var l = letters[t];
        s += l;
      }
      return s;
    });
    await Future.delayed(Duration(seconds: rdm.nextInt(3)));
    return values;
  }
}

class InfiniteScroll extends StatelessWidget {
  const InfiniteScroll({
    super.key,
    required this.source,
  });

  final StringListSource source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scroll'),
      ),
      body: Watch.builder(
        builder: (context) {
          final items = source.value.value ?? [];
          final more = source.hasMore();
          if (items.isEmpty) {
            source.checkForMore();
            return source.value.maybeMap(
              error: (err) => Center(child: Text('Error loading items: $err')),
              orElse: () => const Center(child: CircularProgressIndicator()),
            );
          }
          return RefreshIndicator(
            onRefresh: source.reload,
            child: ListView.builder(
              itemCount: () {
                if (more) return items.length + 1;
                return items.length;
              }(),
              itemBuilder: (context, index) {
                if (more && index == items.length) {
                  source.checkForMore();
                  return const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final item = items[index];
                return ListTile(
                  title: Text(item),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
