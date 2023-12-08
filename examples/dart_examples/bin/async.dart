import 'package:signals/signals.dart';

void main() {
  Future<String> fetch(int id) async {
    await Future.delayed(const Duration(milliseconds: 5));
    return '$id';
  }

  Stream<int> idChanges() async* {
    yield 1;
    await Future.delayed(const Duration(milliseconds: 5));
    yield 2;
    await Future.delayed(const Duration(milliseconds: 5));
    yield 3;
  }

  final id = streamSignalWithDefault(
    idChanges,
    initialValue: 0,
  );
  final user = futureSignalWithDefault(
    () => fetch(id.value),
    initialValue: 'guest',
  );
  final greeting = computed(() => 'Hello, $user');

  effect(() {
    print('current id: $id');
    user.resetFuture(() => fetch(id.value));
  });

  effect(() {
    print('greeting: $greeting');
  });
}
