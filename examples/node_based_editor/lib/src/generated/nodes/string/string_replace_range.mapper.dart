// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_replace_range.dart';

class StringReplaceRangeMapper extends SubClassMapperBase<StringReplaceRange> {
  StringReplaceRangeMapper._();

  static StringReplaceRangeMapper? _instance;
  static StringReplaceRangeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringReplaceRangeMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringReplaceRange';

  static int _$id(StringReplaceRange v) => v.id;
  static const Field<StringReplaceRange, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringReplaceRange v) =>
      v.inputs;
  static const Field<StringReplaceRange, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringReplaceRange v) => v.offset;
  static const Field<StringReplaceRange, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringReplaceRange v) => v.label;
  static const Field<StringReplaceRange, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringReplaceRange v) => v.expanded;
  static const Field<StringReplaceRange, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringReplaceRange v) => v.getNode;
  static const Field<StringReplaceRange, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringReplaceRange> fields = const {
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
  final dynamic discriminatorValue = 'string_replace_range';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringReplaceRange _instantiate(DecodingData data) {
    return StringReplaceRange(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringReplaceRange fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringReplaceRange>(map);
  }

  static StringReplaceRange fromJson(String json) {
    return ensureInitialized().decodeJson<StringReplaceRange>(json);
  }
}

mixin StringReplaceRangeMappable {
  String toJson() {
    return StringReplaceRangeMapper.ensureInitialized()
        .encodeJson<StringReplaceRange>(this as StringReplaceRange);
  }

  Map<String, dynamic> toMap() {
    return StringReplaceRangeMapper.ensureInitialized()
        .encodeMap<StringReplaceRange>(this as StringReplaceRange);
  }

  StringReplaceRangeCopyWith<StringReplaceRange, StringReplaceRange,
          StringReplaceRange>
      get copyWith => _StringReplaceRangeCopyWithImpl(
          this as StringReplaceRange, $identity, $identity);
  @override
  String toString() {
    return StringReplaceRangeMapper.ensureInitialized()
        .stringifyValue(this as StringReplaceRange);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringReplaceRangeMapper.ensureInitialized()
                .isValueEqual(this as StringReplaceRange, other));
  }

  @override
  int get hashCode {
    return StringReplaceRangeMapper.ensureInitialized()
        .hashValue(this as StringReplaceRange);
  }
}

extension StringReplaceRangeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringReplaceRange, $Out> {
  StringReplaceRangeCopyWith<$R, StringReplaceRange, $Out>
      get $asStringReplaceRange =>
          $base.as((v, t, t2) => _StringReplaceRangeCopyWithImpl(v, t, t2));
}

abstract class StringReplaceRangeCopyWith<$R, $In extends StringReplaceRange,
    $Out> implements BaseNodeCopyWith<$R, $In, $Out> {
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
  StringReplaceRangeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringReplaceRangeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringReplaceRange, $Out>
    implements StringReplaceRangeCopyWith<$R, StringReplaceRange, $Out> {
  _StringReplaceRangeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringReplaceRange> $mapper =
      StringReplaceRangeMapper.ensureInitialized();
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
  StringReplaceRange $make(CopyWithData data) => StringReplaceRange(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringReplaceRangeCopyWith<$R2, StringReplaceRange, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringReplaceRangeCopyWithImpl($value, $cast, t);
}
