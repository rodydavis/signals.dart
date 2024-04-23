import 'package:signals_core/src/utils/deep_collection_equality.dart';
import 'package:test/test.dart';

void main() {
  group('DeepEqualityChecker hash code', () {
    const deepEquality = DeepCollectionEquality();
    test('checks primitive type equality', () {
      expect(deepEquality.equals(1, 1), isTrue);
      expect(deepEquality.equals('string', 'string'), isTrue);
      expect(deepEquality.equals(1.0, 1.0), isTrue);
      expect(deepEquality.equals(1, '1'), isFalse);
      expect(deepEquality.equals('1', 1), isFalse);
      expect(deepEquality.equals(1, 2), isFalse);
    });

    test('checks Map equality with simple types', () {
      expect(deepEquality.equals({'key': 'value'}, {'key': 'value'}), isTrue);
      expect(
        deepEquality.equals({'key1': 'value'}, {'key2': 'value'}),
        isFalse,
      );
      expect(
        deepEquality.equals({'key': 'value1'}, {'key': 'value2'}),
        isFalse,
      );
      expect(deepEquality.equals({}, {}), isTrue);
      expect(
        deepEquality
            .equals({'key': 'value'}, {'key': 'value', 'extra': 'value'}),
        isFalse,
      );
    });

    test('checks Set equality with simple types', () {
      expect(deepEquality.equals({1, 2, 3}, {1, 2, 3}), isTrue);
      expect(deepEquality.equals({1, 2}, {1, 2, 3}), isFalse);
      expect(
        deepEquality.equals({3, 2, 1}, {1, 2, 3}),
        isTrue,
      ); // Order should not matter in sets
      // ignore: equal_elements_in_set
      expect(
        // ignore: equal_elements_in_set
        deepEquality.equals({1}, {1, 1, 1}),
        isTrue,
      ); // Duplicate elements in a set
    });

    test('checks Iterable equality with simple types', () {
      expect(deepEquality.equals([1, 2, 3], [1, 2, 3]), isTrue, reason: '1');
      expect(deepEquality.equals([1, 2, 3], [3, 2, 1]), isFalse, reason: '2');
      expect(deepEquality.equals([], []), isTrue, reason: '3');
      expect(deepEquality.equals([1, 2, 3], [1, 2]), isFalse, reason: '4');
    });

    test('checks nested collection equality', () {
      expect(
        deepEquality.equals(
          [
            {'key': 'value'},
            {'key2': 'value2'},
          ],
          [
            {'key': 'value'},
            {'key2': 'value2'},
          ],
        ),
        isTrue,
      );
      expect(
        deepEquality.equals(
          {
            'outer': {'inner': 'value'},
          },
          {
            'outer': {'inner': 'value'},
          },
        ),
        isTrue,
      );
      expect(
        deepEquality.equals(
          {
            'set': {1, 2, 3},
          },
          {
            'set': {3, 2, 1},
          },
        ),
        isTrue,
      );
      expect(
        deepEquality.equals(
          [
            1,
            [
              2,
              [3, 4],
            ],
          ],
          [
            1,
            [
              2,
              [3, 4],
            ],
          ],
        ),
        isTrue,
      );
      expect(
        deepEquality.equals(
          {
            'set': {1, 2, 3},
          },
          {
            'set': {1, 2},
          },
        ),
        isFalse,
      );
    });

    test('checks custom object equality', () {
      const obj1 = _CustomClass(id: 1, value: 'Test');
      const obj2 = _CustomClass(id: 1, value: 'Test');
      const obj3 = _CustomClass(id: 2, value: 'Test');

      expect(deepEquality.equals(obj1, obj2), isTrue);
      expect(deepEquality.equals(obj1, obj3), isFalse);
    });

    test('checks nested custom object equality', () {
      const nestedObj1 = _AnotherClass(
        id: 1,
        name: 'another class',
      );

      const nestedObj2 = _AnotherClass(
        id: 1,
        name: 'another class',
      );

      const nestedObjDifferent = _CustomClass(
        id: 1,
        value: 'custom class',
      );

      expect(deepEquality.equals(nestedObj1, nestedObj2), isTrue);
      expect(deepEquality.equals(nestedObj1, nestedObjDifferent), isFalse);
    });
  });
}

// A dummy custom object class for testing purposes
class _CustomClass {
  final int id;
  final String value;

  const _CustomClass({required this.id, required this.value});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _CustomClass && other.id == id && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}

class _AnotherClass {
  final int id;
  final String name;

  const _AnotherClass({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _AnotherClass &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
