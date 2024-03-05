import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_pad_left.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_pad_left',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringPadLeft extends BaseNode with StringPadLeftMappable {
  StringPadLeft({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringPadLeft.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Pad Left'),
          expanded: signal(true),
          inputs: {
            'value': (link: null, value: signal<String>('Text Here')),
            'width': (link: null, value: signal<int>(0)),
            'padding': (link: null, value: signal<String>(' ')),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<String>(() {
          return input<String>('value')!()
              .padLeft(input<int>('width')!(), input<String>('padding')!());
        }),
      };

  static const fromMap = StringPadLeftMapper.fromMap;
  static const fromJson = StringPadLeftMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'value': 'String',
      'width': 'int',
      'padding': 'String',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'String',
    };
  }
}
