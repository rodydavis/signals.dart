import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_compare_to.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_compare_to',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringCompareTo extends BaseNode with StringCompareToMappable {
  StringCompareTo({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringCompareTo.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Compare To'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'other': (link: null, value: signal<String>('Text Here')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<String>('value')!().compareTo(input<String>('other')!());
        }),
      };

  static const fromMap = StringCompareToMapper.fromMap;
  static const fromJson = StringCompareToMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
      'other': 'String',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
