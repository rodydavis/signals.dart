// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_sin.dart';

class MathSinMapper extends SubClassMapperBase<MathSin> {
  MathSinMapper._();

  static MathSinMapper? _instance;
  static MathSinMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathSinMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathSin';

  static int _$id(MathSin v) => v.id;
  static const Field<MathSin, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathSin v) => v.inputs;
  static const Field<MathSin, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathSin v) => v.offset;
  static const Field<MathSin, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathSin v) => v.label;
  static const Field<MathSin, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathSin v) => v.expanded;
  static const Field<MathSin, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathSin v) => v.getNode;
  static const Field<MathSin, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathSin> fields = const {
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
  final dynamic discriminatorValue = 'math_sin';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathSin _instantiate(DecodingData data) {
    return MathSin(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathSin fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathSin>(map);
  }

  static MathSin fromJson(String json) {
    return ensureInitialized().decodeJson<MathSin>(json);
  }
}

mixin MathSinMappable {
  String toJson() {
    return MathSinMapper.ensureInitialized()
        .encodeJson<MathSin>(this as MathSin);
  }

  Map<String, dynamic> toMap() {
    return MathSinMapper.ensureInitialized()
        .encodeMap<MathSin>(this as MathSin);
  }

  MathSinCopyWith<MathSin, MathSin, MathSin> get copyWith =>
      _MathSinCopyWithImpl(this as MathSin, $identity, $identity);
  @override
  String toString() {
    return MathSinMapper.ensureInitialized().stringifyValue(this as MathSin);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathSinMapper.ensureInitialized()
                .isValueEqual(this as MathSin, other));
  }

  @override
  int get hashCode {
    return MathSinMapper.ensureInitialized().hashValue(this as MathSin);
  }
}

extension MathSinValueCopy<$R, $Out> on ObjectCopyWith<$R, MathSin, $Out> {
  MathSinCopyWith<$R, MathSin, $Out> get $asMathSin =>
      $base.as((v, t, t2) => _MathSinCopyWithImpl(v, t, t2));
}

abstract class MathSinCopyWith<$R, $In extends MathSin, $Out>
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
  MathSinCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathSinCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathSin, $Out>
    implements MathSinCopyWith<$R, MathSin, $Out> {
  _MathSinCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathSin> $mapper =
      MathSinMapper.ensureInitialized();
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
  MathSin $make(CopyWithData data) => MathSin(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathSinCopyWith<$R2, MathSin, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathSinCopyWithImpl($value, $cast, t);
}
