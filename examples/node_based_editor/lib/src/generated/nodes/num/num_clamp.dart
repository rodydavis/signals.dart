import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_clamp.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_clamp',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumClamp extends BaseNode with NumClampMappable {
  NumClamp({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumClamp.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num Clamp'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<num>(0.0)),
            'lower_limit': (link: null, value: signal<num>(0.0)),
            'upper_limit': (link: null, value: signal<num>(1.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<num>(() {
          return input<num>('value')!().clamp(
              input<num>('lower_limit')!(), input<num>('upper_limit')!());
        }),
      };

  static const fromMap = NumClampMapper.fromMap;
  static const fromJson = NumClampMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'num',
      'lower_limit': 'num',
      'upper_limit': 'num',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'num',
    };
  }
}
