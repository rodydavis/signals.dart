import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_remainder.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_remainder',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleRemainder extends BaseNode with DoubleRemainderMappable {
  DoubleRemainder({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleRemainder.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Remainder'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<double>(0.0)),
            'other': (link: null, value: signal<double>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return input<double>('value')!().remainder(input<double>('other')!());
        }),
      };

  static const fromMap = DoubleRemainderMapper.fromMap;
  static const fromJson = DoubleRemainderMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'double',
      'other': 'double',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'double',
    };
  }
}
