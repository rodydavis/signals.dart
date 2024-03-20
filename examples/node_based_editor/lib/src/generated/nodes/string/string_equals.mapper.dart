// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'string_equals.dart';

class StringEqualsMapper extends SubClassMapperBase<StringEquals> {
  StringEqualsMapper._();

  static StringEqualsMapper? _instance;
  static StringEqualsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StringEqualsMapper._());
      BaseNodeMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals
          .useAll([SignalMapper(), ReadonlySignalMapper(), InputMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'StringEquals';

  static int _$id(StringEquals v) => v.id;
  static const Field<StringEquals, int> _f$id = Field('id', _$id);
  static Map<String, NodeInput<dynamic>> _$inputs(StringEquals v) => v.inputs;
  static const Field<StringEquals, Map<String, NodeInput<dynamic>>> _f$inputs =
      Field('inputs', _$inputs);
  static Signal<NodeOffset> _$offset(StringEquals v) => v.offset;
  static const Field<StringEquals, Signal<NodeOffset>> _f$offset =
      Field('offset', _$offset);
  static Signal<String> _$label(StringEquals v) => v.label;
  static const Field<StringEquals, Signal<String>> _f$label =
      Field('label', _$label);
  static Signal<bool> _$expanded(StringEquals v) => v.expanded;
  static const Field<StringEquals, Signal<bool>> _f$expanded =
      Field('expanded', _$expanded);
  static BaseNode? Function(int) _$getNode(StringEquals v) => v.getNode;
  static const Field<StringEquals, BaseNode Function(int)> _f$getNode =
      Field('getNode', _$getNode, mode: FieldMode.member);

  @override
  final MappableFields<StringEquals> fields = const {
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
  final dynamic discriminatorValue = 'string_equals';
  @override
  late final ClassMapperBase superMapper = BaseNodeMapper.ensureInitialized();

  static StringEquals _instantiate(DecodingData data) {
    return StringEquals(
        id: data.dec(_f$id),
        inputs: data.dec(_f$inputs),
        offset: data.dec(_f$offset),
        label: data.dec(_f$label),
        expanded: data.dec(_f$expanded));
  }

  @override
  final Function instantiate = _instantiate;

  static StringEquals fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StringEquals>(map);
  }

  static StringEquals fromJson(String json) {
    return ensureInitialized().decodeJson<StringEquals>(json);
  }
}

mixin StringEqualsMappable {
  String toJson() {
    return StringEqualsMapper.ensureInitialized()
        .encodeJson<StringEquals>(this as StringEquals);
  }

  Map<String, dynamic> toMap() {
    return StringEqualsMapper.ensureInitialized()
        .encodeMap<StringEquals>(this as StringEquals);
  }

  StringEqualsCopyWith<StringEquals, StringEquals, StringEquals> get copyWith =>
      _StringEqualsCopyWithImpl(this as StringEquals, $identity, $identity);
  @override
  String toString() {
    return StringEqualsMapper.ensureInitialized()
        .stringifyValue(this as StringEquals);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            StringEqualsMapper.ensureInitialized()
                .isValueEqual(this as StringEquals, other));
  }

  @override
  int get hashCode {
    return StringEqualsMapper.ensureInitialized()
        .hashValue(this as StringEquals);
  }
}

extension StringEqualsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StringEquals, $Out> {
  StringEqualsCopyWith<$R, StringEquals, $Out> get $asStringEquals =>
      $base.as((v, t, t2) => _StringEqualsCopyWithImpl(v, t, t2));
}

abstract class StringEqualsCopyWith<$R, $In extends StringEquals, $Out>
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
  StringEqualsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StringEqualsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StringEquals, $Out>
    implements StringEqualsCopyWith<$R, StringEquals, $Out> {
  _StringEqualsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StringEquals> $mapper =
      StringEqualsMapper.ensureInitialized();
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
  StringEquals $make(CopyWithData data) => StringEquals(
      id: data.get(#id, or: $value.id),
      inputs: data.get(#inputs, or: $value.inputs),
      offset: data.get(#offset, or: $value.offset),
      label: data.get(#label, or: $value.label),
      expanded: data.get(#expanded, or: $value.expanded));

  @override
  StringEqualsCopyWith<$R2, StringEquals, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _StringEqualsCopyWithImpl($value, $cast, t);
}
