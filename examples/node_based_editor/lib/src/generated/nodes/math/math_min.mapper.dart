// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_min.dart';

class MathMinMapper extends SubClassMapperBase<MathMin> {
  MathMinMapper._();

  static MathMinMapper? _instance;
  static MathMinMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathMinMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathMin';

  static int _$id(MathMin v) => v.id;
  static const Field<MathMin, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathMin v) => v.inputs;
  static const Field<MathMin, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathMin v) => v.offset;
  static const Field<MathMin, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathMin v) => v.label;
  static const Field<MathMin, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathMin v) => v.expanded;
  static const Field<MathMin, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathMin v) => v.getNode;
  static const Field<MathMin, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathMin> fields = const {
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
  final dynamic discriminatorValue = 'math_min';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathMin _instantiate(DecodingData data) {
    return MathMin(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathMin fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathMin>(map);
  }

  static MathMin fromJson(String json) {
    return ensureInitialized().decodeJson<MathMin>(json);
  }
}

mixin MathMinMappable {
  String toJson() {
    return MathMinMapper.ensureInitialized()
        .encodeJson<MathMin>(this as MathMin);
  }

  Map<String, dynamic> toMap() {
    return MathMinMapper.ensureInitialized()
        .encodeMap<MathMin>(this as MathMin);
  }

  MathMinCopyWith<MathMin, MathMin, MathMin> get copyWith =>
      _MathMinCopyWithImpl(this as MathMin, $identity, $identity);
  @override
  String toString() {
    return MathMinMapper.ensureInitialized().stringifyValue(this as MathMin);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathMinMapper.ensureInitialized()
                .isValueEqual(this as MathMin, other));
  }

  @override
  int get hashCode {
    return MathMinMapper.ensureInitialized().hashValue(this as MathMin);
  }
}

extension MathMinValueCopy<$R, $Out> on ObjectCopyWith<$R, MathMin, $Out> {
  MathMinCopyWith<$R, MathMin, $Out> get $asMathMin =>
      $base.as((v, t, t2) => _MathMinCopyWithImpl(v, t, t2));
}

abstract class MathMinCopyWith<$R, $In extends MathMin, $Out>
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
  MathMinCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathMinCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathMin, $Out>
    implements MathMinCopyWith<$R, MathMin, $Out> {
  _MathMinCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathMin> $mapper =
      MathMinMapper.ensureInitialized();
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
  MathMin $make(CopyWithData data) => MathMin(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathMinCopyWith<$R2, MathMin, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathMinCopyWithImpl($value, $cast, t);
}
