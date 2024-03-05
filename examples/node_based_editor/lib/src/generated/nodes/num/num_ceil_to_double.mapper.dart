// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_ceil_to_double.dart';

class NumCeilToDoubleMapper extends SubClassMapperBase<NumCeilToDouble> {
  NumCeilToDoubleMapper._();

  static NumCeilToDoubleMapper? _instance;
  static NumCeilToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumCeilToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumCeilToDouble';

  static int _$id(NumCeilToDouble v) => v.id;
  static const Field<NumCeilToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumCeilToDouble v) =>
      v.inputs;
  static const Field<NumCeilToDouble, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumCeilToDouble v) => v.offset;
  static const Field<NumCeilToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumCeilToDouble v) => v.label;
  static const Field<NumCeilToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumCeilToDouble v) => v.expanded;
  static const Field<NumCeilToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumCeilToDouble v) => v.getNode;
  static const Field<NumCeilToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumCeilToDouble> fields = const {
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
  final dynamic discriminatorValue = 'num_ceil_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumCeilToDouble _instantiate(DecodingData data) {
    return NumCeilToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumCeilToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumCeilToDouble>(map);
  }

  static NumCeilToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<NumCeilToDouble>(json);
  }
}

mixin NumCeilToDoubleMappable {
  String toJson() {
    return NumCeilToDoubleMapper.ensureInitialized()
        .encodeJson<NumCeilToDouble>(this as NumCeilToDouble);
  }

  Map<String, dynamic> toMap() {
    return NumCeilToDoubleMapper.ensureInitialized()
        .encodeMap<NumCeilToDouble>(this as NumCeilToDouble);
  }

  NumCeilToDoubleCopyWith<NumCeilToDouble, NumCeilToDouble, NumCeilToDouble>
      get copyWith => _NumCeilToDoubleCopyWithImpl(
          this as NumCeilToDouble, $identity, $identity);
  @override
  String toString() {
    return NumCeilToDoubleMapper.ensureInitialized()
        .stringifyValue(this as NumCeilToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumCeilToDoubleMapper.ensureInitialized()
                .isValueEqual(this as NumCeilToDouble, other));
  }

  @override
  int get hashCode {
    return NumCeilToDoubleMapper.ensureInitialized()
        .hashValue(this as NumCeilToDouble);
  }
}

extension NumCeilToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumCeilToDouble, $Out> {
  NumCeilToDoubleCopyWith<$R, NumCeilToDouble, $Out> get $asNumCeilToDouble =>
      $base.as((v, t, t2) => _NumCeilToDoubleCopyWithImpl(v, t, t2));
}

abstract class NumCeilToDoubleCopyWith<$R, $In extends NumCeilToDouble, $Out>
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
  NumCeilToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NumCeilToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumCeilToDouble, $Out>
    implements NumCeilToDoubleCopyWith<$R, NumCeilToDouble, $Out> {
  _NumCeilToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumCeilToDouble> $mapper =
      NumCeilToDoubleMapper.ensureInitialized();
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
  NumCeilToDouble $make(CopyWithData data) => NumCeilToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumCeilToDoubleCopyWith<$R2, NumCeilToDouble, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumCeilToDoubleCopyWithImpl($value, $cast, t);
}
