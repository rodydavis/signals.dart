---
title: Persisted Signals
description: How to save and restore signals.
sidebar:
  order: 2
  badge:
    text: New
    variant: tip
---

When you need to store the state of your signals between app launches you can create a `PersistedSignal` from this example code.

You need to have a store that can be [SharedPreferences](https://pub.dev/packages/shared_preferences), [SQLite](https://pub.dev/packages/sqlite3), in memory, or any other storage solution. The store just needs to be able to save and restore the data.

```dart
abstract class KeyValueStore {
  Future<void> setItem(String key, String value);
  Future<String?> getItem(String key);
  Future<void> removeItem(String key);
}
```

You can create an in-memory store for testing:

```dart
class InMemoryStore implements KeyValueStore {
  final Map<String, String> _store = {};

  @override
  Future<String?> getItem(String key) async {
    return _store[key];
  }

  @override
  Future<void> removeItem(String key) async {
    _store.remove(key);
  }

  @override
  Future<void> setItem(String key, String value) async {
    _store[key] = value;
  }
}
```

For this example we are going to be using SharedPreferences:

```dart

class SharedPreferencesStore implements KeyValueStore {
  SharedPreferencesStore();

  SharedPreferences? prefs;

  Future<SharedPreferences> init() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!;
  }

  @override
  Future<String?> getItem(String key) async {
    final prefs = await init();
    return prefs.getString(key);
  }

  @override
  Future<void> removeItem(String key) async {
    final prefs = await init();
    prefs.remove(key);
  }

  @override
  Future<void> setItem(String key, String value) async {
    final prefs = await init();
    prefs.setString(key, value);
  }
}
```

:::note
The `SharedPreferences` will lazy load the instance when it is needed but you can also initialize before and pass it in the constructor.
:::

By default we can encode and decode the value to and from JSON:

```dart

abstract class PersistedSignal<T> extends FlutterSignal<T>
    with PersistedSignalMixin<T> {
  PersistedSignal(
    super.internalValue, {
    super.autoDispose,
    super.debugLabel,
    required this.key,
    required this.store,
  });

  @override
  final String key;

  @override
  final KeyValueStore store;
}

mixin PersistedSignalMixin<T> on Signal<T> {
  String get key;
  KeyValueStore get store;

  bool loaded = false;

  Future<void> init() async {
    try {
      final val = await load();
      super.value = val;
    } catch (e) {
      debugPrint('Error loading persisted signal: $e');
    } finally {
      loaded = true;
    }
  }

  @override
  T get value {
    if (!loaded) init().ignore();
    return super.value;
  }

  @override
  set value(T value) {
    super.value = value;
    save(value).ignore();
  }

  Future<T> load() async {
    final val = await store.getItem(key);
    if (val == null) return internalValue;
    return decode(val);
  }

  Future<void> save(T value) async {
    final str = encode(value);
    await store.setItem(key, str);
  }

  T decode(String value) => jsonDecode(value);

  String encode(T value) => jsonEncode(value);
}
```

:::note
We create a mixin so we can use it in other custom signals and share logic between signals_core and signals_flutter.
:::

This can work in a lot of cases, but we might want to handle specific cases like enums:

```dart
class EnumSignal<T extends Enum> extends PersistedSignal<T> {
  EnumSignal(super.val, String key, this.values)
      : super(
          key: key,
          store: SharedPreferencesStore(),
        );

  final List<T> values;

  @override
  T decode(String value) => values.firstWhere((e) => e.name == value);

  @override
  String encode(T value) => value.name;
}
```

Or if you are in Flutter we can persist color values:

```dart
class ColorSignal extends PersistedSignal<Color> {
  ColorSignal(super.val, String key)
      : super(
          key: key,
          store: SharedPreferencesStore(),
        );

  @override
  String encode(Color value) => value.value.toString();

  @override
  Color decode(String value) => Color(int.parse(value));
}
```

## Example

```dart
class AppTheme {
  final sourceColor = ColorSignal(
    Colors.blue,
    'sourceColor',
 );
  final themeMode = EnumSignal(
    ThemeMode.system, 'themeMode',
    ThemeMode.values,
 );

  static AppTheme instance = AppTheme();

  Future<void> init() async {
    await Future.wait([
      sourceColor.init(),
      themeMode.init(),
    ]);
  }
}

void main() async{
    final theme = AppTheme.instance;
    // We need to init before running the app to prevent the theme from flickering
    await theme.init();
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.instance;
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: theme.sourceColor.watch(context),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: theme.sourceColor.watch(context),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: theme.themeMode.watch(context),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Persisted Signals'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  theme.sourceColor.value = Colors.red;
                },
                child: Text('Change Color'),
              ),
              ElevatedButton(
                onPressed: () {
                  theme.themeMode.value = ThemeMode.dark;
                },
                child: Text('Change Theme'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

Now when we run the app and make changes, if we close the app and reopen it, the changes will persist.
