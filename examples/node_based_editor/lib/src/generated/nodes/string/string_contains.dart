import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_contains.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_contains',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringContains extends BaseNode with StringContainsMappable {
  StringContains({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringContains.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Contains'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'pattern': (link: null, value: signal<Pattern>('Text Here')),
            'start_index': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<bool>(() {
          return input<String>('value')!().contains(
              input<Pattern>('pattern')!(), input<int>('start_index')!());
        }),
      };

  static const fromMap = StringContainsMapper.fromMap;
  static const fromJson = StringContainsMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
      'pattern': 'Pattern',
      'start_index': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'bool',
    };
  }
}
