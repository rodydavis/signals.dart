// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_ln2.dart';

class MathLn2Mapper extends SubClassMapperBase<MathLn2> {
  MathLn2Mapper._();

  static MathLn2Mapper? _instance;
  static MathLn2Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathLn2Mapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathLn2';

  static int _$id(MathLn2 v) => v.id;
  static const Field<MathLn2, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathLn2 v) => v.inputs;
  static const Field<MathLn2, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathLn2 v) => v.offset;
  static const Field<MathLn2, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathLn2 v) => v.label;
  static const Field<MathLn2, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathLn2 v) => v.expanded;
  static const Field<MathLn2, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathLn2 v) => v.getNode;
  static const Field<MathLn2, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathLn2> fields = const {
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
  final dynamic discriminatorValue = 'math_ln2';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathLn2 _instantiate(DecodingData data) {
    return MathLn2(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathLn2 fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathLn2>(map);
  }

  static MathLn2 fromJson(String json) {
    return ensureInitialized().decodeJson<MathLn2>(json);
  }
}

mixin MathLn2Mappable {
  String toJson() {
    return MathLn2Mapper.ensureInitialized()
        .encodeJson<MathLn2>(this as MathLn2);
  }

  Map<String, dynamic> toMap() {
    return MathLn2Mapper.ensureInitialized()
        .encodeMap<MathLn2>(this as MathLn2);
  }

  MathLn2CopyWith<MathLn2, MathLn2, MathLn2> get copyWith =>
      _MathLn2CopyWithImpl(this as MathLn2, $identity, $identity);
  @override
  String toString() {
    return MathLn2Mapper.ensureInitialized().stringifyValue(this as MathLn2);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathLn2Mapper.ensureInitialized()
                .isValueEqual(this as MathLn2, other));
  }

  @override
  int get hashCode {
    return MathLn2Mapper.ensureInitialized().hashValue(this as MathLn2);
  }
}

extension MathLn2ValueCopy<$R, $Out> on ObjectCopyWith<$R, MathLn2, $Out> {
  MathLn2CopyWith<$R, MathLn2, $Out> get $asMathLn2 =>
      $base.as((v, t, t2) => _MathLn2CopyWithImpl(v, t, t2));
}

abstract class MathLn2CopyWith<$R, $In extends MathLn2, $Out>
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
  MathLn2CopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathLn2CopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathLn2, $Out>
    implements MathLn2CopyWith<$R, MathLn2, $Out> {
  _MathLn2CopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathLn2> $mapper =
      MathLn2Mapper.ensureInitialized();
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
  MathLn2 $make(CopyWithData data) => MathLn2(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathLn2CopyWith<$R2, MathLn2, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathLn2CopyWithImpl($value, $cast, t);
}
