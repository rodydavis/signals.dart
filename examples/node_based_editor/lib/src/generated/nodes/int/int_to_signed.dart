import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_to_signed.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_to_signed',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntToSigned extends BaseNode with IntToSignedMappable {
  IntToSigned({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntToSigned.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int To Signed'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
            'width': (link: null, value: signal<int>(2)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<int>('value')!().toSigned(input<int>('width')!());
        }),
      };

  static const fromMap = IntToSignedMapper.fromMap;
  static const fromJson = IntToSignedMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int',
      'width': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
