import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'nodes/base.dart';
import 'widgets/number_field.dart';
import 'widgets/string_field.dart';

class Knob<T> {
  final String label;
  final Signal<T> _fallback;
  late final Signal<ReadonlySignal<T>> _source = signal(_fallback);
  late final ReadonlySignal<ReadonlySignal<T>> target = _source;
  late final ReadonlySignal<T> original = _fallback;

  set source(ReadonlySignal<T>? val) {
    _source.value = val ?? _fallback;
  }

  late final ReadonlySignal<T> source = computed(() {
    final src = _source.value;
    return src.value;
  });

  late final ReadonlySignal<bool> readonly = computed(() {
    final src = _source.value;
    return src != _fallback;
  });

  T get value => source.value;

  set value(T val) {
    if (readonly.value) return;
    _fallback.value = val;
  }

  Knob(
    this.label,
    T value,
  ) : _fallback = signal<T>(value);

  Widget render() {
    return Watch((context) {
      if (readonly.value) return const SizedBox.shrink();
      return build(context);
    });
  }

  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
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

  @override
  Widget build(BuildContext context) {
    return Watch((context) => NumberField(
          valueToString: (val) => val.toString(),
          valueFromString: num.tryParse,
          value: source.get(),
          onChanged: (val) => value = val as T,
        ));
  }
}

class OptionalNumKnob<T extends num> extends OptionalKnob<T> {
  OptionalNumKnob(super.label, super.source);

  @override
  Widget build(BuildContext context) {
    return Watch((context) => OptionalNumberField(
          valueToString: (val) => val?.toString() ?? '',
          valueFromString: num.tryParse,
          value: source.get(),
          onChanged: (val) => value = val as T,
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
