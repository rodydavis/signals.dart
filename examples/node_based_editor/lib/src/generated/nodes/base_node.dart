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
            out += '|${link.nodeId}:${link.outputKey}';
          }
          return out;
        }(),
      },
    };
  }
}
