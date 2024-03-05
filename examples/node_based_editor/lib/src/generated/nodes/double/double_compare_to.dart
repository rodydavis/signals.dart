import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_compare_to.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_compare_to',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleCompareTo extends BaseNode with DoubleCompareToMappable {
  DoubleCompareTo({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleCompareTo.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double Compare To'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<double>(0.0)),
            'other': (link: null, value: signal<double>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<double>('value')!().compareTo(input<double>('other')!());
        }),
      };

  static const fromMap = DoubleCompareToMapper.fromMap;
  static const fromJson = DoubleCompareToMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'double',
      'other': 'double',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
