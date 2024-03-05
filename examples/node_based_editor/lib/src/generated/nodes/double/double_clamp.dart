import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_clamp.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_clamp',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleClamp extends BaseNode with DoubleClampMappable {
  DoubleClamp({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleClamp.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Clamp'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<double>(0.0)),
            'lower_limit': (link: null, value: signal<double>(0.0)),
            'upper_limit': (link: null, value: signal<double>(1.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<double>(() {
          return input<double>('value')!().clamp(
              input<double>('lower_limit')!(), input<double>('upper_limit')!());
        }),
      };

  static const fromMap = DoubleClampMapper.fromMap;
  static const fromJson = DoubleClampMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'double',
      'lower_limit': 'double',
      'upper_limit': 'double',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'double',
    };
  }
}
