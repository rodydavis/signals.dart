import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'string_pad_right.mapper.dart';

@MappableClass(
  discriminatorValue: 'string_pad_right',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class StringPadRight extends BaseNode with StringPadRightMappable {
  StringPadRight({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  StringPadRight.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('String Pad Right'),
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
              .padRight(input<int>('width')!(), input<String>('padding')!());
        }),
      };

  static const fromMap = StringPadRightMapper.fromMap;
  static const fromJson = StringPadRightMapper.fromJson;

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
