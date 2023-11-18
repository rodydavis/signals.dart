import 'package:test/test.dart';

import 'package:dart_signals/dart_signals.dart';

void main() {
  test('init', () {
    // Create signals
    final count = createSignal(0);
    final multiplier = createSignal(2);

    // Creating a computed value
    final multipliedCount = createComputed(() {
      return count.value * multiplier.value;
    });

    createEffect(() {
      print(
          'Effect called: Count is ${count.value} and multiplier is ${multiplier.value}');
    });

    expect(multipliedCount.value, 0);

    count.value = 1;
    expect(multipliedCount.value, 2);

    multiplier.value = 3;
    expect(multipliedCount.value, 3);
  });
}
