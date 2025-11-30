import 'package:signals/signals.dart';

/// AsyncSignal emissions
void main() {
  /// Emit temporized values
  Stream<int> idEmitter() async* {
    yield 1;
    await Future.delayed(const Duration(milliseconds: 10));
    yield 2;
    await Future.delayed(const Duration(milliseconds: 10));
    yield 3;
  }

  /// First AsyncSignal emit the initial value then sync with
  /// idEmitter stream
  /// First AsyncSignal emit the initial value then sync with
  /// idEmitter stream
  final id = streamSignal(
    idEmitter,
    options: StreamSignalOptions(initialValue: 0),
  );

  /// Fetch id value as Future
  Future<String> fetch() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _id = id().value; // Rebuilds the Future when id.value changes
    await Future.delayed(const Duration(milliseconds: 5));
    return 'user$_id';
  }

  /// Sync on user emitted value with a default emission of 'guest'
  final user = fetch().toFutureSignal(
    options: StreamSignalOptions(initialValue: 'guest'),
  );

  /// When user Future resolve
  final greeting = computed(() => 'Hello, ${user.value.value}');

  effect(() {
    /// Register to $id AsyncSignal
    print('current id: ${id.requireValue}');
  });

  /// Computed Greeting emitted a new Salutation after user.value completed
  effect(() => print('greeting: $greeting'));
}
