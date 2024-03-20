import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'optional_object_fallback.mapper.dart';

@MappableClass(
  discriminatorValue: 'optional_object_fallback',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class OptionalObjectFallback extends BaseNode
    with OptionalObjectFallbackMappable {
  OptionalObjectFallback({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  OptionalObjectFallback.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Optional Object Fallback'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<Object?>('Object()')),
            'fallback': (link: null, value: signal<Object>('Object()')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<Object>(() {
          return input<Object?>('value')!() ?? input<Object>('fallback')!();
        }),
      };

  static const fromMap = OptionalObjectFallbackMapper.fromMap;
  static const fromJson = OptionalObjectFallbackMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'Object?',
      'fallback': 'Object',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'Object',
    };
  }
}
