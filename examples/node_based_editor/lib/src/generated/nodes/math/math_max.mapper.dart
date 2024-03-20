// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_max.dart';

class MathMaxMapper extends SubClassMapperBase<MathMax> {
  MathMaxMapper._();

  static MathMaxMapper? _instance;
  static MathMaxMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathMaxMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathMax';

  static int _$id(MathMax v) => v.id;
  static const Field<MathMax, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathMax v) => v.inputs;
  static const Field<MathMax, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathMax v) => v.offset;
  static const Field<MathMax, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathMax v) => v.label;
  static const Field<MathMax, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathMax v) => v.expanded;
  static const Field<MathMax, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathMax v) => v.getNode;
  static const Field<MathMax, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathMax> fields = const {
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
  final dynamic discriminatorValue = 'math_max';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathMax _instantiate(DecodingData data) {
    return MathMax(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathMax fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathMax>(map);
  }

  static MathMax fromJson(String json) {
    return ensureInitialized().decodeJson<MathMax>(json);
  }
}

mixin MathMaxMappable {
  String toJson() {
    return MathMaxMapper.ensureInitialized()
        .encodeJson<MathMax>(this as MathMax);
  }

  Map<String, dynamic> toMap() {
    return MathMaxMapper.ensureInitialized()
        .encodeMap<MathMax>(this as MathMax);
  }

  MathMaxCopyWith<MathMax, MathMax, MathMax> get copyWith =>
      _MathMaxCopyWithImpl(this as MathMax, $identity, $identity);
  @override
  String toString() {
    return MathMaxMapper.ensureInitialized().stringifyValue(this as MathMax);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathMaxMapper.ensureInitialized()
                .isValueEqual(this as MathMax, other));
  }

  @override
  int get hashCode {
    return MathMaxMapper.ensureInitialized().hashValue(this as MathMax);
  }
}

extension MathMaxValueCopy<$R, $Out> on ObjectCopyWith<$R, MathMax, $Out> {
  MathMaxCopyWith<$R, MathMax, $Out> get $asMathMax =>
      $base.as((v, t, t2) => _MathMaxCopyWithImpl(v, t, t2));
}

abstract class MathMaxCopyWith<$R, $In extends MathMax, $Out>
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
  MathMaxCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathMaxCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathMax, $Out>
    implements MathMaxCopyWith<$R, MathMax, $Out> {
  _MathMaxCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathMax> $mapper =
      MathMaxMapper.ensureInitialized();
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
  MathMax $make(CopyWithData data) => MathMax(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathMaxCopyWith<$R2, MathMax, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathMaxCopyWithImpl($value, $cast, t);
}
