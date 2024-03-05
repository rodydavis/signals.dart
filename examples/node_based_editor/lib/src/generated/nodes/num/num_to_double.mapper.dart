// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_to_double.dart';

class NumToDoubleMapper extends SubClassMapperBase<NumToDouble> {
  NumToDoubleMapper._();

  static NumToDoubleMapper? _instance;
  static NumToDoubleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumToDoubleMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumToDouble';

  static int _$id(NumToDouble v) => v.id;
  static const Field<NumToDouble, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumToDouble v) => v.inputs;
  static const Field<NumToDouble, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumToDouble v) => v.offset;
  static const Field<NumToDouble, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumToDouble v) => v.label;
  static const Field<NumToDouble, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumToDouble v) => v.expanded;
  static const Field<NumToDouble, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumToDouble v) => v.getNode;
  static const Field<NumToDouble, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumToDouble> fields = const {
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
  final dynamic discriminatorValue = 'num_to_double';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumToDouble _instantiate(DecodingData data) {
    return NumToDouble(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumToDouble fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumToDouble>(map);
  }

  static NumToDouble fromJson(String json) {
    return ensureInitialized().decodeJson<NumToDouble>(json);
  }
}

mixin NumToDoubleMappable {
  String toJson() {
    return NumToDoubleMapper.ensureInitialized()
        .encodeJson<NumToDouble>(this as NumToDouble);
  }

  Map<String, dynamic> toMap() {
    return NumToDoubleMapper.ensureInitialized()
        .encodeMap<NumToDouble>(this as NumToDouble);
  }

  NumToDoubleCopyWith<NumToDouble, NumToDouble, NumToDouble> get copyWith =>
      _NumToDoubleCopyWithImpl(this as NumToDouble, $identity, $identity);
  @override
  String toString() {
    return NumToDoubleMapper.ensureInitialized()
        .stringifyValue(this as NumToDouble);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumToDoubleMapper.ensureInitialized()
                .isValueEqual(this as NumToDouble, other));
  }

  @override
  int get hashCode {
    return NumToDoubleMapper.ensureInitialized().hashValue(this as NumToDouble);
  }
}

extension NumToDoubleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumToDouble, $Out> {
  NumToDoubleCopyWith<$R, NumToDouble, $Out> get $asNumToDouble =>
      $base.as((v, t, t2) => _NumToDoubleCopyWithImpl(v, t, t2));
}

abstract class NumToDoubleCopyWith<$R, $In extends NumToDouble, $Out>
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
  NumToDoubleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumToDoubleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumToDouble, $Out>
    implements NumToDoubleCopyWith<$R, NumToDouble, $Out> {
  _NumToDoubleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumToDouble> $mapper =
      NumToDoubleMapper.ensureInitialized();
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
  NumToDouble $make(CopyWithData data) => NumToDouble(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumToDoubleCopyWith<$R2, NumToDouble, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumToDoubleCopyWithImpl($value, $cast, t);
}
