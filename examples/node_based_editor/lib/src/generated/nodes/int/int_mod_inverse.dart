import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_mod_inverse.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_mod_inverse',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntModInverse extends BaseNode with IntModInverseMappable {
  IntModInverse({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntModInverse.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Mod Inverse'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
            'modulus': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<int>('value')!().modInverse(input<int>('modulus')!());
        }),
      };

  static const fromMap = IntModInverseMapper.fromMap;
  static const fromJson = IntModInverseMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int',
      'modulus': 'int',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'int',
    };
  }
}
