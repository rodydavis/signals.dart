import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals_flutter.dart';

class Settings {
  Settings(this.prefs);
  final SharedPreferences prefs;
  final List<EffectCleanup> _cleanup = [];

  Signal<T> _setting<T>(
    String key, {
    required T Function(String) get,
    required void Function(String, T?) set,
  }) {
    final s = signal<T>(get(key));
    _cleanup.add(s.subscribe((val) => set(key, val)));
    return s;
  }

  late Signal<int> counter = _setting(
    'counter',
    get: (key) => prefs.getInt(key) ?? 0,
    set: (key, val) {
      if (val == null) {
        prefs.remove(key);
      } else {
        prefs.setInt(key, val);
      }
    },
  );

  late Signal<ThemeMode> themeMode = _setting(
    'theme-mode',
    get: (key) => ThemeMode.values[prefs.getInt(key) ?? ThemeMode.system.index],
    set: (key, val) {
      if (val == null) {
        prefs.remove(key);
      } else {
        prefs.setInt(key, val.index);
      }
    },
  );

  late Signal<String?> userId = _setting(
    'user-id',
    get: (key) => prefs.getString(key),
    set: (key, val) {
      if (val == null) {
        prefs.remove(key);
      } else {
        prefs.setString(key, val);
      }
    },
  );

  late Signal<bool> demoMode = _setting(
    'demo-mode',
    get: (key) => prefs.getBool(key) ?? false,
    set: (key, val) {
      if (val == null) {
        prefs.remove(key);
      } else {
        prefs.setBool(key, val);
      }
    },
  );

  void dispose() {
    for (final cb in _cleanup) {
      cb();
    }
  }
}

late final Signal<Settings> settings;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  settings = signal<Settings>(
    Settings(prefs),
    options: SignalOptions(autoDispose: true),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settings().themeMode.watch(context),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  void _incrementCounter() {
    settings().counter.value++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'Reset Counter',
            onPressed: () => settings().counter.value = 0,
            icon: const Icon(Icons.restore),
          ),
          PopupMenuButton<ThemeMode>(
            initialValue: settings().themeMode.watch(context),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: ThemeMode.system,
                child: Text('System Brightness'),
              ),
              PopupMenuItem(
                value: ThemeMode.light,
                child: Text('Light Mode'),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Text('Dark Mode'),
              ),
            ],
            onSelected: settings().themeMode.set,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${settings().counter.watch(context)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
