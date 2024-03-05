import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_replace_range.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_replace_range',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringReplaceRange extends BaseNode with StringReplaceRangeMappable {
  StringReplaceRange({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringReplaceRange.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Replace Range'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'start': (link: null, value: signal<int>(0)),
            'end': (link: null, value: signal<int?>(null)),
            'replacement': (link: null, value: signal<String>('Text Here')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<String>('value')!().replaceRange(input<int>('start')!(),
              input<int?>('end')!(), input<String>('replacement')!());
        }),
      };

  static const fromMap = StringReplaceRangeMapper.fromMap;
  static const fromJson = StringReplaceRangeMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
      'start': 'int',
      'end': 'int?',
      'replacement': 'String',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
