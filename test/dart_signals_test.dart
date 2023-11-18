import 'package:test/test.dart';

import 'package:signals/signals.dart';

void main() {
  test('init', () {
    // Create signals
    final count = signal(0);
    final multiplier = signal(2);

    // Creating a computed value
    final multipliedCount = computed(() {
      return count.value * multiplier.value;
    });

    effect(() {
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
