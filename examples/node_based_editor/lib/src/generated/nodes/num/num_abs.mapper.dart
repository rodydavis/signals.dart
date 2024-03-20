// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_abs.dart';

class NumAbsMapper extends SubClassMapperBase<NumAbs> {
  NumAbsMapper._();

  static NumAbsMapper? _instance;
  static NumAbsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumAbsMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumAbs';

  static int _$id(NumAbs v) => v.id;
  static const Field<NumAbs, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumAbs v) => v.inputs;
  static const Field<NumAbs, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumAbs v) => v.offset;
  static const Field<NumAbs, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumAbs v) => v.label;
  static const Field<NumAbs, Signal<String>> _f$label = Field('label', _$label);
  static Signal<bool> _$expanded(NumAbs v) => v.expanded;
  static const Field<NumAbs, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumAbs v) => v.getNode;
  static const Field<NumAbs, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumAbs> fields = const {
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
  final dynamic discriminatorValue = 'num_abs';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumAbs _instantiate(DecodingData data) {
    return NumAbs(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumAbs fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumAbs>(map);
  }

  static NumAbs fromJson(String json) {
    return ensureInitialized().decodeJson<NumAbs>(json);
  }
}

mixin NumAbsMappable {
  String toJson() {
    return NumAbsMapper.ensureInitialized().encodeJson<NumAbs>(this as NumAbs);
  }

  Map<String, dynamic> toMap() {
    return NumAbsMapper.ensureInitialized().encodeMap<NumAbs>(this as NumAbs);
  }

  NumAbsCopyWith<NumAbs, NumAbs, NumAbs> get copyWith =>
      _NumAbsCopyWithImpl(this as NumAbs, $identity, $identity);
  @override
  String toString() {
    return NumAbsMapper.ensureInitialized().stringifyValue(this as NumAbs);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumAbsMapper.ensureInitialized()
                .isValueEqual(this as NumAbs, other));
  }

  @override
  int get hashCode {
    return NumAbsMapper.ensureInitialized().hashValue(this as NumAbs);
  }
}

extension NumAbsValueCopy<$R, $Out> on ObjectCopyWith<$R, NumAbs, $Out> {
  NumAbsCopyWith<$R, NumAbs, $Out> get $asNumAbs =>
      $base.as((v, t, t2) => _NumAbsCopyWithImpl(v, t, t2));
}

abstract class NumAbsCopyWith<$R, $In extends NumAbs, $Out>
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
  NumAbsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumAbsCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, NumAbs, $Out>
    implements NumAbsCopyWith<$R, NumAbs, $Out> {
  _NumAbsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumAbs> $mapper = NumAbsMapper.ensureInitialized();
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
  NumAbs $make(CopyWithData data) => NumAbs(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumAbsCopyWith<$R2, NumAbs, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NumAbsCopyWithImpl($value, $cast, t);
}
