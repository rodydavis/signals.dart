import 'dart:math';

import 'package:signals/signals.dart';

void main() {
  SignalsObserver.instance = LoggingSignalsObserver();

  /// Recurring event
  final timer = TimerSignal(every: Duration(milliseconds: 800));

  const poolSize = 5;

  final candidate = signal(0);

  /// Signal<int> from an Iterable
  final source =
      List.generate(poolSize, (index) => generate()).toSignal('source');

  /// Each time the timer move on we take the first element of the list
  effect(() {
    // Subscribe to timer event
    // timer.value;
    // or
    timer();

    // We use peek to avoid subscription to source
    final [head, ...tail] = source.peek();

    // Batch multiple Signals at once.
    batch(() {
      source.value = tail;
      candidate.value = head;
    });
  });

  /// Display selected [candidate]
  effect(() => print("Qualified to ${candidate.value}"), 'Selection completed');

  /// Effect on source => refill
  effect(() {
    // Refill our source if required
    while (source.value.length < poolSize) {
      // Rely on ListSignal, no need to reassign source.value = ...
      // see how we bypass value
      source.add(generate());

      print("Complemented with ${source.last}: ${source.value}\n");
    }
  }, 'Refill');
}

final rdm = Random();

int generate() => rdm.nextInt(9999);
