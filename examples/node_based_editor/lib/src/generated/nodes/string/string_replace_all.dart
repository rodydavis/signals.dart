import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_replace_all.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_replace_all',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringReplaceAll extends BaseNode with StringReplaceAllMappable {
  StringReplaceAll({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringReplaceAll.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Replace All'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'from': (link: null, value: signal<Pattern>('Text Here')),
            'replace': (link: null, value: signal<String>('Text Here')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<String>('value')!().replaceAll(
              input<Pattern>('from')!(), input<String>('replace')!());
        }),
      };

  static const fromMap = StringReplaceAllMapper.fromMap;
  static const fromJson = StringReplaceAllMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
      'from': 'Pattern',
      'replace': 'String',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
