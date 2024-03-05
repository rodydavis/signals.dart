import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'int_mod_pow.mapper.dart';

@MappableClass(
  discriminatorValue: 'int_mod_pow',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class IntModPow extends BaseNode with IntModPowMappable {
  IntModPow({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  IntModPow.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Int Mod Pow'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<int>(0)),
            'exponent': (link: null, value: signal<int>(0)),
            'modulus': (link: null, value: signal<int>(0)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<int>(() {
          return input<int>('value')!()
              .modPow(input<int>('exponent')!(), input<int>('modulus')!());
        }),
      };

  static const fromMap = IntModPowMapper.fromMap;
  static const fromJson = IntModPowMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'int',
      'exponent': 'int',
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
