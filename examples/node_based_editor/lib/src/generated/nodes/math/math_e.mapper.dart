// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_e.dart';

class MathEMapper extends SubClassMapperBase<MathE> {
  MathEMapper._();

  static MathEMapper? _instance;
  static MathEMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathEMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathE';

  static int _$id(MathE v) => v.id;
  static const Field<MathE, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathE v) => v.inputs;
  static const Field<MathE, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathE v) => v.offset;
  static const Field<MathE, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathE v) => v.label;
  static const Field<MathE, Signal<String>> _f$label = Field('label', _$label);
  static Signal<bool> _$expanded(MathE v) => v.expanded;
  static const Field<MathE, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathE v) => v.getNode;
  static const Field<MathE, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathE> fields = const {
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
  final dynamic discriminatorValue = 'math_e';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathE _instantiate(DecodingData data) {
    return MathE(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathE fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathE>(map);
  }

  static MathE fromJson(String json) {
    return ensureInitialized().decodeJson<MathE>(json);
  }
}

mixin MathEMappable {
  String toJson() {
    return MathEMapper.ensureInitialized().encodeJson<MathE>(this as MathE);
  }

  Map<String, dynamic> toMap() {
    return MathEMapper.ensureInitialized().encodeMap<MathE>(this as MathE);
  }

  MathECopyWith<MathE, MathE, MathE> get copyWith =>
      _MathECopyWithImpl(this as MathE, $identity, $identity);
  @override
  String toString() {
    return MathEMapper.ensureInitialized().stringifyValue(this as MathE);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathEMapper.ensureInitialized().isValueEqual(this as MathE, other));
  }

  @override
  int get hashCode {
    return MathEMapper.ensureInitialized().hashValue(this as MathE);
  }
}

extension MathEValueCopy<$R, $Out> on ObjectCopyWith<$R, MathE, $Out> {
  MathECopyWith<$R, MathE, $Out> get $asMathE =>
      $base.as((v, t, t2) => _MathECopyWithImpl(v, t, t2));
}

abstract class MathECopyWith<$R, $In extends MathE, $Out>
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
  MathECopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathECopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, MathE, $Out>
    implements MathECopyWith<$R, MathE, $Out> {
  _MathECopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathE> $mapper = MathEMapper.ensureInitialized();
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
  MathE $make(CopyWithData data) => MathE(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathECopyWith<$R2, MathE, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathECopyWithImpl($value, $cast, t);
}
