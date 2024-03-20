// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_atan2.dart';

class MathAtan2Mapper extends SubClassMapperBase<MathAtan2> {
  MathAtan2Mapper._();

  static MathAtan2Mapper? _instance;
  static MathAtan2Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathAtan2Mapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathAtan2';

  static int _$id(MathAtan2 v) => v.id;
  static const Field<MathAtan2, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathAtan2 v) => v.inputs;
  static const Field<MathAtan2, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathAtan2 v) => v.offset;
  static const Field<MathAtan2, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathAtan2 v) => v.label;
  static const Field<MathAtan2, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathAtan2 v) => v.expanded;
  static const Field<MathAtan2, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathAtan2 v) => v.getNode;
  static const Field<MathAtan2, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathAtan2> fields = const {
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
  final dynamic discriminatorValue = 'math_atan2';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathAtan2 _instantiate(DecodingData data) {
    return MathAtan2(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathAtan2 fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathAtan2>(map);
  }

  static MathAtan2 fromJson(String json) {
    return ensureInitialized().decodeJson<MathAtan2>(json);
  }
}

mixin MathAtan2Mappable {
  String toJson() {
    return MathAtan2Mapper.ensureInitialized()
        .encodeJson<MathAtan2>(this as MathAtan2);
  }

  Map<String, dynamic> toMap() {
    return MathAtan2Mapper.ensureInitialized()
        .encodeMap<MathAtan2>(this as MathAtan2);
  }

  MathAtan2CopyWith<MathAtan2, MathAtan2, MathAtan2> get copyWith =>
      _MathAtan2CopyWithImpl(this as MathAtan2, $identity, $identity);
  @override
  String toString() {
    return MathAtan2Mapper.ensureInitialized()
        .stringifyValue(this as MathAtan2);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathAtan2Mapper.ensureInitialized()
                .isValueEqual(this as MathAtan2, other));
  }

  @override
  int get hashCode {
    return MathAtan2Mapper.ensureInitialized().hashValue(this as MathAtan2);
  }
}

extension MathAtan2ValueCopy<$R, $Out> on ObjectCopyWith<$R, MathAtan2, $Out> {
  MathAtan2CopyWith<$R, MathAtan2, $Out> get $asMathAtan2 =>
      $base.as((v, t, t2) => _MathAtan2CopyWithImpl(v, t, t2));
}

abstract class MathAtan2CopyWith<$R, $In extends MathAtan2, $Out>
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
  MathAtan2CopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathAtan2CopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathAtan2, $Out>
    implements MathAtan2CopyWith<$R, MathAtan2, $Out> {
  _MathAtan2CopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathAtan2> $mapper =
      MathAtan2Mapper.ensureInitialized();
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
  MathAtan2 $make(CopyWithData data) => MathAtan2(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathAtan2CopyWith<$R2, MathAtan2, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MathAtan2CopyWithImpl($value, $cast, t);
}
