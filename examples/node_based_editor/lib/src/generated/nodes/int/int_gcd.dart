import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_gcd.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_gcd',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntGcd extends BaseNode with IntGcdMappable {
  IntGcd({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntGcd.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Gcd'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
            'other': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<int>('value')!().gcd(input<int>('other')!());
        }),
      };

  static const fromMap = IntGcdMapper.fromMap;
  static const fromJson = IntGcdMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int',
      'other': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
