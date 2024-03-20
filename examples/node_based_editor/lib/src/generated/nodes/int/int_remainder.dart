import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_remainder.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_remainder',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntRemainder extends BaseNode with IntRemainderMappable {
  IntRemainder({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntRemainder.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Remainder'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
            'other': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<int>('value')!().remainder(input<int>('other')!());
        }),
      };

  static const fromMap = IntRemainderMapper.fromMap;
  static const fromJson = IntRemainderMapper.fromJson;

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
