// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_pow.dart';

class MathPowMapper extends SubClassMapperBase<MathPow> {
  MathPowMapper._();

  static MathPowMapper? _instance;
  static MathPowMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathPowMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathPow';

  static int _$id(MathPow v) => v.id;
  static const Field<MathPow, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathPow v) => v.inputs;
  static const Field<MathPow, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathPow v) => v.offset;
  static const Field<MathPow, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathPow v) => v.label;
  static const Field<MathPow, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathPow v) => v.expanded;
  static const Field<MathPow, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathPow v) => v.getNode;
  static const Field<MathPow, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathPow> fields = const {
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
  final dynamic discriminatorValue = 'math_pow';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathPow _instantiate(DecodingData data) {
    return MathPow(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathPow fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathPow>(map);
  }

  static MathPow fromJson(String json) {
    return ensureInitialized().decodeJson<MathPow>(json);
  }
}

mixin MathPowMappable {
  String toJson() {
    return MathPowMapper.ensureInitialized()
        .encodeJson<MathPow>(this as MathPow);
  }

  Map<String, dynamic> toMap() {
    return MathPowMapper.ensureInitialized()
        .encodeMap<MathPow>(this as MathPow);
  }

  MathPowCopyWith<MathPow, MathPow, MathPow> get copyWith =>
      _MathPowCopyWithImpl(this as MathPow, $identity, $identity);
  @override
  String toString() {
    return MathPowMapper.ensureInitialized().stringifyValue(this as MathPow);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathPowMapper.ensureInitialized()
                .isValueEqual(this as MathPow, other));
  }

  @override
  int get hashCode {
    return MathPowMapper.ensureInitialized().hashValue(this as MathPow);
  }
}

extension MathPowValueCopy<$R, $Out> on ObjectCopyWith<$R, MathPow, $Out> {
  MathPowCopyWith<$R, MathPow, $Out> get $asMathPow =>
      $base.as((v, t, t2) => _MathPowCopyWithImpl(v, t, t2));
}

abstract class MathPowCopyWith<$R, $In extends MathPow, $Out>
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
  MathPowCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathPowCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathPow, $Out>
    implements MathPowCopyWith<$R, MathPow, $Out> {
  _MathPowCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathPow> $mapper =
      MathPowMapper.ensureInitialized();
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
  MathPow $make(CopyWithData data) => MathPow(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathPowCopyWith<$R2, MathPow, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathPowCopyWithImpl($value, $cast, t);
}
