// ignore_for_file: avoid_print

import 'dart:io';

import 'package:mustache_template/mustache.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

main() {
  final files = Directory('nodes');
  final nodesDir = Directory('lib/src/generated/nodes');
  if (nodesDir.existsSync()) {
    nodesDir.deleteSync(recursive: true);
  }
  nodesDir.createSync(recursive: true);
  {
    final file = File('${nodesDir.path}/base_node.dart');
    final template = Template(baseTemplate);
    file.writeAsStringSync(template.renderString({}));
  }

  for (final file in files.listSync(recursive: true).whereType<File>()) {
    final imports = <String>[];
    final nodesYaml = file.readAsStringSync();
    final doc = loadYaml(nodesYaml) as YamlMap;
    final baseName = doc['name'] as String;
    print('creating $baseName nodes');
    final outDir = Directory(doc['path']);
    if (!outDir.existsSync()) {
      outDir.createSync(recursive: true);
    }
    // final baseNode = '${baseName.pascalCase}Node';
    for (final node in (doc['nodes'] as YamlMap).entries) {
      final name = node.key as String;
      print('creating $name file');
      {
        final file = File('${outDir.path}/${node.key}.dart');
        imports.add(node.key);
        final template = Template(
          nodeTemplate,
          lenient: true,
          htmlEscapeValues: false,
        );
        file.writeAsStringSync(template.renderString({
          'class': name.pascalCase,
          'name': name.titleCase,
          'file': name.snakeCase,
          'base': node.value['base'] as String? ?? 'BaseNode',
          'canAddInputs': node.value['add-input'] as bool? ?? false,
          'imports': () {
            final val = node.value['imports'];
            if (val == null) return [];
            if (val is YamlMap) {
              return [
                for (final item in val.entries)
                  {
                    'alias': item.key,
                    'path': item.value,
                  },
              ];
            }
            return [
              for (final item in val)
                {
                  'path': item,
                  'alias': false,
                },
            ];
          }(),
          ...getIo(node),
        }));
      }
    }
    {
      final file =
          File('${nodesDir.parent.path}/menus/${baseName.snakeCase}.dart');
      if (!file.existsSync()) file.createSync(recursive: true);
      final template = Template(menuTemplate, lenient: true);
      file.writeAsStringSync(template.renderString({
        ...getGroups(doc),
        'imports': imports.map((e) => '${baseName.snakeCase}/$e').toList(),
      }));
    }
  }
  {
    final file = File('${nodesDir.path}/base_node.dart');
    final template = Template(baseTemplate);
    file.writeAsStringSync(template.renderString({}));
  }
}

Map getGroups(YamlMap doc) {
  final groups = <Map>[];
  final nodes = (doc['nodes'] as YamlMap).entries;
  final ungrouped = nodes.where(
    (e) => !(e.value as YamlMap).containsKey('group'),
  );
  final grouped = nodes.where((e) => e.value['group'] != null);
  final groupByName = <String, List<MapEntry<dynamic, dynamic>>>{};
  for (final item in grouped) {
    groupByName[item.value['group']] ??= [];
    groupByName[item.value['group']]!.add(item);
  }
  for (final item in groupByName.entries) {
    final items = <Map>[];
    for (final child in item.value) {
      items.add({
        'name': (child.key as String).titleCase,
        'node': (child.key as String).pascalCase,
      });
    }
    groups.add({
      'name': item.key.titleCase,
      'items': items,
    });
  }
  final items = <Map>[];
  for (final node in ungrouped) {
    items.add({
      'name': (node.key as String).titleCase,
      'node': (node.key as String).pascalCase,
    });
  }
  return {
    'name': (doc['name'] as String).camelCase,
    'groups': groups,
    'items': items,
  };
}

Map<String, Object?> getIo(MapEntry<dynamic, dynamic> node) {
  return {
    'inputs': [
      for (final input in (node.value['inputs'] as YamlMap? ?? {}).entries) ...[
        {
          "name": input.key,
          "type": input.value['type'],
          "default": input.value['default'],
          "code": input.value['code'],
          "value": () {
            final val = input.value['value'];
            if (val is String) {
              if (val.startsWith('RegExp')) return val;
              return "'$val'";
            }
            if (val == null) return 'null';
            return val;
          }(),
        },
      ],
    ],
    'outputs': [
      for (final input
          in (node.value['outputs'] as YamlMap? ?? {}).entries) ...[
        {
          "name": input.key,
          "type": input.value['type'],
          "default": input.value['default'],
          "code": input.value['code'],
          "value": input.value['value'],
        },
      ],
    ],
  };
}

