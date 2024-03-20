import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_substring.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_substring',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringSubstring extends BaseNode with StringSubstringMappable {
  StringSubstring({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringSubstring.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Substring'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'start': (link: null, value: signal<int>(0)),
            'end': (link: null, value: signal<int?>(null)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<String>('value')!()
              .substring(input<int>('start')!(), input<int?>('end')!());
        }),
      };

  static const fromMap = StringSubstringMapper.fromMap;
  static const fromJson = StringSubstringMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
      'start': 'int',
      'end': 'int?',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
