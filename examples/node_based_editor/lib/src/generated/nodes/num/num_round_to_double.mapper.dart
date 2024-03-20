// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_round_to_double.dart';

class NumRoundToDoubleMapper extends SubClassMapperBase<NumRoundToDouble> {
  NumRoundToDoubleMapper._();

  static NumRoundToDoubleMapper? _instance;
  static NumRoundToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumRoundToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumRoundToDouble';

  static int _$id(NumRoundToDouble v) => v.id;
  static const Field<NumRoundToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumRoundToDouble v) =>
      v.inputs;
  static const Field<NumRoundToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumRoundToDouble v) => v.offset;
  static const Field<NumRoundToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumRoundToDouble v) => v.label;
  static const Field<NumRoundToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumRoundToDouble v) => v.expanded;
  static const Field<NumRoundToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumRoundToDouble v) => v.getNode;
  static const Field<NumRoundToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumRoundToDouble> fields = const {
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
  final dynamic discriminatorValue = 'num_round_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumRoundToDouble _instantiate(DecodingData data) {
    return NumRoundToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumRoundToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumRoundToDouble>(map);
  }

  static NumRoundToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<NumRoundToDouble>(json);
  }
}

mixin NumRoundToDoubleMappable {
  String toJson() {
    return NumRoundToDoubleMapper.ensureInitialized()
        .encodeJson<NumRoundToDouble>(this as NumRoundToDouble);
  }

  Map<String, dynamic> toMap() {
    return NumRoundToDoubleMapper.ensureInitialized()
        .encodeMap<NumRoundToDouble>(this as NumRoundToDouble);
  }

  NumRoundToDoubleCopyWith<NumRoundToDouble, NumRoundToDouble, NumRoundToDouble>
      get copyWith => _NumRoundToDoubleCopyWithImpl(
          this as NumRoundToDouble, $identity, $identity);
  @override
  String toString() {
    return NumRoundToDoubleMapper.ensureInitialized()
        .stringifyValue(this as NumRoundToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumRoundToDoubleMapper.ensureInitialized()
                .isValueEqual(this as NumRoundToDouble, other));
  }

  @override
  int get hashCode {
    return NumRoundToDoubleMapper.ensureInitialized()
        .hashValue(this as NumRoundToDouble);
  }
}

extension NumRoundToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumRoundToDouble, $Out> {
  NumRoundToDoubleCopyWith<$R, NumRoundToDouble, $Out>
      get $asNumRoundToDouble =>
          $base.as((v, t, t2) => _NumRoundToDoubleCopyWithImpl(v, t, t2));
}

abstract class NumRoundToDoubleCopyWith<$R, $In extends NumRoundToDouble, $Out>
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
  NumRoundToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NumRoundToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumRoundToDouble, $Out>
    implements NumRoundToDoubleCopyWith<$R, NumRoundToDouble, $Out> {
  _NumRoundToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumRoundToDouble> $mapper =
      NumRoundToDoubleMapper.ensureInitialized();
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
  NumRoundToDouble $make(CopyWithData data) => NumRoundToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumRoundToDoubleCopyWith<$R2, NumRoundToDouble, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumRoundToDoubleCopyWithImpl($value, $cast, t);
}
