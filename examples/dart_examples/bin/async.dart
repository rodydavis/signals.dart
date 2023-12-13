import 'package:signals/signals.dart';

/// AsyncSignal emissions
void main() {
  /// Fetch id value as Future
  Future<String> fetch(int id) async =>
      Future.delayed(const Duration(milliseconds: 5), () => 'Future::$id');

  /// Emit temporised values
  Stream<int> idEmitter() async* {
    yield 1;
    await Future.delayed(const Duration(milliseconds: 10));
    yield 2;
    await Future.delayed(const Duration(milliseconds: 10));
    yield 3;
  }

  /// First AsyncSignal emit the initial value then sync with
  /// idEmitter stream
  final id = streamSignal(idEmitter, initialValue: 0);

  /// Sync on user emitted value with a default emission of 'guest'
  final user = fetch(id.value.requireValue).toSignal(initialValue: 'guest');

  /// When user Future resolve
  final greeting = computed(() => 'Hello, ${user.value}');

  effect(() {
    /// Register to $id AsyncSignal
    print('current id: ${id.requireValue}');

    /// Configure new emission after Fetch resolve with id.value
    user.resetFuture(() => fetch(id.value.requireValue));
  });

  /// Computed Greeting emitted a new Salutation after user.value completed
  effect(() => print('greeting: $greeting'));
}
