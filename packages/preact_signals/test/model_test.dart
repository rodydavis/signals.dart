// ignore_for_file: non_constant_identifier_names
import 'package:preact_signals/preact_signals.dart';
import 'package:test/test.dart';

class MutableInt {
  int value;
  MutableInt(this.value);

  @override
  String toString() => value.toString();
}

extension type TypeSafeCounterModel(SignalModel<Map<String, dynamic>> _model) {
  /// Access the run count.
  int get runCount => (_model['runCount'] as MutableInt).value;

  /// Access the count value.
  int get count => (_model['count'] as Signal<int>).value;

  /// Set the count value.
  set count(int val) => (_model['count'] as Signal<int>).value = val;

  /// Dispose of the model.
  void dispose() => _model.dispose();
}

void main() {
  group('createModel', () {
    test('should capture newly constructed effects using callable constructor',
        () {
      final CounterModelConstructor = createModel(() {
        final count = signal(0);
        final runCount = MutableInt(0);
        effect(() {
          runCount.value++;
          count.value;
        });
        return <String, dynamic>{
          'count': count,
          'runCount': runCount,
        };
      });
      final model = CounterModelConstructor();

      expect((model['runCount'] as MutableInt).value, 1);

      (model['count'] as Signal<int>).value = 1;
      expect((model['runCount'] as MutableInt).value, 2);

      model.dispose();

      (model['count'] as Signal<int>).value = 2;
      expect((model['runCount'] as MutableInt).value,
          2); // Should not rerun since effect is disposed!
    });

    test('should correctly isolate nested models without leakage', () {
      final OuterModel = createModel(() {
        final InnerModel = createModel(() {
          final count = signal(0);
          final runCount = MutableInt(0);
          effect(() {
            runCount.value++;
            count.value;
          });
          return <String, dynamic>{
            'count': count,
            'runCount': runCount,
          };
        });
        final inner = InnerModel();

        final count = signal(0);
        final runCount = MutableInt(0);
        effect(() {
          runCount.value++;
          count.value;
        });
        final counter = <String, dynamic>{
          'count': count,
          'runCount': runCount,
        };
        return (inner, counter);
      });

      final outer = OuterModel();
      final (innerModel, outerCounter) = outer.value;

      expect((innerModel['runCount'] as MutableInt).value, 1);
      expect((outerCounter['runCount'] as MutableInt).value, 1);

      // Trigger inner model
      (innerModel['count'] as Signal<int>).value = 1;
      expect((innerModel['runCount'] as MutableInt).value, 2);
      expect((outerCounter['runCount'] as MutableInt).value, 1);

      // Dispose outer
      outer.dispose();

      // Outer counter effect should be disposed
      (outerCounter['count'] as Signal<int>).value = 1;
      expect((outerCounter['runCount'] as MutableInt).value, 1);

      // Inner model effect is ALSO disposed because it was constructed inside the outer model's factory!
      (innerModel['count'] as Signal<int>).value = 2;
      expect((innerModel['runCount'] as MutableInt).value, 2);
    });

    test('should clean up capturedEffects correctly on exceptions', () {
      final FailModel = createModel(() {
        effect(() {});
        throw Exception('Model construction failed');
      });

      expect(() => FailModel(), throwsException);

      // Subsequent createModel call should succeed and not leak capturedEffects from the failed call
      final SuccessModel = createModel(() {
        final count = signal(0);
        final runCount = MutableInt(0);
        effect(() {
          runCount.value++;
          count.value;
        });
        return <String, dynamic>{
          'count': count,
          'runCount': runCount,
        };
      });
      final model = SuccessModel();
      expect((model['runCount'] as MutableInt).value, 1);

      model.dispose();
    });

    test('should support returning a Map and dynamic subscript access', () {
      var effectRunCount = 0;
      final CounterModelConstructor = createModel(() {
        final count = signal(0);
        effect(() {
          effectRunCount++;
          count.value;
        });
        return <String, dynamic>{
          'count': count,
          'increment': () => count.value = count.value + 1,
        };
      });

      final model = CounterModelConstructor();

      expect(effectRunCount, 1);
      expect(model['count'].value, 0);

      // Mutate using action closure
      model['increment']();
      expect(effectRunCount, 2);
      expect(model['count'].value, 1);

      // Mutate directly
      model['count'].value = 10;
      expect(effectRunCount, 3);

      model.dispose();

      // Should not rerun after dispose
      model['count'].value = 20;
      expect(effectRunCount, 3);
    });

    test('should support model constructors with parameters', () {
      SignalModel<Map<String, dynamic>> createCounterWithInitial(
          int initialCount) {
        return createModel(() {
          final count = signal(initialCount);
          return <String, dynamic>{
            'count': count,
          };
        })();
      }

      final model = createCounterWithInitial(10);
      expect(model['count'].value, 10);
      model.dispose();
    });

    test('should automatically wrap returned map functions in action', () {
      final count = signal(0);
      var spyCount = 0;

      effect(() {
        spyCount = spyCount + 1;
        count.value;
      });

      // Reset spy count
      spyCount = 0;

      final CounterModelConstructor = createModel(() {
        return <String, dynamic>{
          'incrementTwice': () {
            count.value = count.value + 1;
            count.value = count.value + 1;
          },
        };
      });

      final model = CounterModelConstructor();

      // Invoke auto-wrapped action
      model['incrementTwice']();

      // Since incrementTwice is automatically wrapped in action (which runs inside a batch),
      // the listening effect should run exactly once!
      expect(spyCount, 1);
      expect(count.value, 2);

      model.dispose();
    });

    test('should support wrapping the model in a custom type-safe class', () {
      final CounterModelConstructor = createModel(() {
        final count = signal(0);
        final runCount = MutableInt(0);
        effect(() {
          runCount.value++;
          count.value;
        });
        return <String, dynamic>{
          'count': count,
          'runCount': runCount,
        };
      });
      final myCounter = TypeSafeCounterModel(CounterModelConstructor());

      expect(myCounter.runCount, 1);
      expect(myCounter.count, 0);

      myCounter.count = 5;
      expect(myCounter.runCount, 2);
      expect(myCounter.count, 5);

      myCounter.dispose();
    });
  });
}
