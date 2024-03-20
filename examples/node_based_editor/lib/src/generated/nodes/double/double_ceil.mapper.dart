// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'double_ceil.dart';

class DoubleCeilMapper extends SubClassMapperBase<DoubleCeil> {
  DoubleCeilMapper._();

  static DoubleCeilMapper? _instance;
  static DoubleCeilMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DoubleCeilMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DoubleCeil';

  static int _$id(DoubleCeil v) => v.id;
  static const Field<DoubleCeil, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(DoubleCeil v) => v.inputs;
  static const Field<DoubleCeil, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(DoubleCeil v) => v.offset;
  static const Field<DoubleCeil, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(DoubleCeil v) => v.label;
  static const Field<DoubleCeil, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(DoubleCeil v) => v.expanded;
  static const Field<DoubleCeil, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(DoubleCeil v) => v.getNode;
  static const Field<DoubleCeil, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<DoubleCeil> fields = const {
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
  final dynamic discriminatorValue = 'double_ceil';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static DoubleCeil _instantiate(DecodingData data) {
    return DoubleCeil(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static DoubleCeil fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DoubleCeil>(map);
  }

  static DoubleCeil fromJson(String json) {
    return ensureInitialized().decodeJson<DoubleCeil>(json);
  }
}

mixin DoubleCeilMappable {
  String toJson() {
    return DoubleCeilMapper.ensureInitialized()
        .encodeJson<DoubleCeil>(this as DoubleCeil);
  }

  Map<String, dynamic> toMap() {
    return DoubleCeilMapper.ensureInitialized()
        .encodeMap<DoubleCeil>(this as DoubleCeil);
  }

  DoubleCeilCopyWith<DoubleCeil, DoubleCeil, DoubleCeil> get copyWith =>
      _DoubleCeilCopyWithImpl(this as DoubleCeil, $identity, $identity);
  @override
  String toString() {
    return DoubleCeilMapper.ensureInitialized()
        .stringifyValue(this as DoubleCeil);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DoubleCeilMapper.ensureInitialized()
                .isValueEqual(this as DoubleCeil, other));
  }

  @override
  int get hashCode {
    return DoubleCeilMapper.ensureInitialized().hashValue(this as DoubleCeil);
  }
}

extension DoubleCeilValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DoubleCeil, $Out> {
  DoubleCeilCopyWith<$R, DoubleCeil, $Out> get $asDoubleCeil =>
      $base.as((v, t, t2) => _DoubleCeilCopyWithImpl(v, t, t2));
}

abstract class DoubleCeilCopyWith<$R, $In extends DoubleCeil, $Out>
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
  DoubleCeilCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DoubleCeilCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DoubleCeil, $Out>
    implements DoubleCeilCopyWith<$R, DoubleCeil, $Out> {
  _DoubleCeilCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DoubleCeil> $mapper =
      DoubleCeilMapper.ensureInitialized();
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
  DoubleCeil $make(CopyWithData data) => DoubleCeil(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  DoubleCeilCopyWith<$R2, DoubleCeil, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DoubleCeilCopyWithImpl($value, $cast, t);
}
