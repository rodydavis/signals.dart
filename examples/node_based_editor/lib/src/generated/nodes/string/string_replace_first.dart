import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_replace_first.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_replace_first',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringReplaceFirst extends BaseNode with StringReplaceFirstMappable {
  StringReplaceFirst({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringReplaceFirst.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Replace First'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'from': (link: null, value: signal<Pattern>('Text Here')),
            'to': (link: null, value: signal<String>('Text Here')),
            'start_index': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<String>('value')!().replaceFirst(
              input<Pattern>('from')!(),
              input<String>('to')!(),
              input<int>('start_index')!());
        }),
      };

  static const fromMap = StringReplaceFirstMapper.fromMap;
  static const fromJson = StringReplaceFirstMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
      'from': 'Pattern',
      'to': 'String',
      'start_index': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
