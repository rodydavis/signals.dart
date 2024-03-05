import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'double_to_string_as_exponential.mapper.dart';

@MappableClass(
  discriminatorValue: 'double_to_string_as_exponential',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class DoubleToStringAsExponential extends BaseNode
    with DoubleToStringAsExponentialMappable {
  DoubleToStringAsExponential({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  DoubleToStringAsExponential.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Double To String As Exponential'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<double>(0.0)),
            'fraction_digits': (link: null, value: signal<int?>(null)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<double>('value')!()
              .toStringAsExponential(input<int?>('fraction_digits')!());
        }),
      };

  static const fromMap = DoubleToStringAsExponentialMapper.fromMap;
  static const fromJson = DoubleToStringAsExponentialMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'double',
      'fraction_digits': 'int?',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
