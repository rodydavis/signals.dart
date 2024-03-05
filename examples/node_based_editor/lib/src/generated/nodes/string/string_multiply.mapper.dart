// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_multiply.dart';

class StringMultiplyMapper extends SubClassMapperBase<StringMultiply> {
  StringMultiplyMapper._();

  static StringMultiplyMapper? _instance;
  static StringMultiplyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringMultiplyMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringMultiply';

  static int _$id(StringMultiply v) => v.id;
  static const Field<StringMultiply, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringMultiply v) => v.inputs;
  static const Field<StringMultiply, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringMultiply v) => v.offset;
  static const Field<StringMultiply, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringMultiply v) => v.label;
  static const Field<StringMultiply, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringMultiply v) => v.expanded;
  static const Field<StringMultiply, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringMultiply v) => v.getNode;
  static const Field<StringMultiply, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringMultiply> fields = const {
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
  final dynamic discriminatorValue = 'string_multiply';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringMultiply _instantiate(DecodingData data) {
    return StringMultiply(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringMultiply fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringMultiply>(map);
  }

  static StringMultiply fromJson(String json) {
    return ensureInitialized().decodeJson<StringMultiply>(json);
  }
}

mixin StringMultiplyMappable {
  String toJson() {
    return StringMultiplyMapper.ensureInitialized()
        .encodeJson<StringMultiply>(this as StringMultiply);
  }

  Map<String, dynamic> toMap() {
    return StringMultiplyMapper.ensureInitialized()
        .encodeMap<StringMultiply>(this as StringMultiply);
  }

  StringMultiplyCopyWith<StringMultiply, StringMultiply, StringMultiply>
      get copyWith => _StringMultiplyCopyWithImpl(
          this as StringMultiply, $identity, $identity);
  @override
  String toString() {
    return StringMultiplyMapper.ensureInitialized()
        .stringifyValue(this as StringMultiply);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringMultiplyMapper.ensureInitialized()
                .isValueEqual(this as StringMultiply, other));
  }

  @override
  int get hashCode {
    return StringMultiplyMapper.ensureInitialized()
        .hashValue(this as StringMultiply);
  }
}

extension StringMultiplyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringMultiply, $Out> {
  StringMultiplyCopyWith<$R, StringMultiply, $Out> get $asStringMultiply =>
      $base.as((v, t, t2) => _StringMultiplyCopyWithImpl(v, t, t2));
}

abstract class StringMultiplyCopyWith<$R, $In extends StringMultiply, $Out>
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
  StringMultiplyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringMultiplyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringMultiply, $Out>
    implements StringMultiplyCopyWith<$R, StringMultiply, $Out> {
  _StringMultiplyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringMultiply> $mapper =
      StringMultiplyMapper.ensureInitialized();
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
  StringMultiply $make(CopyWithData data) => StringMultiply(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringMultiplyCopyWith<$R2, StringMultiply, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringMultiplyCopyWithImpl($value, $cast, t);
}
