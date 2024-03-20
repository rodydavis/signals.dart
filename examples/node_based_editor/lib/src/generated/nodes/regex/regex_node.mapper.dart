// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'regex_node.dart';

class RegexNodeMapper extends SubClassMapperBase<RegexNode> {
  RegexNodeMapper._();

  static RegexNodeMapper? _instance;
  static RegexNodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegexNodeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'RegexNode';

  static int _$id(RegexNode v) => v.id;
  static const Field<RegexNode, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(RegexNode v) => v.inputs;
  static const Field<RegexNode, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(RegexNode v) => v.offset;
  static const Field<RegexNode, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(RegexNode v) => v.label;
  static const Field<RegexNode, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(RegexNode v) => v.expanded;
  static const Field<RegexNode, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(RegexNode v) => v.getNode;
  static const Field<RegexNode, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<RegexNode> fields = const {
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
  final dynamic discriminatorValue = 'regex_node';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static RegexNode _instantiate(DecodingData data) {
    return RegexNode(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static RegexNode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegexNode>(map);
  }

  static RegexNode fromJson(String json) {
    return ensureInitialized().decodeJson<RegexNode>(json);
  }
}

mixin RegexNodeMappable {
  String toJson() {
    return RegexNodeMapper.ensureInitialized()
        .encodeJson<RegexNode>(this as RegexNode);
  }

  Map<String, dynamic> toMap() {
    return RegexNodeMapper.ensureInitialized()
        .encodeMap<RegexNode>(this as RegexNode);
  }

  RegexNodeCopyWith<RegexNode, RegexNode, RegexNode> get copyWith =>
      _RegexNodeCopyWithImpl(this as RegexNode, $identity, $identity);
  @override
  String toString() {
    return RegexNodeMapper.ensureInitialized()
        .stringifyValue(this as RegexNode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            RegexNodeMapper.ensureInitialized()
                .isValueEqual(this as RegexNode, other));
  }

  @override
  int get hashCode {
    return RegexNodeMapper.ensureInitialized().hashValue(this as RegexNode);
  }
}

extension RegexNodeValueCopy<$R, $Out> on ObjectCopyWith<$R, RegexNode, $Out> {
  RegexNodeCopyWith<$R, RegexNode, $Out> get $asRegexNode =>
      $base.as((v, t, t2) => _RegexNodeCopyWithImpl(v, t, t2));
}

abstract class RegexNodeCopyWith<$R, $In extends RegexNode, $Out>
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
  RegexNodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RegexNodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegexNode, $Out>
    implements RegexNodeCopyWith<$R, RegexNode, $Out> {
  _RegexNodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegexNode> $mapper =
      RegexNodeMapper.ensureInitialized();
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
  RegexNode $make(CopyWithData data) => RegexNode(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  RegexNodeCopyWith<$R2, RegexNode, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RegexNodeCopyWithImpl($value, $cast, t);
}
