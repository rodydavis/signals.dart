// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_floor_to_double.dart';

class NumFloorToDoubleMapper extends SubClassMapperBase<NumFloorToDouble> {
  NumFloorToDoubleMapper._();

  static NumFloorToDoubleMapper? _instance;
  static NumFloorToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumFloorToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumFloorToDouble';

  static int _$id(NumFloorToDouble v) => v.id;
  static const Field<NumFloorToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumFloorToDouble v) =>
      v.inputs;
  static const Field<NumFloorToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumFloorToDouble v) => v.offset;
  static const Field<NumFloorToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumFloorToDouble v) => v.label;
  static const Field<NumFloorToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumFloorToDouble v) => v.expanded;
  static const Field<NumFloorToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumFloorToDouble v) => v.getNode;
  static const Field<NumFloorToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumFloorToDouble> fields = const {
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
  final dynamic discriminatorValue = 'num_floor_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumFloorToDouble _instantiate(DecodingData data) {
    return NumFloorToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumFloorToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumFloorToDouble>(map);
  }

  static NumFloorToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<NumFloorToDouble>(json);
  }
}

mixin NumFloorToDoubleMappable {
  String toJson() {
    return NumFloorToDoubleMapper.ensureInitialized()
        .encodeJson<NumFloorToDouble>(this as NumFloorToDouble);
  }

  Map<String, dynamic> toMap() {
    return NumFloorToDoubleMapper.ensureInitialized()
        .encodeMap<NumFloorToDouble>(this as NumFloorToDouble);
  }

  NumFloorToDoubleCopyWith<NumFloorToDouble, NumFloorToDouble, NumFloorToDouble>
      get copyWith => _NumFloorToDoubleCopyWithImpl(
          this as NumFloorToDouble, $identity, $identity);
  @override
  String toString() {
    return NumFloorToDoubleMapper.ensureInitialized()
        .stringifyValue(this as NumFloorToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumFloorToDoubleMapper.ensureInitialized()
                .isValueEqual(this as NumFloorToDouble, other));
  }

  @override
  int get hashCode {
    return NumFloorToDoubleMapper.ensureInitialized()
        .hashValue(this as NumFloorToDouble);
  }
}

extension NumFloorToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumFloorToDouble, $Out> {
  NumFloorToDoubleCopyWith<$R, NumFloorToDouble, $Out>
      get $asNumFloorToDouble =>
          $base.as((v, t, t2) => _NumFloorToDoubleCopyWithImpl(v, t, t2));
}

abstract class NumFloorToDoubleCopyWith<$R, $In extends NumFloorToDouble, $Out>
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
  NumFloorToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NumFloorToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumFloorToDouble, $Out>
    implements NumFloorToDoubleCopyWith<$R, NumFloorToDouble, $Out> {
  _NumFloorToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumFloorToDouble> $mapper =
      NumFloorToDoubleMapper.ensureInitialized();
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
  NumFloorToDouble $make(CopyWithData data) => NumFloorToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumFloorToDoubleCopyWith<$R2, NumFloorToDouble, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumFloorToDoubleCopyWithImpl($value, $cast, t);
}
