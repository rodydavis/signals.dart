import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'node.dart';
import 'widgets/fields/number_field.dart';
import 'widgets/fields/string_field.dart';

class Knob<T> {
  final String label;
  late ReadonlySignal<T> _fallback;
  late final Signal<ReadonlySignal<T>> _source = signal(_fallback);
  late final ReadonlySignal<ReadonlySignal<T>> target = _source;
  late final ReadonlySignal<T> original = _fallback;

  set fallback(ReadonlySignal<T> val) {
    _fallback = val;
  }

  set source(ReadonlySignal<T>? val) {
    _source.value = val ?? _fallback;
  }

  late ReadonlySignal<String> toString$ = computed(
    () => value.toString(),
  );

  late ReadonlySignal<bool> isNull$ = computed(
    () => value == null,
  );

  late final ReadonlySignal<T> source = computed(() {
    final src = _source.value;
    return src.value;
  });

  late final ReadonlySignal<bool> readonly = computed(() {
    final src = _source.value;
    return src != _fallback;
  });

  T get value => source.value;

  T get fallbackValue => _fallback.value;

  set value(T val) {
    if (readonly.value) return;
    if (_fallback is Signal<T>) {
      (_fallback as Signal<T>).value = val;
    }
  }

  Knob(
    this.label,
    T value,
  ) : _fallback = signal<T>(value);

  Widget render() {
    return Watch((context) {
      final colors = Theme.of(context).colorScheme;
      if (readonly.value) {
        return Container(
          decoration: BoxDecoration(
            color: colors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            child: Text(
              toString$(),
              style: TextStyle(color: colors.onSurface),
              textAlign: TextAlign.end,
            ),
          ),
        );
      }
      return build(context);
    });
  }

  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class EventKnob<T> extends Knob<T> {
  EventKnob(super.label, super.value);
}

class OptionalEventKnob<T> extends Knob<T?> {
  OptionalEventKnob(super.label, super.value);
}

class FunctionKnob<T, R> extends EventKnob<R Function()> {
  FunctionKnob(super.label, super.value);

  final calls = signal<int>(0);

  R call() {
    calls.value++;
    final result = value();
    super.value = () => result;
    return result;
  }
}

class VoidFunctionKnob extends FunctionKnob<void Function(), void> {
  VoidFunctionKnob(String label) : super(label, () => Object());
}

class OptionalKnob<T> extends Knob<T?> {
  OptionalKnob(super.label, super.source);
}

class NodeKnob extends Knob<GraphNode> {
  NodeKnob(super.label, super.source);
}

class OptionalNodeKnob extends OptionalKnob<GraphNode> {
  OptionalNodeKnob(super.label, super.source);
}

class StringKnob extends Knob<String> {
  StringKnob(super.label, super.source);

  @override
  Widget build(BuildContext context) {
    return Watch((context) => StringField(
          value: source.get(),
          onChanged: (val) => value = val,
        ));
  }
}

class OptionalStringKnob extends OptionalKnob<String> {
  OptionalStringKnob(super.label, super.source);

  @override
  Widget build(BuildContext context) {
    return Watch((context) => OptionalStringField(
          value: source.get(),
          onChanged: (val) => value = val,
        ));
  }
}

class BoolKnob extends Knob<bool> {
  BoolKnob(super.label, super.source);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: source.get(),
      onChanged: (val) => value = val,
    );
  }
}

class OptionalBoolKnob extends OptionalKnob<bool> {
  OptionalBoolKnob(super.label, super.source);

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return Checkbox(
        value: source.get(),
        onChanged: (val) => value = val,
        tristate: true,
      );
    });
  }
}

class NumKnob<T extends num> extends Knob<T> {
  NumKnob(super.label, super.source);

  T _convert(num val) {
    if (this is NumKnob<int>) return val.toInt() as T;
    if (this is NumKnob<double>) return val.toDouble() as T;
    return val as T;
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) => NumberField(
          valueToString: (val) => val.toString(),
          valueFromString: num.tryParse,
          value: source.get(),
          onChanged: (val) => value = _convert(val),
        ));
  }
}

class OptionalNumKnob<T extends num> extends OptionalKnob<T> {
  OptionalNumKnob(super.label, super.source);

  T? _convert(num? val) {
    if (this is OptionalNumKnob<int>) return val?.toInt() as T?;
    if (this is OptionalNumKnob<double>) return val?.toDouble() as T?;
    return val as T?;
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) => OptionalNumberField(
          valueToString: (val) => val?.toString() ?? '',
          valueFromString: num.tryParse,
          value: source.get(),
          onChanged: (val) => value = _convert(val),
        ));
  }
}

class IntKnob extends NumKnob<int> {
  IntKnob(super.label, super.source);

  @override
  Widget build(BuildContext context) {
    return Watch((context) => NumberField(
          valueToString: (val) => val.toString(),
          valueFromString: int.tryParse,
          value: source.get(),
          onChanged: (val) => value = val,
        ));
  }
}

class OptionalIntKnob extends OptionalNumKnob<int> {
  OptionalIntKnob(super.label, super.source);

  @override
  Widget build(BuildContext context) {
    return Watch((context) => OptionalNumberField(
          valueToString: (val) => val?.toString() ?? '',
          valueFromString: int.tryParse,
          value: source.get(),
          onChanged: (val) => value = val,
        ));
  }
}

class DoubleKnob extends NumKnob<double> {
  DoubleKnob(super.label, super.source);

  @override
  Widget build(BuildContext context) {
    return Watch((context) => NumberField(
          valueToString: (val) => val.toString(),
          valueFromString: double.tryParse,
          value: source.get(),
          onChanged: (val) => value = val,
        ));
  }
}

class OptionalDoubleKnob extends OptionalNumKnob<double> {
  OptionalDoubleKnob(super.label, super.source);

  @override
  Widget build(BuildContext context) {
    return Watch((context) => OptionalNumberField(
          valueToString: (val) => val?.toString() ?? '',
          valueFromString: double.tryParse,
          value: source.get(),
          onChanged: (val) => value = val,
        ));
  }
}

class ObjectKnob<T extends Object> extends Knob<T> {
  ObjectKnob(super.label, super.source);
}

class OptionalObjectKnob<T extends Object> extends Knob<T?> {
  OptionalObjectKnob(super.label, super.source);
}

class EnumKnob<T extends Enum> extends Knob<T> {
  final List<T> values;
  EnumKnob(super.label, super.source, this.values);

  @override
  Widget build(BuildContext context) {
    return Watch((context) => DropdownButtonFormField(
          value: source.value,
          items: [
            for (final item in values)
              DropdownMenuItem(
                value: item,
                child: Text(item.name),
              ),
          ],
          onChanged: (val) => value = val!,
        ));
  }
}

class OptionalEnumKnob<T extends Enum> extends OptionalKnob<T> {
  final List<T> values;
  OptionalEnumKnob(super.label, super.source, this.values);

  @override
  Widget build(BuildContext context) {
    return Watch((context) => DropdownButtonFormField(
          value: source.value,
          items: [
            for (final item in values)
              DropdownMenuItem(
                value: item,
                child: Text(item.name),
              ),
          ],
          onChanged: (val) => value = val,
        ));
  }
}

// enum KnobGroup {
//   none('Default');
//   final String title;
//   const KnobGroup(this.title);
// }
