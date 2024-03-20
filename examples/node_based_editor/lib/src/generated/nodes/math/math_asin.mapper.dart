// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'math_asin.dart';

class MathAsinMapper extends SubClassMapperBase<MathAsin> {
  MathAsinMapper._();

  static MathAsinMapper? _instance;
  static MathAsinMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MathAsinMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'MathAsin';

  static int _$id(MathAsin v) => v.id;
  static const Field<MathAsin, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(MathAsin v) => v.inputs;
  static const Field<MathAsin, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(MathAsin v) => v.offset;
  static const Field<MathAsin, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(MathAsin v) => v.label;
  static const Field<MathAsin, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(MathAsin v) => v.expanded;
  static const Field<MathAsin, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(MathAsin v) => v.getNode;
  static const Field<MathAsin, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<MathAsin> fields = const {
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
  final dynamic discriminatorValue = 'math_asin';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static MathAsin _instantiate(DecodingData data) {
    return MathAsin(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static MathAsin fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MathAsin>(map);
  }

  static MathAsin fromJson(String json) {
    return ensureInitialized().decodeJson<MathAsin>(json);
  }
}

mixin MathAsinMappable {
  String toJson() {
    return MathAsinMapper.ensureInitialized()
        .encodeJson<MathAsin>(this as MathAsin);
  }

  Map<String, dynamic> toMap() {
    return MathAsinMapper.ensureInitialized()
        .encodeMap<MathAsin>(this as MathAsin);
  }

  MathAsinCopyWith<MathAsin, MathAsin, MathAsin> get copyWith =>
      _MathAsinCopyWithImpl(this as MathAsin, $identity, $identity);
  @override
  String toString() {
    return MathAsinMapper.ensureInitialized().stringifyValue(this as MathAsin);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MathAsinMapper.ensureInitialized()
                .isValueEqual(this as MathAsin, other));
  }

  @override
  int get hashCode {
    return MathAsinMapper.ensureInitialized().hashValue(this as MathAsin);
  }
}

extension MathAsinValueCopy<$R, $Out> on ObjectCopyWith<$R, MathAsin, $Out> {
  MathAsinCopyWith<$R, MathAsin, $Out> get $asMathAsin =>
      $base.as((v, t, t2) => _MathAsinCopyWithImpl(v, t, t2));
}

abstract class MathAsinCopyWith<$R, $In extends MathAsin, $Out>
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
  MathAsinCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MathAsinCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MathAsin, $Out>
    implements MathAsinCopyWith<$R, MathAsin, $Out> {
  _MathAsinCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MathAsin> $mapper =
      MathAsinMapper.ensureInitialized();
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
  MathAsin $make(CopyWithData data) => MathAsin(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  MathAsinCopyWith<$R2, MathAsin, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MathAsinCopyWithImpl($value, $cast, t);
}
