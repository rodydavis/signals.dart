// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_starts_with.dart';

class StringStartsWithMapper extends SubClassMapperBase<StringStartsWith> {
  StringStartsWithMapper._();

  static StringStartsWithMapper? _instance;
  static StringStartsWithMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringStartsWithMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringStartsWith';

  static int _$id(StringStartsWith v) => v.id;
  static const Field<StringStartsWith, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringStartsWith v) =>
      v.inputs;
  static const Field<StringStartsWith, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringStartsWith v) => v.offset;
  static const Field<StringStartsWith, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringStartsWith v) => v.label;
  static const Field<StringStartsWith, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringStartsWith v) => v.expanded;
  static const Field<StringStartsWith, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringStartsWith v) => v.getNode;
  static const Field<StringStartsWith, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringStartsWith> fields = const {
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
  final dynamic discriminatorValue = 'string_starts_with';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringStartsWith _instantiate(DecodingData data) {
    return StringStartsWith(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringStartsWith fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringStartsWith>(map);
  }

  static StringStartsWith fromJson(String json) {
    return ensureInitialized().decodeJson<StringStartsWith>(json);
  }
}

mixin StringStartsWithMappable {
  String toJson() {
    return StringStartsWithMapper.ensureInitialized()
        .encodeJson<StringStartsWith>(this as StringStartsWith);
  }

  Map<String, dynamic> toMap() {
    return StringStartsWithMapper.ensureInitialized()
        .encodeMap<StringStartsWith>(this as StringStartsWith);
  }

  StringStartsWithCopyWith<StringStartsWith, StringStartsWith, StringStartsWith>
      get copyWith => _StringStartsWithCopyWithImpl(
          this as StringStartsWith, $identity, $identity);
  @override
  String toString() {
    return StringStartsWithMapper.ensureInitialized()
        .stringifyValue(this as StringStartsWith);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringStartsWithMapper.ensureInitialized()
                .isValueEqual(this as StringStartsWith, other));
  }

  @override
  int get hashCode {
    return StringStartsWithMapper.ensureInitialized()
        .hashValue(this as StringStartsWith);
  }
}

extension StringStartsWithValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringStartsWith, $Out> {
  StringStartsWithCopyWith<$R, StringStartsWith, $Out>
      get $asStringStartsWith =>
          $base.as((v, t, t2) => _StringStartsWithCopyWithImpl(v, t, t2));
}

abstract class StringStartsWithCopyWith<$R, $In extends StringStartsWith, $Out>
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
  StringStartsWithCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringStartsWithCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringStartsWith, $Out>
    implements StringStartsWithCopyWith<$R, StringStartsWith, $Out> {
  _StringStartsWithCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringStartsWith> $mapper =
      StringStartsWithMapper.ensureInitialized();
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
  StringStartsWith $make(CopyWithData data) => StringStartsWith(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringStartsWithCopyWith<$R2, StringStartsWith, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringStartsWithCopyWithImpl($value, $cast, t);
}
