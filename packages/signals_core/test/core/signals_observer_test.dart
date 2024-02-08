import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

double _signalCreatedCount = 0;
double _signalUpdatedCount = 0;
double _computedCreatedCount = 0;
double _computedUpdatedCount = 0;

class TestSignalsObserver extends SignalsObserver {
  @override
  void onSignalCreated(Signal instance) {
    _signalCreatedCount++;
  }

  @override
  void onSignalUpdated(Signal instance, value) {
    _signalUpdatedCount++;
  }

  @override
  void onComputedCreated(Computed instance) {
    _computedCreatedCount++;
  }

  @override
  void onComputedUpdated(Computed instance, value) {
    _computedUpdatedCount++;
  }
}

void main() {
  _computedCreatedCount = 0;
  _computedUpdatedCount = 0;
  _signalCreatedCount = 0;
  _signalUpdatedCount = 0;
  SignalsObserver.instance = TestSignalsObserver();

  test('SignalsObserver', () {
    // Create signal 1
    final count = signal(0);
    // Expected observer call counts
    expect(_signalCreatedCount, 1); // +1
    expect(_signalUpdatedCount, 0);
    expect(_computedCreatedCount, 0);
    expect(_computedUpdatedCount, 0);
    // Create signal 2
    final multiplier = signal(2);
    // Expected observer call counts
    expect(_signalCreatedCount, 2); // +1
    expect(_signalUpdatedCount, 0);
    expect(_computedCreatedCount, 0);
    expect(_computedUpdatedCount, 0);
    // Creating a computed value 1
    final multipliedCount = computed(() {
      return count.value * multiplier.value;
    });
    // Expected observer call counts
    expect(_signalCreatedCount, 2);
    expect(_signalUpdatedCount, 0);
    expect(_computedCreatedCount, 1); // +1
    expect(_computedUpdatedCount, 0);
    // Expected multiplied result
    expect(multipliedCount.value, 0);
    // Reading the multiplied value in above test first time should
    // trigger its computed update count
    expect(_signalCreatedCount, 2);
    expect(_signalUpdatedCount, 0);
    expect(_computedCreatedCount, 1);
    expect(_computedUpdatedCount, 1); // +1
    // Expected multiplied result, same as before
    expect(multipliedCount.value, 0);
    // Reading the multiplied value again in should
    // NOT trigger its update count
    expect(_signalCreatedCount, 2);
    expect(_signalUpdatedCount, 0);
    expect(_computedCreatedCount, 1);
    expect(_computedUpdatedCount, 1);
    // Update the count
    count.value = 1;
    // Expected observer call counts
    expect(_signalCreatedCount, 2);
    expect(_signalUpdatedCount, 1); // +1
    expect(_computedCreatedCount, 1);
    expect(_computedUpdatedCount, 1);
    // Expected multiplied result
    expect(multipliedCount.value, 2);
    // trigger its computed update count
    expect(_signalCreatedCount, 2);
    expect(_signalUpdatedCount, 1);
    expect(_computedCreatedCount, 1);
    expect(_computedUpdatedCount, 2); // +1
    // Expected multiplied result
    expect(multipliedCount.value, 2);
    final calculatedValue = multipliedCount.value * 5;
    expect(calculatedValue, 10);
    // Reading the multiplied value in above test first time OR
    // using it in a calculation should not trigger its computed update count
    expect(_signalCreatedCount, 2);
    expect(_signalUpdatedCount, 1);
    expect(_computedCreatedCount, 1);
    expect(_computedUpdatedCount, 2);
    // Update multiplier signal
    multiplier.value = 3;
    // Expected observer call counts
    expect(_signalCreatedCount, 2);
    expect(_signalUpdatedCount, 2); // +1
    expect(_computedCreatedCount, 1);
    expect(_computedUpdatedCount, 2);
    // Expected multiplied result
    expect(multipliedCount.value, 3);
    // Reading the multiplied value in above test first time should
    // trigger its computed update count
    // Expected observer call counts
    expect(_signalCreatedCount, 2);
    expect(_signalUpdatedCount, 2);
    expect(_computedCreatedCount, 1);
    // Prior to FIX for issue:
    // https://github.com/rodydavis/signals.dart/issues/156
    // the below _computedUpdatedCount would end up with value 6,
    // since the computed value would be called too often.
    expect(_computedUpdatedCount, 3); // +1
  });
}
