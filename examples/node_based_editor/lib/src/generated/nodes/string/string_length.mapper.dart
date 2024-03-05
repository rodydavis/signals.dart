// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_length.dart';

class StringLengthMapper extends SubClassMapperBase<StringLength> {
  StringLengthMapper._();

  static StringLengthMapper? _instance;
  static StringLengthMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringLengthMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringLength';

  static int _$id(StringLength v) => v.id;
  static const Field<StringLength, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringLength v) => v.inputs;
  static const Field<StringLength, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringLength v) => v.offset;
  static const Field<StringLength, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringLength v) => v.label;
  static const Field<StringLength, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringLength v) => v.expanded;
  static const Field<StringLength, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringLength v) => v.getNode;
  static const Field<StringLength, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringLength> fields = const {
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
  final dynamic discriminatorValue = 'string_length';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringLength _instantiate(DecodingData data) {
    return StringLength(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringLength fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringLength>(map);
  }

  static StringLength fromJson(String json) {
    return ensureInitialized().decodeJson<StringLength>(json);
  }
}

mixin StringLengthMappable {
  String toJson() {
    return StringLengthMapper.ensureInitialized()
        .encodeJson<StringLength>(this as StringLength);
  }

  Map<String, dynamic> toMap() {
    return StringLengthMapper.ensureInitialized()
        .encodeMap<StringLength>(this as StringLength);
  }

  StringLengthCopyWith<StringLength, StringLength, StringLength> get copyWith =>
      _StringLengthCopyWithImpl(this as StringLength, $identity, $identity);
  @override
  String toString() {
    return StringLengthMapper.ensureInitialized()
        .stringifyValue(this as StringLength);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringLengthMapper.ensureInitialized()
                .isValueEqual(this as StringLength, other));
  }

  @override
  int get hashCode {
    return StringLengthMapper.ensureInitialized()
        .hashValue(this as StringLength);
  }
}

extension StringLengthValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringLength, $Out> {
  StringLengthCopyWith<$R, StringLength, $Out> get $asStringLength =>
      $base.as((v, t, t2) => _StringLengthCopyWithImpl(v, t, t2));
}

abstract class StringLengthCopyWith<$R, $In extends StringLength, $Out>
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
  StringLengthCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringLengthCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringLength, $Out>
    implements StringLengthCopyWith<$R, StringLength, $Out> {
  _StringLengthCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringLength> $mapper =
      StringLengthMapper.ensureInitialized();
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
  StringLength $make(CopyWithData data) => StringLength(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringLengthCopyWith<$R2, StringLength, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringLengthCopyWithImpl($value, $cast, t);
}
