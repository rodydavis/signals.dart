Linter and developer tools for [signals](https://pub.dev/packages/signals).

## Getting started

Run this command in the root of your Flutter project:

```sh
flutter pub add -d signals_lint custom_lint
```

Then edit your `analysis_options.yaml` file and add these lines of code:

```yaml
analyzer:
  plugins:
    - custom_lint
```

Then run:

```sh
flutter clean
flutter pub get
dart run custom_lint
```

## Fixes

### Wrap with Watch

Wrap any Widget with `Watch` to automatically rebuild it when a signal is emitted.

Before:

```dart
class Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello World',
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }
}
```

After:

```dart
class Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Watch((context) => Text(
        'Hello World',
        style: TextStyle(
          color: Colors.black,
        ),
      ));
  }
}
```
