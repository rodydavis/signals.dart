// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_sqrt2.dart';

class MathSqrt2Mapper extends SubClassMapperBase<MathSqrt2> {
  MathSqrt2Mapper._();

  static MathSqrt2Mapper? _instance;
  static MathSqrt2Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathSqrt2Mapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathSqrt2';

  static int _$id(MathSqrt2 v) => v.id;
  static const Field<MathSqrt2, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathSqrt2 v) => v.inputs;
  static const Field<MathSqrt2, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathSqrt2 v) => v.offset;
  static const Field<MathSqrt2, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathSqrt2 v) => v.label;
  static const Field<MathSqrt2, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathSqrt2 v) => v.expanded;
  static const Field<MathSqrt2, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathSqrt2 v) => v.getNode;
  static const Field<MathSqrt2, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathSqrt2> fields = const {
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
  final dynamic discriminatorValue = 'math_sqrt2';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathSqrt2 _instantiate(DecodingData data) {
    return MathSqrt2(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathSqrt2 fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathSqrt2>(map);
  }

  static MathSqrt2 fromJson(String json) {
    return ensureInitialized().decodeJson<MathSqrt2>(json);
  }
}

mixin MathSqrt2Mappable {
  String toJson() {
    return MathSqrt2Mapper.ensureInitialized()
        .encodeJson<MathSqrt2>(this as MathSqrt2);
  }

  Map<String, dynamic> toMap() {
    return MathSqrt2Mapper.ensureInitialized()
        .encodeMap<MathSqrt2>(this as MathSqrt2);
  }

  MathSqrt2CopyWith<MathSqrt2, MathSqrt2, MathSqrt2> get copyWith =>
      _MathSqrt2CopyWithImpl(this as MathSqrt2, $identity, $identity);
  @override
  String toString() {
    return MathSqrt2Mapper.ensureInitialized()
        .stringifyValue(this as MathSqrt2);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathSqrt2Mapper.ensureInitialized()
                .isValueEqual(this as MathSqrt2, other));
  }

  @override
  int get hashCode {
    return MathSqrt2Mapper.ensureInitialized().hashValue(this as MathSqrt2);
  }
}

extension MathSqrt2ValueCopy<$R, $Out> on ObjectCopyWith<$R, MathSqrt2, $Out> {
  MathSqrt2CopyWith<$R, MathSqrt2, $Out> get $asMathSqrt2 =>
      $base.as((v, t, t2) => _MathSqrt2CopyWithImpl(v, t, t2));
}

abstract class MathSqrt2CopyWith<$R, $In extends MathSqrt2, $Out>
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
  MathSqrt2CopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathSqrt2CopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathSqrt2, $Out>
    implements MathSqrt2CopyWith<$R, MathSqrt2, $Out> {
  _MathSqrt2CopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathSqrt2> $mapper =
      MathSqrt2Mapper.ensureInitialized();
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
  MathSqrt2 $make(CopyWithData data) => MathSqrt2(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathSqrt2CopyWith<$R2, MathSqrt2, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MathSqrt2CopyWithImpl($value, $cast, t);
}
