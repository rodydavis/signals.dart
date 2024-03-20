import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_compare_to.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_compare_to',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumCompareTo extends BaseNode with NumCompareToMappable {
  NumCompareTo({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumCompareTo.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num Compare To'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<num>(0.0)),
            'other': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<num>('value')!().compareTo(input<num>('other')!());
        }),
      };

  static const fromMap = NumCompareToMapper.fromMap;
  static const fromJson = NumCompareToMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'num',
      'other': 'num',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
