// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'num_to_string.dart';

class NumToStringMapper extends SubClassMapperBase<NumToString> {
  NumToStringMapper._();

  static NumToStringMapper? _instance;
  static NumToStringMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NumToStringMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'NumToString';

  static int _$id(NumToString v) => v.id;
  static const Field<NumToString, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(NumToString v) => v.inputs;
  static const Field<NumToString, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(NumToString v) => v.offset;
  static const Field<NumToString, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(NumToString v) => v.label;
  static const Field<NumToString, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(NumToString v) => v.expanded;
  static const Field<NumToString, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(NumToString v) => v.getNode;
  static const Field<NumToString, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<NumToString> fields = const {
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
  final dynamic discriminatorValue = 'num_to_string';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static NumToString _instantiate(DecodingData data) {
    return NumToString(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static NumToString fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NumToString>(map);
  }

  static NumToString fromJson(String json) {
    return ensureInitialized().decodeJson<NumToString>(json);
  }
}

mixin NumToStringMappable {
  String toJson() {
    return NumToStringMapper.ensureInitialized()
        .encodeJson<NumToString>(this as NumToString);
  }

  Map<String, dynamic> toMap() {
    return NumToStringMapper.ensureInitialized()
        .encodeMap<NumToString>(this as NumToString);
  }

  NumToStringCopyWith<NumToString, NumToString, NumToString> get copyWith =>
      _NumToStringCopyWithImpl(this as NumToString, $identity, $identity);
  @override
  String toString() {
    return NumToStringMapper.ensureInitialized()
        .stringifyValue(this as NumToString);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NumToStringMapper.ensureInitialized()
                .isValueEqual(this as NumToString, other));
  }

  @override
  int get hashCode {
    return NumToStringMapper.ensureInitialized().hashValue(this as NumToString);
  }
}

extension NumToStringValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NumToString, $Out> {
  NumToStringCopyWith<$R, NumToString, $Out> get $asNumToString =>
      $base.as((v, t, t2) => _NumToStringCopyWithImpl(v, t, t2));
}

abstract class NumToStringCopyWith<$R, $In extends NumToString, $Out>
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
  NumToStringCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NumToStringCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NumToString, $Out>
    implements NumToStringCopyWith<$R, NumToString, $Out> {
  _NumToStringCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NumToString> $mapper =
      NumToStringMapper.ensureInitialized();
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
  NumToString $make(CopyWithData data) => NumToString(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  NumToStringCopyWith<$R2, NumToString, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NumToStringCopyWithImpl($value, $cast, t);
}
