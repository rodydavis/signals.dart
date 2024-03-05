// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_to_int.dart';

class NumToIntMapper extends SubClassMapperBase<NumToInt> {
  NumToIntMapper._();

  static NumToIntMapper? _instance;
  static NumToIntMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumToIntMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumToInt';

  static int _$id(NumToInt v) => v.id;
  static const Field<NumToInt, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumToInt v) => v.inputs;
  static const Field<NumToInt, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumToInt v) => v.offset;
  static const Field<NumToInt, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumToInt v) => v.label;
  static const Field<NumToInt, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumToInt v) => v.expanded;
  static const Field<NumToInt, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumToInt v) => v.getNode;
  static const Field<NumToInt, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumToInt> fields = const {
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
  final dynamic discriminatorValue = 'num_to_int';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumToInt _instantiate(DecodingData data) {
    return NumToInt(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumToInt fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumToInt>(map);
  }

  static NumToInt fromJson(String json) {
    return ensureInitialized().decodeJson<NumToInt>(json);
  }
}

mixin NumToIntMappable {
  String toJson() {
    return NumToIntMapper.ensureInitialized()
        .encodeJson<NumToInt>(this as NumToInt);
  }

  Map<String, dynamic> toMap() {
    return NumToIntMapper.ensureInitialized()
        .encodeMap<NumToInt>(this as NumToInt);
  }

  NumToIntCopyWith<NumToInt, NumToInt, NumToInt> get copyWith =>
      _NumToIntCopyWithImpl(this as NumToInt, $identity, $identity);
  @override
  String toString() {
    return NumToIntMapper.ensureInitialized().stringifyValue(this as NumToInt);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumToIntMapper.ensureInitialized()
                .isValueEqual(this as NumToInt, other));
  }

  @override
  int get hashCode {
    return NumToIntMapper.ensureInitialized().hashValue(this as NumToInt);
  }
}

extension NumToIntValueCopy<$R, $Out> on ObjectCopyWith<$R, NumToInt, $Out> {
  NumToIntCopyWith<$R, NumToInt, $Out> get $asNumToInt =>
      $base.as((v, t, t2) => _NumToIntCopyWithImpl(v, t, t2));
}

abstract class NumToIntCopyWith<$R, $In extends NumToInt, $Out>
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
  NumToIntCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumToIntCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumToInt, $Out>
    implements NumToIntCopyWith<$R, NumToInt, $Out> {
  _NumToIntCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumToInt> $mapper =
      NumToIntMapper.ensureInitialized();
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
  NumToInt $make(CopyWithData data) => NumToInt(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumToIntCopyWith<$R2, NumToInt, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumToIntCopyWithImpl($value, $cast, t);
}
