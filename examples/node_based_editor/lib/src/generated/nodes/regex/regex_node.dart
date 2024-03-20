import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

part 'regex_node.mapper.dart';

@MappableClass(
  discriminatorValue: 'regex_node',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
class RegexNode extends BaseNode with RegexNodeMappable {
  RegexNode({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  RegexNode.defaults(int id)
      : super(
          id: id,
          offset: signal((dx: 0, dy: 0)),
          label: signal('Regex Node'),
          expanded: signal(true),
          inputs: {
            'source': (link: null, value: signal<String>('Text Here')),
            'multi_line': (link: null, value: signal<bool>(false)),
            'case_sensitive': (link: null, value: signal<bool>(true)),
            'unicode': (link: null, value: signal<bool>(false)),
            'dot_all': (link: null, value: signal<bool>(false)),
          },
        );

  @override
  Map<String, ReadonlySignal> get outputs => {
        'value': computed<Pattern>(() {
          return RegExp(input<String>('source')!(),
              multiLine: input<bool>('multi_line')!(),
              caseSensitive: input<bool>('case_sensitive')!(),
              unicode: input<bool>('unicode')!(),
              dotAll: input<bool>('dot_all')!());
        }),
      };

  static const fromMap = RegexNodeMapper.fromMap;
  static const fromJson = RegexNodeMapper.fromJson;

  @override
  bool get canAddInputs => false;

  @override
  Map<String, String> inputTypes() {
    return {
      'source': 'String',
      'multi_line': 'bool',
      'case_sensitive': 'bool',
      'unicode': 'bool',
      'dot_all': 'bool',
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
      'value': 'Pattern',
    };
  }
}
