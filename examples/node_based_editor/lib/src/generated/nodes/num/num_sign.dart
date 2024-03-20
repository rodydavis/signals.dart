import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'num_sign.mapper.dart';

@MappableClass(
  discriminatorValue: 'num_sign',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class NumSign extends BaseNode with NumSignMappable {
  NumSign({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  NumSign.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Num Sign'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<num>(0.0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<num>(() {
          return input<num>('value')!().sign;
        }),
      };

  static const fromMap = NumSignMapper.fromMap;
  static const fromJson = NumSignMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'num',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'num',
    };
  }
}