const baseTemplate = '''
@MappableLib(generateInitializerForScope: InitializerScope.package)
library nodes;

import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

part 'base_node.mapper.dart';

@MappableClass(
  discriminatorKey: '__type',
  includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],
)
abstract class BaseNode with BaseNodeMappable {
  BaseNode({
    required this.id,
    required this.inputs,
    required this.label,
    required this.offset,
    required this.expanded,
  });

  final int id;
  final Signal<NodeOffset> offset;
  final Signal<String> label;
  final Signal<bool> expanded;
  final Map<String, NodeInput> inputs;

  late BaseNode? Function(int id) getNode;

  Map<String, ReadonlySignal> get outputs;

  ReadonlySignal<T>? output<T>(String key) {
    final val = outputs[key];
    if (val == null) return null;
    return val as ReadonlySignal<T>;
  }

  ReadonlySignal<T>? input<T>(String key) {
    final val = inputs[key];
    if (val == null) return null;
    if (val.link != null) {
      final node = getNode(val.link!.nodeId);
      if (node == null) return null;
      final out = node.output<T>(val.link!.outputKey);
      if (out != null) return out;
    }
    return val.value as ReadonlySignal<T>;
  }

  void linkInput(String key, NodeLink link) {
    final val = inputs[key];
    if (val == null) return;
    inputs[key] = (link: link, value: val.value);
  }

  void unlinkInput(String key) {
    final val = inputs[key];
    if (val == null) return;
    inputs[key] = (link: null, value: val.value);
  }

  void setInputValue<T>(String key, T value) {
    final val = inputs[key];
    if (val == null) return;
    val.value.value = value;
  }

  bool get canAddInputs;

  Map<String, String> inputTypes() {
    return {};
  }

  Map<String, String> outputTypes() {
    return {};
  }

  static const fromMap = BaseNodeMapper.fromMap;
  static const fromJson = BaseNodeMapper.fromJson;
}

@MappableRecord()
typedef NodeOffset = ({double dx, double dy});

@MappableRecord(includeCustomMappers: [SignalMapper()])
typedef NodeInput<T> = ({NodeLink? link, Signal<T> value});

@MappableRecord()
typedef NodeLink = ({int nodeId, String outputKey});

class SignalMapper extends SimpleMapper1<Signal> {
  const SignalMapper();

  @override
  Signal<T> decode<T>(dynamic value) {
    T content = MapperContainer.globals.fromValue<T>(value);
    return signal<T>(content);
  }

  @override
  dynamic encode<T>(Signal<T> self) {
    return MapperContainer.globals.toValue<T>(self.value);
  }

  @override
  Function get typeFactory => <T>(f) => f<Signal<T>>();
}


class ReadonlySignalMapper extends SimpleMapper1<ReadonlySignal> {
  const ReadonlySignalMapper();

  @override
  ReadonlySignal<T> decode<T>(dynamic value) {
    T content = MapperContainer.globals.fromValue<T>(value);
    return signal<T>(content);
  }

  @override
  dynamic encode<T>(ReadonlySignal<T> self) {
    return MapperContainer.globals.toValue<T>(self.value);
  }

  @override
  Function get typeFactory => <T>(f) => f<ReadonlySignal<T>>();
}

class InputMapper extends SimpleMapper<Map<String, NodeInput>> {
  const InputMapper();

  @override
  Map<String, NodeInput> decode(dynamic value) {
    final data = value as Map<String, Object?>;
    return {
      for (final entry in data.entries) ...{
        entry.key: () {
          final str = entry.value as String;
          ({int nodeId, String outputKey})? link;
          Object? value;
          if (str.contains('|')) {
            final parts = str.split('|');
            value = jsonDecode(parts.first);
            final [nodeId, outKey] = parts.last.split(':');
            link = (nodeId: int.parse(nodeId), outputKey: outKey);
          } else {
            value = jsonDecode(str);
          }
          return (
            link: link,
            value: signal(value),
          );
        }(),
      },
    };
  }

  @override
  dynamic encode(Map<String, NodeInput> self) {
    return {
      for (final entry in self.entries) ...{
        entry.key: () {
          String out = jsonEncode(entry.value.value.value);
          if (entry.value.link != null) {
            final link = entry.value.link!;
            out += '|\${link.nodeId}:\${link.outputKey}';
          }
          return out;
        }(),
      },
    };
  }
}
''';

const nodeTemplate = '''
import 'package:dart_mappable/dart_mappable.dart';
import 'package:signals/signals.dart';

import '../base_node.dart';

{{#imports}}
import '{{path}}'{{#alias}} as {{.}}{{/alias}};
{{/imports}}

part '{{file}}.mapper.dart';

@MappableClass(discriminatorValue: '{{file}}', includeCustomMappers: [SignalMapper(), ReadonlySignalMapper(), InputMapper()],)
class {{class}} extends {{base}} with {{class}}Mappable {
  {{class}}({
    required super.id,
    required super.inputs,
    required super.offset,
    required super.label,
    required super.expanded,
  });

  {{class}}.defaults(int id) : super(
    id: id,
    offset: signal((dx: 0, dy: 0)),
    label: signal('{{name}}'),
    expanded: signal(true),
    inputs: {
    {{#inputs}}
    '{{name}}': (link: null, value: signal<{{type}}>({{{value}}})),
    {{/inputs}}
  },);
  
  @override
  Map<String, ReadonlySignal> get outputs => {
    {{#outputs}}
    '{{name}}': computed<{{type}}>(() {
      return {{{code}}};
    }),
    {{/outputs}}
  };

  static const fromMap = {{class}}Mapper.fromMap;
  static const fromJson = {{class}}Mapper.fromJson;

  @override
  bool get canAddInputs => {{canAddInputs}};

  @override
  Map<String, String> inputTypes() {
    return {
    {{#inputs}}
    '{{name}}': '{{type}}',
    {{/inputs}}
    };
  }

  @override
  Map<String, String> outputTypes() {
    return {
    {{#outputs}}
    '{{name}}': '{{type}}',
    {{/outputs}}
    };
  }
}
''';

const menuTemplate = '''
import '../../presentation/widgets/menus.dart';
import '../nodes/base_node.dart';

{{#imports}}
import '../nodes/{{{.}}}.dart';
{{/imports}}

MenuEntry {{name}}Menus(void Function(BaseNode Function(int)) onPressed) {
  return MenuEntry(
    label: '{{name}}',
    menuChildren: [
      {{#groups}}
      MenuEntry(
        label: '{{name}}',
        menuChildren: [
          {{#items}}
          MenuEntry(
            label: '{{name}}',
            onPressed: () => onPressed({{node}}.defaults),
          ),
          {{/items}}
        ],
      ),
      {{/groups}}
      {{#items}}
      MenuEntry(
        label: '{{name}}',
        onPressed: () => onPressed({{node}}.defaults),
      ),
      {{/items}}
    ],
  );
}
''';
