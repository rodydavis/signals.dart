import 'dart:math';

import 'package:signals/signals.dart';

void main() {
  /*
  Signal<bool> from a periodic Stream
   */
  final timer =
      Stream.periodic(const Duration(milliseconds: 2000), (ms) {}).toSignal();

  const poolSize = 5;

  final candidat = signal(0);

  /*
  Signal<int> from an Iterable
   */
  final source = List.generate(poolSize, (index) => generate()).toSignal();

  /// Each time the timer move on we take the first element of the list
  effect(() {
    // Subscribe to timer event
    timer.value;

    // We use peak to avoid subscription to source
    final [head, ...tail] = source.peek();

    // Batch multiple Signals at once.
    batch(() {
      source.value = tail;
      candidat.value = head;
    });
  });

  effect(() => print("Qualified to ${candidat.value}"));

  /// Effect on source => refill
  effect(() {
    // Refill our source if required
    while (source.value.length < poolSize) {
      final complement = generate();

      // Rely on ListSignal, no need to reassign source.value = ...
      source.value.add(complement);

      print("Complemented with $complement: ${source.value}\n");
    }
  });
}

final rdm = Random();

int generate() => rdm.nextInt(9999);
