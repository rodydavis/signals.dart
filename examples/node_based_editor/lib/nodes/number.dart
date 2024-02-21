import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';
import 'boolean.dart';
import 'text.dart';
import 'value.dart';

class NumberNode<T extends num> extends ValueNode<T> {
  NumberNode(
    super.value, {
    super.name = 'Number',
    T Function(String)? parser,
  }) : parse = parser ?? ((val) => (num.tryParse(val) ?? 0.0) as T);

  NumberNode.fromSource(
    super.source, {
    super.name = 'Number (readonly)',
    T Function(String)? parser,
    super.inputs,
  })  : parse = parser ?? ((val) => (num.tryParse(val) ?? 0.0) as T),
        super.fromSource();

  NumberNode.computed({
    super.name = 'Number (computed)',
    super.inputs,
  })  : parse = ((val) => (num.tryParse(val) ?? 0.0) as T),
        super.computed();

  final T Function(String) parse;

  @override
  Widget build() {
    if (output is Signal<num>) {
      return TextFormField(
        initialValue: output.value.toString(),
        onChanged: (val) => (output as Signal<num>).value = parse(val),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(filled: true),
        textAlign: TextAlign.center,
      );
    }
    return Text(output.value.toString());
  }

  @override
  Size size() => const Size(100, 40);
}

class IntNode extends NumberNode<int> {
  IntNode(
    super.value, {
    super.name = 'Int',
  }) : super(parser: (val) => int.tryParse(val) ?? 0);

  IntNode.fromSource(
    super.source, {
    super.name = 'Int (readonly)',
  }) : super.fromSource(parser: (val) => int.tryParse(val) ?? 0);
}

class DoubleNode extends NumberNode<double> {
  DoubleNode(
    super.value, {
    super.name = 'Double',
  }) : super(parser: (val) => double.tryParse(val) ?? 0);

  DoubleNode.fromSource(
    super.source, {
    super.name = 'Double (readonly)',
  }) : super.fromSource(parser: (val) => double.tryParse(val) ?? 0);
}

class ClampNumberNode<T extends num> extends NumberNode<T> {
  ClampNumberNode(
    double value, {
    super.name = 'Clamp Number',
    required T lowerLimit,
    required T upperLimit,
  }) : super(value.clamp(lowerLimit, upperLimit) as T);

  ClampNumberNode.fromSource(
    Node<dynamic, T> source, {
    required Node<dynamic, T> lowerLimit,
    required Node<dynamic, T> upperLimit,
    super.name = 'Clamp Number (computed)',
  }) : super.computed(inputs: [source, lowerLimit, upperLimit]) {
    output = computed(() {
      final result = source.output.value.clamp(
        lowerLimit.output.value,
        upperLimit.output.value,
      );
      return result as T;
    });
  }
}

class RoundNumberNode<T extends num> extends NumberNode<int> {
  RoundNumberNode(
    T value, {
    super.name = 'Round Number',
  }) : super(value.round());

  RoundNumberNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Round Number (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.round();
    });
  }
}

class RoundNumberToDoubleNode<T extends num> extends NumberNode<double> {
  RoundNumberToDoubleNode(
    T value, {
    super.name = 'Round Number',
  }) : super(value.roundToDouble());

  RoundNumberToDoubleNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Round Number (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.roundToDouble();
    });
  }
}

class CeilNumberNode<T extends num> extends NumberNode<int> {
  CeilNumberNode(
    T value, {
    super.name = 'Ceil Number',
  }) : super(value.ceil());

  CeilNumberNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Ceil Number (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.ceil();
    });
  }
}

class FloorNumberNode<T extends num> extends NumberNode<int> {
  FloorNumberNode(
    T value, {
    super.name = 'Floor Number',
  }) : super(value.floor());

  FloorNumberNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Floor Number (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.floor();
    });
  }
}

class FloorNumberToDoubleNode<T extends num> extends NumberNode<double> {
  FloorNumberToDoubleNode(
    T value, {
    super.name = 'Floor Number',
  }) : super(value.floorToDouble());

  FloorNumberToDoubleNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Floor Number (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.floorToDouble();
    });
  }
}

class AbsNumberNode<T extends num> extends NumberNode<num> {
  AbsNumberNode(
    T value, {
    super.name = 'Abs Number',
  }) : super(value.abs());

  AbsNumberNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Abs Number (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.abs();
    });
  }
}

class NumberToInt<T extends num> extends NumberNode<int> {
  NumberToInt(
    T value, {
    super.name = 'Number to Int',
  }) : super(value.toInt());

  NumberToInt.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Number to Int (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.toInt();
    });
  }
}

class NumberToDouble<T extends num> extends NumberNode<double> {
  NumberToDouble(
    T value, {
    super.name = 'Number to Double',
  }) : super(value.toDouble());

  NumberToDouble.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Number to Double (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.toDouble();
    });
  }
}

class TruncateNumberNode<T extends num> extends NumberNode<int> {
  TruncateNumberNode(
    T value, {
    super.name = 'Truncate Number',
  }) : super(value.floor());

  TruncateNumberNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Truncate Number (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.truncate();
    });
  }
}

class TruncateNumberToDoubleNode<T extends num> extends NumberNode<double> {
  TruncateNumberToDoubleNode(
    T value, {
    super.name = 'Truncate Number',
  }) : super(value.floorToDouble());

  TruncateNumberToDoubleNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Truncate Number (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.truncateToDouble();
    });
  }
}

class NumberToStringFixed<T extends num> extends TextNode {
  NumberToStringFixed(
    T value,
    int fractionDigits, {
    super.name = 'Number to String Fixed',
  }) : super(value.toStringAsFixed(fractionDigits));

  NumberToStringFixed.fromSource(
    Node<dynamic, T> source,
    Node<dynamic, int> fractionDigits, {
    super.name = 'Number to String Fixed (computed)',
  }) : super.computed(inputs: [source, fractionDigits]) {
    output = computed(() {
      return source.output.value.toStringAsFixed(fractionDigits.output.value);
    });
  }
}

class NumberToStringPrecision<T extends num> extends TextNode {
  NumberToStringPrecision(
    T value,
    int precision, {
    super.name = 'Number to String Precision',
  }) : super(value.toStringAsPrecision(precision));

  NumberToStringPrecision.fromSource(
    Node<dynamic, T> source,
    Node<dynamic, int> precision, {
    super.name = 'Number to String Precision (computed)',
  }) : super.computed(inputs: [source, precision]) {
    output = computed(() {
      return source.output.value.toStringAsPrecision(precision.output.value);
    });
  }
}

class NumberToStringExponential<T extends num> extends TextNode {
  NumberToStringExponential(
    T value, {
    int? fractionDigits,
    super.name = 'Number to String Exponential',
  }) : super(value.toStringAsExponential(fractionDigits));

  NumberToStringExponential.fromSource(
    Node<dynamic, T> source, {
    Node<dynamic, int>? fractionDigits,
    super.name = 'Number to String Exponential (computed)',
  }) : super.computed(
            inputs: [source, if (fractionDigits != null) fractionDigits]) {
    output = computed(() {
      return source.output.value
          .toStringAsExponential(fractionDigits?.output.value);
    });
  }
}

class RemainderNumberNode<T extends num> extends NumberNode<num> {
  RemainderNumberNode(
    T value,
    T other, {
    super.name = 'Remainder Number',
  }) : super(value.remainder(other));

  RemainderNumberNode.fromSource(
    Node<dynamic, T> source,
    Node<dynamic, T> other, {
    super.name = 'Remainder Number (computed)',
  }) : super.computed(inputs: [source, other]) {
    output = computed(() {
      return source.output.value.remainder(other.output.value);
    });
  }
}

class CompareToNumberNode<T extends num> extends NumberNode<int> {
  CompareToNumberNode(
    T value,
    T other, {
    super.name = 'Compare To Number',
  }) : super(value.compareTo(other));

  CompareToNumberNode.fromSource(
    Node<dynamic, T> source,
    Node<dynamic, T> other, {
    super.name = 'Compare To Number (computed)',
  }) : super.computed(inputs: [source, other]) {
    output = computed(() {
      return source.output.value.compareTo(other.output.value);
    });
  }
}

class BitLengthNumberNode extends NumberNode<int> {
  BitLengthNumberNode(
    int value, {
    super.name = 'Bit Length Number',
  }) : super(value.bitLength);

  BitLengthNumberNode.fromSource(
    Node<dynamic, int> source, {
    super.name = 'Bit Length Number (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.bitLength;
    });
  }
}

class NumberSignNode<T extends num> extends NumberNode<num> {
  NumberSignNode(
    T value, {
    super.name = 'Number Sign',
  }) : super(value.sign);

  NumberSignNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Number Sign (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.sign;
    });
  }
}

class IsFiniteNode<T extends num> extends BooleanNode {
  IsFiniteNode(
    T value, {
    super.name = 'Is Finite',
  }) : super(value.isFinite);

  IsFiniteNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Is Finite (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.isFinite;
    });
  }
}

class IsInfiniteNode<T extends num> extends BooleanNode {
  IsInfiniteNode(
    T value, {
    super.name = 'Is Infinite',
  }) : super(value.isInfinite);

  IsInfiniteNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Is Infinite (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.isInfinite;
    });
  }
}

class IsNaNNode<T extends num> extends BooleanNode {
  IsNaNNode(
    T value, {
    super.name = 'Is NaN',
  }) : super(value.isNaN);

  IsNaNNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Is NaN (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.isNaN;
    });
  }
}

class IsNegativeNode<T extends num> extends BooleanNode {
  IsNegativeNode(
    T value, {
    super.name = 'Is Negative',
  }) : super(value.isNegative);

  IsNegativeNode.fromSource(
    Node<dynamic, T> source, {
    super.name = 'Is Negative (computed)',
  }) : super.computed(inputs: [source]) {
    output = computed(() {
      return source.output.value.isNegative;
    });
  }
}
