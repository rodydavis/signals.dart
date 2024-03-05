import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_split.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_split',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringSplit extends BaseNode with StringSplitMappable {
  StringSplit({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringSplit.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Split'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'pattern': (link: null, value: signal<Pattern>('Text Here')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<List<String>>(() {
          return input<String>('value')!().split(input<Pattern>('pattern')!());
        }),
      };

  static const fromMap = StringSplitMapper.fromMap;
  static const fromJson = StringSplitMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
      'pattern': 'Pattern',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'List<String>',
    };
  }
}
