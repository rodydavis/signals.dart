// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_cos.dart';

class MathCosMapper extends SubClassMapperBase<MathCos> {
  MathCosMapper._();

  static MathCosMapper? _instance;
  static MathCosMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathCosMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathCos';

  static int _$id(MathCos v) => v.id;
  static const Field<MathCos, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathCos v) => v.inputs;
  static const Field<MathCos, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathCos v) => v.offset;
  static const Field<MathCos, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathCos v) => v.label;
  static const Field<MathCos, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathCos v) => v.expanded;
  static const Field<MathCos, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathCos v) => v.getNode;
  static const Field<MathCos, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathCos> fields = const {
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
  final dynamic discriminatorValue = 'math_cos';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathCos _instantiate(DecodingData data) {
    return MathCos(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathCos fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathCos>(map);
  }

  static MathCos fromJson(String json) {
    return ensureInitialized().decodeJson<MathCos>(json);
  }
}

mixin MathCosMappable {
  String toJson() {
    return MathCosMapper.ensureInitialized()
        .encodeJson<MathCos>(this as MathCos);
  }

  Map<String, dynamic> toMap() {
    return MathCosMapper.ensureInitialized()
        .encodeMap<MathCos>(this as MathCos);
  }

  MathCosCopyWith<MathCos, MathCos, MathCos> get copyWith =>
      _MathCosCopyWithImpl(this as MathCos, $identity, $identity);
  @override
  String toString() {
    return MathCosMapper.ensureInitialized().stringifyValue(this as MathCos);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathCosMapper.ensureInitialized()
                .isValueEqual(this as MathCos, other));
  }

  @override
  int get hashCode {
    return MathCosMapper.ensureInitialized().hashValue(this as MathCos);
  }
}

extension MathCosValueCopy<$R, $Out> on ObjectCopyWith<$R, MathCos, $Out> {
  MathCosCopyWith<$R, MathCos, $Out> get $asMathCos =>
      $base.as((v, t, t2) => _MathCosCopyWithImpl(v, t, t2));
}

abstract class MathCosCopyWith<$R, $In extends MathCos, $Out>
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
  MathCosCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathCosCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathCos, $Out>
    implements MathCosCopyWith<$R, MathCos, $Out> {
  _MathCosCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathCos> $mapper =
      MathCosMapper.ensureInitialized();
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
  MathCos $make(CopyWithData data) => MathCos(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathCosCopyWith<$R2, MathCos, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathCosCopyWithImpl($value, $cast, t);
}
