// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_node.dart';

class StringNodeMapper extends SubClassMapperBase<StringNode> {
  StringNodeMapper._();

  static StringNodeMapper? _instance;
  static StringNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringNode';

  static int _$id(StringNode v) => v.id;
  static const Field<StringNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringNode v) => v.inputs;
  static const Field<StringNode, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringNode v) => v.offset;
  static const Field<StringNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringNode v) => v.label;
  static const Field<StringNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringNode v) => v.expanded;
  static const Field<StringNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringNode v) => v.getNode;
  static const Field<StringNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringNode> fields = const {
    #id: _f$id,
    #inputs: _f$inputs,
    #offset: _f$offset,
    #label: _f$label,
    #expanded: _f$expanded,
    #getNode: _f$getNode,
  };

  @override
  final String discriminatorKey = '__type';
  @override
  final dynamic discriminatorValue = 'string_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringNode _instantiate(DecodingData data) {
    return StringNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringNode>(map);
  }

  static StringNode fromJson(String json) {
    return ensureInitialized().decodeJson<StringNode>(json);
  }
}

mixin StringNodeMappable {
  String toJson() {
    return StringNodeMapper.ensureInitialized()
        .encodeJson<StringNode>(this as StringNode);
  }

  Map<String, dynamic> toMap() {
    return StringNodeMapper.ensureInitialized()
        .encodeMap<StringNode>(this as StringNode);
  }

  StringNodeCopyWith<StringNode, StringNode, StringNode> get copyWith =>
      _StringNodeCopyWithImpl(this as StringNode, $identity, $identity);
  @override
  String toString() {
    return StringNodeMapper.ensureInitialized()
        .stringifyValue(this as StringNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringNodeMapper.ensureInitialized()
                .isValueEqual(this as StringNode, other));
  }

  @override
  int get hashCode {
    return StringNodeMapper.ensureInitialized().hashValue(this as StringNode);
  }
}

extension StringNodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringNode, $Out> {
  StringNodeCopyWith<$R, StringNode, $Out> get $asStringNode =>
      $base.as((v, t, t2) => _StringNodeCopyWithImpl(v, t, t2));
}

abstract class StringNodeCopyWith<$R, $In extends StringNode, $Out>
    implements BaseNodeCopyWith<$R, $In, $Out> {
  @override
  MapCopyWith<$R, String, NodeInput<dynamic>,
      ObjectCopyWith<$R, NodeInput<dynamic>, NodeInput<dynamic>>> get inputs;
  @override
  $R call(
      {int? id,
      Map<String, NodeInput<dynamic>>? inputs,
      Signal<NodeOffset>? offset,
      Signal<String>? label,
      Signal<bool>? expanded});
  StringNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringNode, $Out>
    implements StringNodeCopyWith<$R, StringNode, $Out> {
  _StringNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringNode> $mapper =
      StringNodeMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, NodeInput<dynamic>,
          ObjectCopyWith<$R, NodeInput<dynamic>, NodeInput<dynamic>>>
      get inputs => MapCopyWith($value.inputs,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(inputs: v));
  @override
  $R call(
          {int? id,
          Map<String, NodeInput<dynamic>>? inputs,
          Signal<NodeOffset>? offset,
          Signal<String>? label,
          Signal<bool>? expanded}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (inputs != null) #inputs: inputs,
        if (offset != null) #offset: offset,
        if (label != null) #label: label,
        if (expanded != null) #expanded: expanded
      }));
  @override
  StringNode $make(CopyWithData data) => StringNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringNodeCopyWith<$R2, StringNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringNodeCopyWithImpl($value, $cast, t);
}
