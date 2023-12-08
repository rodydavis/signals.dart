import 'package:signals/signals.dart';

void main() {
  final complete = signal(false);
  final result = signal<String?>(null);

  Future<String> fetch() async {
    await Future.delayed(const Duration(milliseconds: 5));
    return 'Hello';
  }

  effect(() {
    if (complete()) return;
    fetch().then((value) {
      batch(() {
        result.value = value;
        complete.value = true;
      });
    });
  });
}
