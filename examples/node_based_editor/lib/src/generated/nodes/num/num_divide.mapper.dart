// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_divide.dart';

class NumDivideMapper extends SubClassMapperBase<NumDivide> {
  NumDivideMapper._();

  static NumDivideMapper? _instance;
  static NumDivideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumDivideMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumDivide';

  static int _$id(NumDivide v) => v.id;
  static const Field<NumDivide, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumDivide v) => v.inputs;
  static const Field<NumDivide, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumDivide v) => v.offset;
  static const Field<NumDivide, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumDivide v) => v.label;
  static const Field<NumDivide, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumDivide v) => v.expanded;
  static const Field<NumDivide, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumDivide v) => v.getNode;
  static const Field<NumDivide, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumDivide> fields = const {
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
  final dynamic discriminatorValue = 'num_divide';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumDivide _instantiate(DecodingData data) {
    return NumDivide(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumDivide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumDivide>(map);
  }

  static NumDivide fromJson(String json) {
    return ensureInitialized().decodeJson<NumDivide>(json);
  }
}

mixin NumDivideMappable {
  String toJson() {
    return NumDivideMapper.ensureInitialized()
        .encodeJson<NumDivide>(this as NumDivide);
  }

  Map<String, dynamic> toMap() {
    return NumDivideMapper.ensureInitialized()
        .encodeMap<NumDivide>(this as NumDivide);
  }

  NumDivideCopyWith<NumDivide, NumDivide, NumDivide> get copyWith =>
      _NumDivideCopyWithImpl(this as NumDivide, $identity, $identity);
  @override
  String toString() {
    return NumDivideMapper.ensureInitialized()
        .stringifyValue(this as NumDivide);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumDivideMapper.ensureInitialized()
                .isValueEqual(this as NumDivide, other));
  }

  @override
  int get hashCode {
    return NumDivideMapper.ensureInitialized().hashValue(this as NumDivide);
  }
}

extension NumDivideValueCopy<$R, $Out> on ObjectCopyWith<$R, NumDivide, $Out> {
  NumDivideCopyWith<$R, NumDivide, $Out> get $asNumDivide =>
      $base.as((v, t, t2) => _NumDivideCopyWithImpl(v, t, t2));
}

abstract class NumDivideCopyWith<$R, $In extends NumDivide, $Out>
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
  NumDivideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumDivideCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumDivide, $Out>
    implements NumDivideCopyWith<$R, NumDivide, $Out> {
  _NumDivideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumDivide> $mapper =
      NumDivideMapper.ensureInitialized();
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
  NumDivide $make(CopyWithData data) => NumDivide(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumDivideCopyWith<$R2, NumDivide, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumDivideCopyWithImpl($value, $cast, t);
}
