// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_pi.dart';

class MathPiMapper extends SubClassMapperBase<MathPi> {
  MathPiMapper._();

  static MathPiMapper? _instance;
  static MathPiMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathPiMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathPi';

  static int _$id(MathPi v) => v.id;
  static const Field<MathPi, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathPi v) => v.inputs;
  static const Field<MathPi, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathPi v) => v.offset;
  static const Field<MathPi, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathPi v) => v.label;
  static const Field<MathPi, Signal<String>> _f$label = Field('label', _$label);
  static Signal<bool> _$expanded(MathPi v) => v.expanded;
  static const Field<MathPi, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathPi v) => v.getNode;
  static const Field<MathPi, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathPi> fields = const {
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
  final dynamic discriminatorValue = 'math_pi';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathPi _instantiate(DecodingData data) {
    return MathPi(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathPi fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathPi>(map);
  }

  static MathPi fromJson(String json) {
    return ensureInitialized().decodeJson<MathPi>(json);
  }
}

mixin MathPiMappable {
  String toJson() {
    return MathPiMapper.ensureInitialized().encodeJson<MathPi>(this as MathPi);
  }

  Map<String, dynamic> toMap() {
    return MathPiMapper.ensureInitialized().encodeMap<MathPi>(this as MathPi);
  }

  MathPiCopyWith<MathPi, MathPi, MathPi> get copyWith =>
      _MathPiCopyWithImpl(this as MathPi, $identity, $identity);
  @override
  String toString() {
    return MathPiMapper.ensureInitialized().stringifyValue(this as MathPi);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathPiMapper.ensureInitialized()
                .isValueEqual(this as MathPi, other));
  }

  @override
  int get hashCode {
    return MathPiMapper.ensureInitialized().hashValue(this as MathPi);
  }
}

extension MathPiValueCopy<$R, $Out> on ObjectCopyWith<$R, MathPi, $Out> {
  MathPiCopyWith<$R, MathPi, $Out> get $asMathPi =>
      $base.as((v, t, t2) => _MathPiCopyWithImpl(v, t, t2));
}

abstract class MathPiCopyWith<$R, $In extends MathPi, $Out>
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
  MathPiCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathPiCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, MathPi, $Out>
    implements MathPiCopyWith<$R, MathPi, $Out> {
  _MathPiCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathPi> $mapper = MathPiMapper.ensureInitialized();
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
  MathPi $make(CopyWithData data) => MathPi(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathPiCopyWith<$R2, MathPi, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MathPiCopyWithImpl($value, $cast, t);
}
