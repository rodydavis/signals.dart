// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_compare_to.dart';

class StringCompareToMapper extends SubClassMapperBase<StringCompareTo> {
  StringCompareToMapper._();

  static StringCompareToMapper? _instance;
  static StringCompareToMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringCompareToMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringCompareTo';

  static int _$id(StringCompareTo v) => v.id;
  static const Field<StringCompareTo, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringCompareTo v) =>
      v.inputs;
  static const Field<StringCompareTo, Map<String, NodeInput<dynamic>>>
      _f$inputs = Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringCompareTo v) => v.offset;
  static const Field<StringCompareTo, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringCompareTo v) => v.label;
  static const Field<StringCompareTo, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringCompareTo v) => v.expanded;
  static const Field<StringCompareTo, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringCompareTo v) => v.getNode;
  static const Field<StringCompareTo, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringCompareTo> fields = const {
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
  final dynamic discriminatorValue = 'string_compare_to';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringCompareTo _instantiate(DecodingData data) {
    return StringCompareTo(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringCompareTo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringCompareTo>(map);
  }

  static StringCompareTo fromJson(String json) {
    return ensureInitialized().decodeJson<StringCompareTo>(json);
  }
}

mixin StringCompareToMappable {
  String toJson() {
    return StringCompareToMapper.ensureInitialized()
        .encodeJson<StringCompareTo>(this as StringCompareTo);
  }

  Map<String, dynamic> toMap() {
    return StringCompareToMapper.ensureInitialized()
        .encodeMap<StringCompareTo>(this as StringCompareTo);
  }

  StringCompareToCopyWith<StringCompareTo, StringCompareTo, StringCompareTo>
      get copyWith => _StringCompareToCopyWithImpl(
          this as StringCompareTo, $identity, $identity);
  @override
  String toString() {
    return StringCompareToMapper.ensureInitialized()
        .stringifyValue(this as StringCompareTo);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringCompareToMapper.ensureInitialized()
                .isValueEqual(this as StringCompareTo, other));
  }

  @override
  int get hashCode {
    return StringCompareToMapper.ensureInitialized()
        .hashValue(this as StringCompareTo);
  }
}

extension StringCompareToValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringCompareTo, $Out> {
  StringCompareToCopyWith<$R, StringCompareTo, $Out> get $asStringCompareTo =>
      $base.as((v, t, t2) => _StringCompareToCopyWithImpl(v, t, t2));
}

abstract class StringCompareToCopyWith<$R, $In extends StringCompareTo, $Out>
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
  StringCompareToCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _StringCompareToCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringCompareTo, $Out>
    implements StringCompareToCopyWith<$R, StringCompareTo, $Out> {
  _StringCompareToCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringCompareTo> $mapper =
      StringCompareToMapper.ensureInitialized();
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
  StringCompareTo $make(CopyWithData data) => StringCompareTo(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringCompareToCopyWith<$R2, StringCompareTo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringCompareToCopyWithImpl($value, $cast, t);
}
