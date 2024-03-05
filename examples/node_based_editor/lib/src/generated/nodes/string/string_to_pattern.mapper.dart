// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_to_pattern.dart';

class StringToPatternMapper extends SubClassMapperBase<StringToPattern> {
  StringToPatternMapper._();

  static StringToPatternMapper? _instance;
  static StringToPatternMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringToPatternMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringToPattern';

  static int _$id(StringToPattern v) => v.id;
  static const Field<StringToPattern, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringToPattern v) =>
      v.inputs;
  static const Field<StringToPattern, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringToPattern v) => v.offset;
  static const Field<StringToPattern, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringToPattern v) => v.label;
  static const Field<StringToPattern, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringToPattern v) => v.expanded;
  static const Field<StringToPattern, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringToPattern v) => v.getNode;
  static const Field<StringToPattern, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringToPattern> fields = const {
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
  final dynamic discriminatorValue = 'string_to_pattern';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringToPattern _instantiate(DecodingData data) {
    return StringToPattern(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringToPattern fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringToPattern>(map);
  }

  static StringToPattern fromJson(String json) {
    return ensureInitialized().decodeJson<StringToPattern>(json);
  }
}

mixin StringToPatternMappable {
  String toJson() {
    return StringToPatternMapper.ensureInitialized()
        .encodeJson<StringToPattern>(this as StringToPattern);
  }

  Map<String, dynamic> toMap() {
    return StringToPatternMapper.ensureInitialized()
        .encodeMap<StringToPattern>(this as StringToPattern);
  }

  StringToPatternCopyWith<StringToPattern, StringToPattern, StringToPattern>
      get copyWith => _StringToPatternCopyWithImpl(
          this as StringToPattern, $identity, $identity);
  @override
  String toString() {
    return StringToPatternMapper.ensureInitialized()
        .stringifyValue(this as StringToPattern);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringToPatternMapper.ensureInitialized()
                .isValueEqual(this as StringToPattern, other));
  }

  @override
  int get hashCode {
    return StringToPatternMapper.ensureInitialized()
        .hashValue(this as StringToPattern);
  }
}

extension StringToPatternValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringToPattern, $Out> {
  StringToPatternCopyWith<$R, StringToPattern, $Out> get $asStringToPattern =>
      $base.as((v, t, t2) => _StringToPatternCopyWithImpl(v, t, t2));
}

abstract class StringToPatternCopyWith<$R, $In extends StringToPattern, $Out>
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
  StringToPatternCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringToPatternCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringToPattern, $Out>
    implements StringToPatternCopyWith<$R, StringToPattern, $Out> {
  _StringToPatternCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringToPattern> $mapper =
      StringToPatternMapper.ensureInitialized();
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
  StringToPattern $make(CopyWithData data) => StringToPattern(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringToPatternCopyWith<$R2, StringToPattern, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringToPatternCopyWithImpl($value, $cast, t);
}
