import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_last_index_of.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_last_index_of',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringLastIndexOf extends BaseNode with StringLastIndexOfMappable {
  StringLastIndexOf({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringLastIndexOf.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Last Index Of'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'pattern': (link: null, value: signal<Pattern>('Text Here')),
            'start': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<String>('value')!().lastIndexOf(
              input<Pattern>('pattern')!(), input<int>('start')!());
        }),
      };

  static const fromMap = StringLastIndexOfMapper.fromMap;
  static const fromJson = StringLastIndexOfMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
      'pattern': 'Pattern',
      'start': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
