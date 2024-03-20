// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_ends_with.dart';

class StringEndsWithMapper extends SubClassMapperBase<StringEndsWith> {
  StringEndsWithMapper._();

  static StringEndsWithMapper? _instance;
  static StringEndsWithMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringEndsWithMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringEndsWith';

  static int _$id(StringEndsWith v) => v.id;
  static const Field<StringEndsWith, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringEndsWith v) => v.inputs;
  static const Field<StringEndsWith, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringEndsWith v) => v.offset;
  static const Field<StringEndsWith, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringEndsWith v) => v.label;
  static const Field<StringEndsWith, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringEndsWith v) => v.expanded;
  static const Field<StringEndsWith, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringEndsWith v) => v.getNode;
  static const Field<StringEndsWith, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringEndsWith> fields = const {
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
  final dynamic discriminatorValue = 'string_ends_with';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringEndsWith _instantiate(DecodingData data) {
    return StringEndsWith(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringEndsWith fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringEndsWith>(map);
  }

  static StringEndsWith fromJson(String json) {
    return ensureInitialized().decodeJson<StringEndsWith>(json);
  }
}

mixin StringEndsWithMappable {
  String toJson() {
    return StringEndsWithMapper.ensureInitialized()
        .encodeJson<StringEndsWith>(this as StringEndsWith);
  }

  Map<String, dynamic> toMap() {
    return StringEndsWithMapper.ensureInitialized()
        .encodeMap<StringEndsWith>(this as StringEndsWith);
  }

  StringEndsWithCopyWith<StringEndsWith, StringEndsWith, StringEndsWith>
      get copyWith => _StringEndsWithCopyWithImpl(
          this as StringEndsWith, $identity, $identity);
  @override
  String toString() {
    return StringEndsWithMapper.ensureInitialized()
        .stringifyValue(this as StringEndsWith);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringEndsWithMapper.ensureInitialized()
                .isValueEqual(this as StringEndsWith, other));
  }

  @override
  int get hashCode {
    return StringEndsWithMapper.ensureInitialized()
        .hashValue(this as StringEndsWith);
  }
}

extension StringEndsWithValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringEndsWith, $Out> {
  StringEndsWithCopyWith<$R, StringEndsWith, $Out> get $asStringEndsWith =>
      $base.as((v, t, t2) => _StringEndsWithCopyWithImpl(v, t, t2));
}

abstract class StringEndsWithCopyWith<$R, $In extends StringEndsWith, $Out>
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
  StringEndsWithCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringEndsWithCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringEndsWith, $Out>
    implements StringEndsWithCopyWith<$R, StringEndsWith, $Out> {
  _StringEndsWithCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringEndsWith> $mapper =
      StringEndsWithMapper.ensureInitialized();
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
  StringEndsWith $make(CopyWithData data) => StringEndsWith(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringEndsWithCopyWith<$R2, StringEndsWith, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringEndsWithCopyWithImpl($value, $cast, t);
}
