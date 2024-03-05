import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_clamp.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_clamp',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntClamp extends BaseNode with IntClampMappable {
  IntClamp({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntClamp.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Clamp'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
            'lower_limit': (link: null, value: signal<int>(0)),
            'upper_limit': (link: null, value: signal<int>(1)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<int>('value')!().clamp(
              input<int>('lower_limit')!(), input<int>('upper_limit')!());
        }),
      };

  static const fromMap = IntClampMapper.fromMap;
  static const fromJson = IntClampMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int',
      'lower_limit': 'int',
      'upper_limit': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
