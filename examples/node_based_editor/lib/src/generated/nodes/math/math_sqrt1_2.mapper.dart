// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_sqrt1_2.dart';

class MathSqrt12Mapper extends SubClassMapperBase<MathSqrt12> {
  MathSqrt12Mapper._();

  static MathSqrt12Mapper? _instance;
  static MathSqrt12Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathSqrt12Mapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathSqrt12';

  static int _$id(MathSqrt12 v) => v.id;
  static const Field<MathSqrt12, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathSqrt12 v) => v.inputs;
  static const Field<MathSqrt12, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathSqrt12 v) => v.offset;
  static const Field<MathSqrt12, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathSqrt12 v) => v.label;
  static const Field<MathSqrt12, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathSqrt12 v) => v.expanded;
  static const Field<MathSqrt12, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathSqrt12 v) => v.getNode;
  static const Field<MathSqrt12, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathSqrt12> fields = const {
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
  final dynamic discriminatorValue = 'math_sqrt1_2';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathSqrt12 _instantiate(DecodingData data) {
    return MathSqrt12(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathSqrt12 fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathSqrt12>(map);
  }

  static MathSqrt12 fromJson(String json) {
    return ensureInitialized().decodeJson<MathSqrt12>(json);
  }
}

mixin MathSqrt12Mappable {
  String toJson() {
    return MathSqrt12Mapper.ensureInitialized()
        .encodeJson<MathSqrt12>(this as MathSqrt12);
  }

  Map<String, dynamic> toMap() {
    return MathSqrt12Mapper.ensureInitialized()
        .encodeMap<MathSqrt12>(this as MathSqrt12);
  }

  MathSqrt12CopyWith<MathSqrt12, MathSqrt12, MathSqrt12> get copyWith =>
      _MathSqrt12CopyWithImpl(this as MathSqrt12, $identity, $identity);
  @override
  String toString() {
    return MathSqrt12Mapper.ensureInitialized()
        .stringifyValue(this as MathSqrt12);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathSqrt12Mapper.ensureInitialized()
                .isValueEqual(this as MathSqrt12, other));
  }

  @override
  int get hashCode {
    return MathSqrt12Mapper.ensureInitialized().hashValue(this as MathSqrt12);
  }
}

extension MathSqrt12ValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MathSqrt12, $Out> {
  MathSqrt12CopyWith<$R, MathSqrt12, $Out> get $asMathSqrt12 =>
      $base.as((v, t, t2) => _MathSqrt12CopyWithImpl(v, t, t2));
}

abstract class MathSqrt12CopyWith<$R, $In extends MathSqrt12, $Out>
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
  MathSqrt12CopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathSqrt12CopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathSqrt12, $Out>
    implements MathSqrt12CopyWith<$R, MathSqrt12, $Out> {
  _MathSqrt12CopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathSqrt12> $mapper =
      MathSqrt12Mapper.ensureInitialized();
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
  MathSqrt12 $make(CopyWithData data) => MathSqrt12(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathSqrt12CopyWith<$R2, MathSqrt12, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MathSqrt12CopyWithImpl($value, $cast, t);
}
